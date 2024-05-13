import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paghiram_loan/common/common_alert.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/id_card_type_entity.dart';
import 'package:paghiram_loan/models/ocr_recgnized_entity.dart';
import 'package:paghiram_loan/models/pgm_photo_entity.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/router/application_routes.dart';

import '../util/global.dart';

class CardOcrController extends GetxController {
  var cardType = ''.obs;
  var selectedGender = ''.obs;
  var livenessImg = 'asset/icons/liveness_placeholder.png'.obs;
  var cardImg = 'asset/icons/card_placeholder.png'.obs;
  var cardNumController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var midNameController = TextEditingController();
  var birth = ''.obs;

  late List<IdCardTypeEntity> idCardTypes;
  IdCardTypeEntity? selectedCardType;

  @override
  void onReady() async {
    super.onReady();
    _getCameraAuthStatus();
    _getNetworkData();

    Global.channel.setMethodCallHandler((call) async {
      if (call.method == 'takePhotoCompleted') {
        takePhotoCompletedHandler(call.arguments);
      }
    });
  }

  Future<bool> _getCameraAuthStatus() async {
    var status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      String result = await CommonAlert.showAlert(
        title: 'Camera authorization',
        message: 'Upload your ID document photo. Please ensure camera access is enabled in your system settings.',
      );
      if (result == 'confirm') {
        openAppSettings();
      }
      return false;
    }
    return true;
  }
  
  void backAction() async {
    String result = await CommonAlert.showAlert(title: 'Warm Reminder',message: 'You have not finished filling in the authentication information. Still return it?');
    if(result == 'confirm') {
      Get.until((route) => route.settings.name == ApplicationRoutes.certificationIndex);
    }
  }

  void _getNetworkData() async {
    idCardTypes = await NetworkService.fetchCardType();
    PgmPhotoEntity photo = await NetworkService.fetchFacePhoto();
    livenessImg.value = photo.pgmPhoto == '' ? 'asset/icons/liveness_placeholder.png' : photo.pgmPhoto;
  }

  void go2customerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });

  void go2doingLiveness() async {
    if (livenessImg.value == 'asset/icons/liveness_placeholder.png') {
      if (await _getCameraAuthStatus()) {
        var result = await Get.toNamed(ApplicationRoutes.livenessInstructions);
        if (result == null) return;
        String base64Str = result['base64Image'];
        if (base64Str != null) {
          String base64Img = base64Str.replaceAll(RegExp(r'\s+'), '');
          var documentDir = await getApplicationDocumentsDirectory();
          String filePath = '${documentDir.path}/${Constant.LIVENESS_IMG_NAME_KEY}';
          File file = await File(filePath);
          await file.writeAsBytes(base64Decode(base64Img));

          Map? imgPaths = await NetworkService.aliyunUploadImge(filePath, type: 1);

          if (imgPaths != null) {
            NetworkService.uploadedImgInformImgName2server(imgPaths['sortPath'], result['livenessId'], successCallback: () {
              livenessImg.value = imgPaths['fullPath'];
            });
          }
        }
      }
    }
  }

  void submitAction() {
    if (livenessImg.value == 'asset/icons/liveness_placeholder.png') {
      return CommonSnackBar.showSnackBar('Please perform facial recognition');
    }

    if (cardImg.value == 'asset/icons/card_placeholder.png') {
      return CommonSnackBar.showSnackBar('Please upload your ID photo.');
    }

    String curCardType = cardType.value;
    String idNum = cardNumController.text.trim();
    String fName = firstNameController.text.trim();
    String mName = midNameController.text.trim();
    String lName = lastNameController.text.trim();
    String type = (selectedCardType?.title ?? '').trim();
    String gender = selectedGender.value.trim();
    String birthday = birth.value.trim();

    if (idNum.isEmpty) {
      return CommonSnackBar.showSnackBar('Please input your Document ID Number!');
    }

    if (fName.isEmpty) {
      return CommonSnackBar.showSnackBar('Please input your first name!');
    }

    if (lName.isEmpty) {
      return CommonSnackBar.showSnackBar('Please input your last name!');
    }

    if (type.isEmpty) {
      return CommonSnackBar.showSnackBar('Please select your ID Card type!');
    }
    if (gender.isEmpty) {
      return CommonSnackBar.showSnackBar('Please select your gender!');
    }
    if (birthday.isEmpty) {
      return CommonSnackBar.showSnackBar('Please select your birthday!');
    }

    switch (curCardType) {
      case 'UMID':
        RegExp umidReg = RegExp('/[0-9]{12,12}\$/');
        if (!umidReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('UMID Document ID Number must fill in 12 digits');
        }
      case 'PASSPOERT':
        RegExp passReg = RegExp('/^[a-zA-Z][0-9]{7,7}[a-zA-Z]\$/');
        if (!passReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('PASSPORT Document ID Number must fill in 9 digits or English letters');
        }
      case 'DRIVINGLICENSE':
        RegExp drivingLicenseReg = RegExp('/^[a-zA-Z][0-9]{10,10}\$/');
        if (!drivingLicenseReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('DRIVINGLICENSE Document ID Number must fill in 11 digits or English letters');
        }
      case 'SSS':
        RegExp sssReg = RegExp('/[0-9]{10,10}\$/');
        if (!sssReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('SSS Document ID Number must fill in 10 digits');
        }
      case 'PRC':
        RegExp prcReg = RegExp('/[0-9] {7,7}\$/');
        if (!prcReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('PRC Document ID Number must fill in 7 digits');
        }
      case 'POSTALID':
        RegExp postalIdReg = RegExp('/^[a-zA-Z]{1}[0-9]{11,11}\$/');
        if (!postalIdReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('POSTALID Document ID Number must fill in 12 digits or English letters');
        }
      case 'NATIONALID':
        RegExp nationalIdReg = RegExp('/[0-9]{16,16}\$/');
        if (!nationalIdReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('NATIONALID Document ID Number must fill in 16 digits');
        }
    }

    NetworkService.submitIDCardInfo(
        idCardNum: idNum, firstName: fName, midName: mName, lastName: lName, type: type, gender: gender, birthday: birthday, successCallback: () => Get.back());
  }

  void go2selectCardType() async {
    List<String> types = [];
    idCardTypes.forEach((element) {
      types.add(element.title);
    });

    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Type of document to submit', options: types);
    if (selectedIndex == null) return;
    selectedCardType = idCardTypes[selectedIndex];
    cardType.value = selectedCardType!.title;
  }

  void go2takeCardPicture() async {
    if (await _getCameraAuthStatus()) {
      if (selectedCardType == null) {
        return CommonSnackBar.showSnackBar('Please select ID type first!');
      }

      Global.channel.invokeMapMethod('takeIDCardPicture', {'type': cardType.value});
    }
  }

  void takePhotoCompletedHandler(String photoPath) async {
    Map? uploadedImg = await NetworkService.aliyunUploadImge(photoPath, type: 2);

    if (uploadedImg == null) return;
    cardImg.value = uploadedImg['fullPath'];
    OcrRecgnizedEntity ocrModel = await NetworkService.ocrRecgnizer(uploadedImg['sortPath'], cardType.value);
    selectedGender.value = ocrModel.gender == 'M' ? 'Male' : 'Female';
    cardNumController.text = ocrModel.idCardNumber;
    firstNameController.text = ocrModel.replacedFirstName;
    lastNameController.text = ocrModel.replacedLastName;
    birth.value = ocrModel.birthday;
  }

  void go2selectBirthday() async {
    DateTime? tempBirth = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime(DateTime.now().year - 80, 01, 01),
        lastDate: DateTime(DateTime.now().year - 18, 01, 01),
        initialDate: DateTime(DateTime.now().year - 22, 01, 01));
    if (tempBirth == null) return;
    birth.value = DateFormat.yMd().format(tempBirth);
  }

  void genderOptionsOnPressed(bool isMale) => selectedGender.value = isMale ? 'Male' : 'Female';
}
