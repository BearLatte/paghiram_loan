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
import 'package:paghiram_loan/models/submited_ocr_model_entity.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

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

  // 0: editable 1: uneditable
  var ocrType = 0.obs;
  String? cardImgUrl;
  String? productId;

  late List<IdCardTypeEntity> idCardTypes;
  IdCardTypeEntity? selectedCardType;

  @override
  void onInit() {
    super.onInit();
    ocrType.value = Get.arguments['type'];
    if (ocrType == 1) {
      productId = Get.arguments['productId'];
      _getUploadedInformation();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    _getCameraAuthStatus();
    _getNetworkData();

    Global.channel.setMethodCallHandler((call) async {
      if (call.method == 'takePhotoCompleted') {
        _takePhotoCompletedHandler(call.arguments);
      }
    });
  }

  void _getUploadedInformation() async {
    SubmitedOcrModelEntity? model = await NetworkService.fetchOCRRollbackInformation();
    if (model != null) {
      cardType.value = model.type;
      cardNumController.text = model.idNumber;
      firstNameController.text = model.firstName;
      lastNameController.text = model.lastName;
      midNameController.text = model.middleName;
      selectedGender.value = model.gender;
      birth.value = model.birthday;
    }
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
    String result = await CommonAlert.showAlert(title: 'Warm Reminder', message: 'You have not finished filling in the authentication information. Still return it?');
    if (result == 'confirm') {
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

  void submitAction() => ocrType.value == 0 ? freshUserSubmit() : resubmit();

  void resubmit() {
    if (cardImgUrl == null) return CommonSnackBar.showSnackBar('Please submit a clear photo within the validity period');
    if (livenessImg.value == 'asset/icons/liveness_placeholder.png') return CommonSnackBar.showSnackBar('Please perform facial recognition');
    int startIndex = livenessImg.value.lastIndexOf('/') + 1;
    String facePhoto = livenessImg.value.substring(startIndex);
    var params = {'card_photo': cardImgUrl, 'face_photo': facePhoto, 'product_id': productId!};

    NetworkService.resubmitIDCard(params, successCallback: () {
      Get.back();
    });
  }

  void freshUserSubmit() {
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
      case 'PASSPORT':
        RegExp passReg = RegExp('^[a-zA-Z]{1,1}[0-9]{7,7}[a-zA-Z]{1,1}\$');
        if (!passReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('PASSPORT Document ID Number must fill in 9 digits or English letters');
        }
      case 'DRIVINGLICENSE':
        RegExp drivingLicenseReg = RegExp('^[a-zA-Z]{1,1}[0-9]{10,10}\$');
        if (!drivingLicenseReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('DRIVINGLICENSE Document ID Number must fill in 11 digits or English letters');
        }
      case 'SSS':
        RegExp sssReg = RegExp('[0-9]{10,10}\$');
        if (!sssReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('SSS Document ID Number must fill in 10 digits');
        }
      case 'PRC':
        RegExp prcReg = RegExp('[0-9]{7,7}\$');
        if (!prcReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('PRC Document ID Number must fill in 7 digits');
        }
      case 'POSTALID':
        RegExp postalIdReg = RegExp('^[a-zA-Z]{1,1}[0-9]{11,11}\$');
        if (!postalIdReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('POSTALID Document ID Number must fill in 12 digits or English letters');
        }
      case 'NATIONALID':
        RegExp nationalIdReg = RegExp('[0-9]{16,16}\$');
        if (!nationalIdReg.hasMatch(idNum)) {
          return CommonSnackBar.showSnackBar('NATIONALID Document ID Number must fill in 16 digits');
        }
    }

    RegExp nameReg = RegExp('[\\-\\*\\&\\%\$\\@\\#\\^\\.\\~\\?\\)\\(\\[\\]\\+\\=\\!]');
    if (nameReg.hasMatch(fName)) {
      return CommonSnackBar.showSnackBar('Please input your name in the correct format!');
    }

    if (nameReg.hasMatch(lName)) {
      return CommonSnackBar.showSnackBar('Please input your name in the correct format!');
    }

    if (nameReg.hasMatch(mName)) {
      return CommonSnackBar.showSnackBar('Please input your name in the correct format!');
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
      if (selectedCardType == null && ocrType == 0) {
        return CommonSnackBar.showSnackBar('Please select ID type first!');
      }

      Global.channel.invokeMapMethod('takeIDCardPicture', {'type': cardType.value});
    }
  }

  void _takePhotoCompletedHandler(String photoPath) async {
    Map? uploadedImg = await NetworkService.aliyunUploadImge(photoPath, type: 2);

    if (uploadedImg == null) return;
    cardImg.value = uploadedImg['fullPath'];
    cardImgUrl = uploadedImg['sortPath'];

    if (ocrType.value == 0) {
      OcrRecgnizedEntity ocrModel = await NetworkService.ocrRecgnizer(cardImgUrl!, cardType.value);
      selectedGender.value = ocrModel.gender == 'M' ? 'Male' : 'Female';
      cardNumController.text = ocrModel.idCardNumber;
      firstNameController.text = ocrModel.replacedFirstName;
      lastNameController.text = ocrModel.replacedLastName;
      midNameController.text = ocrModel.replacedMiddleName;
      birth.value = ocrModel.birthday;
    }
  }

  void go2selectBirthday() async {
    late DateTime selectedDate;
    String? result = await Get.bottomSheet(
        enableDrag: false,
        isDismissible: false,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  Text('Date of Birth', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => Get.back(result: 'confirm'),
                    child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 294,
              child: ScrollDateTimePicker(
                  itemExtent: 54,
                  visibleItem: 5,
                  style: DateTimePickerStyle(
                    activeStyle: TextStyle(color: HexColor('#FF2F2F2F'), fontSize: 16),
                    inactiveStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 16),
                    activeDecoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
                  ),
                  dateOption: DateTimePickerOption(
                      dateFormat: DateFormat('MMMMddyyyy'),
                      minDate: DateTime(DateTime.now().year - 80, 01, 01),
                      maxDate: DateTime(DateTime.now().year - 18, 01, 01),
                      initialDate: DateTime(DateTime.now().year - 22, 01, 01)),
                  onChange: (date) {
                    selectedDate = date;
                  }),
            )
          ],
        ));

    if (result == null) return;

    birth.value = DateFormat('MM/dd/yyyy').format(selectedDate);
  }

  void genderOptionsOnPressed(bool isMale) => selectedGender.value = isMale ? 'Male' : 'Female';
}
