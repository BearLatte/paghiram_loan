import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/auth_state_entity.dart';
import 'package:paghiram_loan/models/id_card_type_entity.dart';
import 'package:paghiram_loan/models/ocr_recgnized_entity.dart';
import 'package:paghiram_loan/models/pgm_photo_entity.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:paghiram_loan/models/submited_ocr_model_entity.dart';
import 'package:paghiram_loan/network/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/md5_util.dart';
import 'package:paghiram_loan/util/random_util.dart';
import '../models/aliyun_key_entity.dart';
import '../models/base_response.dart';
import '../util/global.dart';

enum VerifyCodeType { login, register, changePassword }

class NetworkService {
  // get homepage data
  static Future<BaseResponse?> fetchHomeData() async {
    return await HttpUtils.get<List<ProductModelEntity>>(path: '/Home/index');
  }

  // send verify code
  static void sendVerifyCode({required String phoneNumber, VerifyCodeType type = VerifyCodeType.login, required void Function() successCallback}) async {
    String path;
    switch (type) {
      case VerifyCodeType.register:
        path = '/Reg/send_verify_code';
      case VerifyCodeType.changePassword:
        path = '/Login/send_verify_code';
      case VerifyCodeType.login:
        path = '/Login/sms_login_code';
    }
    BaseResponse? response = await HttpUtils.post(path: path, data: {'phone': phoneNumber});
    if (response?.code != 200) {
      return;
    }
    successCallback();
  }

  // Check if the mobile phone number available, 201 can register, 202 can login
  static Future<bool> checkIfPhoneNumberAvailable({required String phone, required String verifyCode}) async {
    BaseResponse? response = await HttpUtils.get(path: '/Reg/tel_status', queryParameters: {'phone': phone, 'code': verifyCode});
    if (response?.code == 201) return true;
    CommonSnackBar.showSnackBar(response?.error, type: SnackType.error);
    return false;
  }

  // before login check devices risk
  static Future<int?> checkDeviceRisk({required String phone, required String password}) async {
    BaseResponse? response = await HttpUtils.post(path: '/Login/login_risk_control', data: {
      'phone': phone,
      'password': password,
      'dev_id': MD5Util.md5Encode(
        Global.deviceUUID,
      )
    });
    if (response == null) return null;
    return response?.data['code_type'];
  }

  // register
  static void register({required String phone, required String verifyCode, required String password, required void Function() successCallback}) async {
    var response = await HttpUtils.post(
        path: '/Reg/register',
        data: {'phone': phone, 'password': password, 'code': verifyCode, 'type': '2', 'version': Global.appVersion, 'tel_device_id': MD5Util.md5Encode(Global.deviceUUID)});
    if (response?.code == 200) return successCallback();
    CommonSnackBar.showSnackBar(response?.error, type: SnackType.error);
  }

  // login
  static void login({required String phoneNumber, required password, String? verifyCode, required void Function(Map<String, dynamic>) successCallback}) async {
    BaseResponse? response = await HttpUtils.post(path: '/Login/index', data: {
      'phone': phoneNumber,
      'password': password,
      'type': '2',
      'sms_code': verifyCode,
      'version': Global.appVersion,
      'tel_device_id': MD5Util.md5Encode(Global.deviceUUID),
    });

    if (response != null) {
      successCallback(response.data);
    }
  }

  // check if the phone number and verify code valid
  static Future<bool> checkIfPhoneAndVerifyCodeAvailable({required String phone, required String verifyCode}) async {
    BaseResponse? response = await HttpUtils.get(path: '/Login/check_phone_verification', queryParameters: {'phone': phone, 'code': verifyCode});
    if (response?.code == 200) return true;
    CommonSnackBar.showSnackBar(response?.error, type: SnackType.error);
    return false;
  }

  // change password
  static Future<bool> changePassword({required String phone, required String verifyCode, required String newPassword}) async {
    BaseResponse? response = await HttpUtils.post(path: '/Login/save_new_password', data: {
      'phone': phone,
      'pass_one': newPassword,
      'pass_two': newPassword,
      'code': verifyCode,
    });
    if (response?.code == 200) return true;
    return false;
  }

  // get certification alert content
  static Future<String> fetchCertificationSheetContent() async {
    BaseResponse? response = await HttpUtils.get(path: '/UserBaseData/getBaseItem');
    return response?.originalData ?? '';
  }

  // get auth status
  static Future<AuthStateEntity?> fetchAuthStatus() async {
    BaseResponse? response = await HttpUtils.get<AuthStateEntity>(path: '/ProductApply/index');
    if (response != null) {
      return response?.data;
    } else {
      return null;
    }
  }

  static void submitBasicInfo(Map<String, dynamic> parameters, {required void Function() successCallback}) async {
    String baseDataStr = jsonEncode(parameters);
    BaseResponse? response = await HttpUtils.post(path: '/UserBaseData/add', data: {'user_base_data': baseDataStr});
    if (response?.code == 200) {
      successCallback();
    }
  }

  // get liveness token
  static Future<String> fetchLivenessToken() async {
    BaseResponse? response = await HttpUtils.get(path: '/Licensepgm/get_licensepgm');
    return response?.data['license'] ?? '';
  }

