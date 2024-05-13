import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/base_response.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/util/global.dart';
import 'http_request.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pointycastle/asymmetric/api.dart';

class HttpUtils {
  static HttpRequest httpRequest = HttpRequest();

  // get
  static Future<BaseResponse?> get<T>({required String path, Map<String, dynamic>? queryParameters, bool showLoading = true, bool showErrorMessage = true}) async {
    var params = await _configParameters(queryParameters, null);
    String? responseStr = await httpRequest.request(path: path, method: HttpMethod.get, queryParameters: params, showLoading: showLoading, showErrorMessage: showErrorMessage);
    if (responseStr == null) return null;
    BaseResponse response = BaseResponse<T>.fromJson(jsonDecode(responseStr));
    response.originalData = responseStr;

    if (path == '/UserBaseData/getBaseItem') return response;

    if (response.code == 103) {
      CommonSnackBar.showSnackBar('Login status is invalid, please log in again', type: SnackType.info);
      Global.clearLoginInfo();
      Get.toNamed(ApplicationRoutes.login);
      return null;
    }

    if (response.code != 200 && path != '/Reg/tel_status') {
      EasyLoading.showError(response.error ?? '');
      return null;
    }

    return response;
  }

  // post
  static Future<BaseResponse?> post<T>({required String path, Map<String, dynamic>? data, bool showLoading = true, bool showErrorMessage = true}) async {
    data = await _configParameters(data, path);
    String responseStr = await httpRequest.request(path: path, method: HttpMethod.post, data: data, showLoading: showLoading, showErrorMessage: showErrorMessage);
    BaseResponse<T> response = BaseResponse<T>.fromJson(jsonDecode(responseStr));
    if (response.code == 103) {
      EasyLoading.showInfo('Login status is invalid, please log in again');
      Global.clearLoginInfo();
      Get.toNamed(ApplicationRoutes.login);
      return null;
    }
    if (response.code != 200) {
      EasyLoading.showError(response.error ?? '');
      return null;
    }
    return response;
  }

  static Future<Map<String, dynamic>> _configParameters(Map<String, dynamic>? params, String? path) async {
    if (params == null) {
      params = {};
    }

    for (var key in params.keys) {
      if (key == 'phone' && RegExp('^0').hasMatch(params[key])) {
        params[key] = (params[key] as String).substring(1);
      }

      if (path == '/Quiz/save' && key == 'photo') {
      } else {
        var result = await Global.channel.invokeMapMethod('cryptoAES', {'secretKey': Global.deviceUUID, 'plaintText': params[key]});
        params[key] = result!['cryptedText'];
      }
    }

    params['pgm_key'] = await _generateRSAKey();
    if (Global.isLogin) {
      params['token'] = Global.accessToken;
    }
    return params;
  }

  static Future<String> _generateRSAKey() async {
    final publicKeyStr = await rootBundle.loadString('asset/keys/public_key.pem');
    final publicKey = RSAKeyParser().parse(publicKeyStr) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey, digest: RSADigest.SHA256));
    var encrypted = encrypter.encrypt(Global.deviceUUID).base64;
    return base64Encode(utf8.encode(encrypted));
  }
}