  // get card type
  static Future<List<IdCardTypeEntity>> fetchCardType() async {
    BaseResponse? response = await HttpUtils.get<List<IdCardTypeEntity>>(path: '/OptionPhoto/cert_type');
    return response?.data ?? [];
  }

  // get face photo
  static Future<PgmPhotoEntity> fetchFacePhoto() async {
    BaseResponse? response = await HttpUtils.post<PgmPhotoEntity>(path: '/UserCard/pgm_ocr_live');
    return response?.data;
  }

  // get aliyun key
  static Future<AliyunKeyEntity> fetchAliyunKey() async {
    BaseResponse? response = await HttpUtils.get<AliyunKeyEntity>(path: '/GetAccessKey/index');
    return response?.data;
  }

  // aliyun upload image
  static Future<Map<String, String>?> aliyunUploadImge(String imgPath, {int type = 1}) async {
    EasyLoading.show(status: 'uploading...', maskType: EasyLoadingMaskType.black);
    AliyunKeyEntity keyModel = await fetchAliyunKey();
    Client client = Client.init(
      ossEndpoint: Constant.ALIYUN_ENDPOINT,
      bucketName: Constant.BUCKET_NAME,
      dio: Dio(BaseOptions(connectTimeout: Duration(milliseconds: 9000))),
      authGetter: () => Auth(accessKey: keyModel.accessKeyId, accessSecret: keyModel.accessKeySecret, secureToken: keyModel.securityToken, expire: keyModel.expiration),
    );

    Uint8List fileData = await File(imgPath).readAsBytes();
    String namePrefix = type == 1 ? 'face_' : 'idCard_';
    String fileName = 'PGM_$namePrefix${MD5Util.md5Encode(RandomUtil.generateRandomString(16))}.jpg';
    final result = await client.putObject(fileData, fileName, option: PutRequestOption(bucketName: 'paghiram'));
    if (result.statusCode != 200) {
      CommonSnackBar.showSnackBar(result.statusMessage, type: SnackType.error);
      return null;
    }
    EasyLoading.dismiss();
    return {'sortPath': fileName, 'fullPath': 'https://${Constant.BUCKET_NAME}.${Constant.ALIYUN_ENDPOINT}/$fileName'};
  }

  static void uploadedImgInformImgName2server(String imgName, String livenessId, {void Function()? successCallback}) async {
    BaseResponse? response = await HttpUtils.post(path: '/UserCard/upload_photo', data: {'photo_file': imgName, 'liveness_id': livenessId, 'card_type': '', 'type': '1'});
    if (response != null) successCallback!();
  }

  // Card ocr
  static Future<OcrRecgnizedEntity> ocrRecgnizer(String imgPath, String cardType) async {
    BaseResponse? response =
        await HttpUtils.post<OcrRecgnizedEntity>(path: '/OptionPhoto/cert_img_ad', data: {'img': imgPath, 'card_type': cardType, 'liveness_id': '', 'type': '2'});
    return response?.data;
  }

  static Future<void> submitIDCardInfo(
      {required String idCardNum,
      required String firstName,
      String? midName,
      required String lastName,
      required String type,
      required String gender,
      required String birthday,
      required void Function() successCallback}) async {
    Map<String, String> params = {'mobile_mode': 'iPhone', 'aoid': '2', 'go_id': '2'};
    params['first_name'] = firstName;
    params['middle_name'] = midName ?? '';
    params['last_name'] = lastName;
    params['card_id_number'] = idCardNum;
    params['type'] = type;
    params['gender'] = gender;
    params['birthday'] = birthday;
    BaseResponse? response = await HttpUtils.post(path: '/UserCard/add', data: params);
    if (response != null) successCallback();
  }

  // submit all certification info
  static Future<void> submitCertificationInfo(String productId, void Function() successCallback) async {
    BaseResponse? response = await HttpUtils.post(path: '/ProductApply/add', data: {'product_id': productId});
    if (response != null) successCallback();
  }

  // submit feedback Info
  static Future<void> submitFeedback(Map<String, dynamic> params, void Function() successCallback) async {
    BaseResponse? response = await HttpUtils.post(path: '/Quiz/save', data: params);
    if (response == null) return;
    successCallback();
  }

  static Future<String?> getCustomerServiceOnlineUrl() async {
    BaseResponse? response = await HttpUtils.post(path: '/Login/get_info');
    return response?.data['fbu'];
  }

  // delete account
  static Future<void> deleteAccount({required String password, required void Function() successCallback}) async {
    BaseResponse? response = await HttpUtils.get(path: '/Login/cancel_user_new', queryParameters: {'password': password});
    if (response != null) successCallback();
  }

  // get id card ocr rollback information
  static Future<SubmitedOcrModelEntity?> fetchOCRRollbackInformation() async {
    BaseResponse? response = await HttpUtils.get<SubmitedOcrModelEntity>(path: '/UserCard/index');
    return response?.data;
  }

  // resubmit ID Card photo
  static resubmitIDCard(Map<String, dynamic> parameters, {required void Function() successCallback}) async {
   BaseResponse? response = await HttpUtils.post(path: '/UserCard/back_card', data: parameters);
   if(response != null) successCallback();
  }

  static Future<void> buryPoint() async {

  }
}
