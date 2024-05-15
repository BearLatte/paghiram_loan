import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/verify_selection_util.dart';

import '../models/certification_entity.dart';
import '../models/certify_selection_data_entity.dart';
import '../router/application_routes.dart';
import '../util/constant.dart';
import '../util/file_manager.dart';

class PersonalInfoController extends GetxController with WidgetsBindingObserver {
  late CertifySelectionDataEntity optionalsData;

  var residenceProvince = ''.obs;
  var residenceCity = ''.obs;
  var residenceDistrict = ''.obs;

  var maritalStatus = ''.obs;
  var numOfChildren = ''.obs;
  var residentialOwnership = ''.obs;
  var addressInputController = TextEditingController();
  var addressNode = FocusNode();
  var emailInputController = TextEditingController();
  var emailNode = FocusNode();
  var fbInputController = TextEditingController();
  var fbNode = FocusNode();
  var viberInputController = TextEditingController();
  var backupController = TextEditingController();

  // control indicator show
  var isMaritalEmpty = false.obs;
  var isChildrenEmpty = false.obs;
  var isResidentialOwnershipEmpty = false.obs;
  var isResidenceEmpty = false.obs;
  var isDetailAddressEmpty = false.obs;
  var isEmailEmpty = false.obs;
  var isFbEmpty = false.obs;
  var isViberEmpty = false.obs;
  var isShowDropDown = false.obs;

  var dropMenuGmail = '@gmail.com'.obs;
  var dropMenuHotmail = '@hotmail.com'.obs;
  var dropMenuYahoo = '@yahoo.com'.obs;
  var dropMenuAol = '@aol.com'.obs;
  var dropMenuOutlook = '@outlook.com'.obs;

  CertificationEntity? certificationModel;

  @override
  void onInit() {
    super.onInit();
    _fillInItemAddListener();
    _readOptionsFromSandbox();
    certificationModel = Get.arguments;
    _updateInfo();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isShowDropDown.value = false;
      if (RegExp('^@').hasMatch(emailInputController.text)) emailInputController.text = '';
      certificationModel?.lvAddr = addressInputController.text;
      certificationModel?.email = emailInputController.text;
      certificationModel?.fbkName = fbInputController.text;
      certificationModel?.whatsapp = viberInputController.text;
      certificationModel?.secondMobile = backupController.text;
      _saveInfo();
    });
  }

  @override
  void onClose() {
    super.onClose();
    addressInputController.dispose();
    addressNode.dispose();
    emailInputController.dispose();
    emailNode.dispose();
    fbInputController.dispose();
    fbNode.dispose();
    viberInputController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void backAction() {
    Get.back(result: certificationModel);
  }

  void _fillInItemAddListener() {
    addressInputController.addListener(() {
      isDetailAddressEmpty.value = addressInputController.text.trim().isEmpty;
    });
    emailInputController.addListener(() {
      isEmailEmpty.value = emailInputController.text.trim().isEmpty;
      isShowDropDown.value = !emailInputController.text.trim().isEmpty && emailNode.hasFocus;
      if (!emailInputController.text.trim().isEmpty) {
        String text = emailInputController.text;
        dropMenuGmail.value = '$text@gmail.com';
        dropMenuHotmail.value = '$text@hotmail.com';
        dropMenuYahoo.value = '$text@yahoo.com';
        dropMenuAol.value = '$text@aol.com';
        dropMenuOutlook.value = '$text@outlook.com';
      }
    });
    fbInputController.addListener(() {
      isFbEmpty.value = fbInputController.text.trim().isEmpty;
    });
    viberInputController.addListener(() {
      isViberEmpty.value = viberInputController.text.trim().isEmpty;
      if (RegExp('^09').hasMatch(viberInputController.text) || RegExp('^08').hasMatch(viberInputController.text)) {
        if (viberInputController.text.length > 11) {
          viberInputController.text = viberInputController.text.substring(0, 11);
        }
      } else {
        if (viberInputController.text.length > 10) {
          viberInputController.text = viberInputController.text.substring(0, 10);
        }
      }
    });

    backupController.addListener(() {
      if (RegExp('^09').hasMatch(backupController.text) || RegExp('^08').hasMatch(backupController.text)) {
        if (backupController.text.length > 11) {
          backupController.text = backupController.text.substring(0, 11);
        }
      } else {
        if (backupController.text.length > 10) {
          backupController.text = backupController.text.substring(0, 10);
        }
      }
    });
  }

  void _readOptionsFromSandbox() async {
    var data = await FileManager.getFileContentFromTempDirectory(Constant.CERTIFICATION_OPTIONAL_CONTENT);
    optionalsData = CertifySelectionDataEntity.fromJson(jsonDecode(data));
  }

  // method
  void go2selectMaritalStatus() async {
    var options = await VerifySelectionUtil.getOptions(SelectionType.marital);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Marital Status', options: options);
    if (selectedIndex == null) return;
    certificationModel?.merryState = options[selectedIndex];
    isMaritalEmpty.value = false;
    _updateInfo();
    _saveInfo();
    if (numOfChildren.value.isEmpty) go2selectNumOfChildren();
  }

  void go2selectNumOfChildren() async {
    var options = await VerifySelectionUtil.getOptions(SelectionType.numOfChildren);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Number of Children', options: options);
    if (selectedIndex == null) return;
    certificationModel?.kidNumber = options[selectedIndex];
    isChildrenEmpty.value = false;
    _updateInfo();
    _saveInfo();

    if (residentialOwnership.value.isEmpty) go2selectResidentialOwnership();
  }

  void go2selectResidentialOwnership() async {
    var options = await VerifySelectionUtil.getOptions(SelectionType.ownership);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Residential Ownership', options: options);
    if (selectedIndex == null) return;
    certificationModel?.hbl = options[selectedIndex];
    isResidentialOwnershipEmpty.value = false;
    _updateInfo();
    _saveInfo();
    if (residenceProvince.value.isEmpty) go2selectResidence();
  }

  void go2selectResidence() async {
    await Get.toNamed(ApplicationRoutes.provinceListPage, arguments: 'personal');
    if (!residenceProvince.value.trim().isEmpty && !residenceCity.value.trim().isEmpty && !residenceDistrict.value.trim().isEmpty) {
      certificationModel?.lvPro = residenceProvince.value;
      certificationModel?.lvCity = residenceCity.value;
      certificationModel?.lvStre = residenceDistrict.value;
      isResidenceEmpty.value = false;
      _saveInfo();
      if (addressInputController.text.trim().isEmpty) addressNode.requestFocus();
    }
  }

  void onDetailAddressEditingCompleted() {
    addressNode.unfocus();
    certificationModel?.lvAddr = addressInputController.text;
    if (emailInputController.text.trim().isEmpty) emailNode.requestFocus();
  }

  void onEmailEditingCompleted() {
    emailNode.unfocus();
    if (RegExp('^@').hasMatch(emailInputController.text)) {
      emailInputController.text = '';
      return;
    }

    certificationModel?.email = emailInputController.text;
    _saveInfo();
    if (fbInputController.text.trim().isEmpty) fbNode.requestFocus();
  }

  void onFBEditingCompleted() {
    fbNode.unfocus();
    certificationModel?.fbkName = fbInputController.text;
    _saveInfo();
  }

  void mailDropDownMenuDidClicked(String mail) {
    emailInputController.text = mail;
    emailNode.unfocus();
    isShowDropDown.value = false;
  }

  void _updateInfo() {
    maritalStatus.value = certificationModel?.merryState ?? '';
    numOfChildren.value = certificationModel?.kidNumber ?? '';
    residentialOwnership.value = certificationModel?.hbl ?? '';
    residenceProvince.value = certificationModel?.lvPro ?? '';
    residenceCity.value = certificationModel?.lvCity ?? '';
    residenceDistrict.value = certificationModel?.lvStre ?? '';
    addressInputController.text = certificationModel?.lvAddr ?? '';
    emailInputController.text = certificationModel?.email ?? '';
    fbInputController.text = certificationModel?.fbkName ?? '';
    viberInputController.text = certificationModel?.whatsapp ?? '';
    backupController.text = certificationModel?.secondMobile ?? '';
  }

  void _saveInfo() async {
    await FileManager.saveFile(Global.phoneNumber!, certificationModel.toString());
  }

  void go2customerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });

  void submitPersonalInfo() async {
    String marital = maritalStatus.value.trim();
    String childrenCount = numOfChildren.value.trim();
    String ownership = residentialOwnership.value.trim();
    String province = residenceProvince.value;
    String city = residenceCity.value;
    String district = residenceDistrict.value;
    String detailAdd = addressInputController.text.trim();
    String email = emailInputController.text.trim();
    String fb = fbInputController.text.trim();
    String viberPhone = viberInputController.text.trim();
    if (marital.isEmpty) {
      isMaritalEmpty.value = true;
      return;
    }

    if (childrenCount.isEmpty) {
      isChildrenEmpty.value = true;
      return;
    }

    if (ownership.isEmpty) {
      isResidentialOwnershipEmpty.value = true;
      return;
    }

    if (province.isEmpty || city.isEmpty || district.isEmpty) {
      isResidenceEmpty.value = true;
      return;
    }

    if (detailAdd.isEmpty) {
      isDetailAddressEmpty.value = true;
      return;
    }

    if (email.isEmpty) {
      isEmailEmpty.value = true;
      return;
    }

    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      CommonSnackBar.showSnackBar('Email format error, please re-enter!');
      return;
    }

    if (fb.isEmpty) {
      isFbEmpty.value = true;
      return;
    }

    if (viberPhone.isEmpty) {
      isViberEmpty.value = true;
      return;
    }

    if (!RegExp('^09').hasMatch(viberPhone) && !RegExp('^08').hasMatch(viberPhone) && !RegExp('^9').hasMatch(viberPhone) && !RegExp('^8').hasMatch(viberPhone)) {
      return CommonSnackBar.showSnackBar('Please enter a valid viber phone number.');
    }

    if(viberPhone.length < 10) {
      return CommonSnackBar.showSnackBar('Please enter a valid viber phone number.');
    }

    if (viberPhone == Global.phoneNumber) {
      return CommonSnackBar.showSnackBar('The registered mobile phone number cannot be used as an alternate number.');
    }

    if (!backupController.text.trim().isEmpty) {
      String backupPhone = backupController.text.trim();
      if (!RegExp('^0').hasMatch(backupPhone)) {
        backupPhone = '0' + backupPhone;
      }
      if (!RegExp('^09').hasMatch(backupPhone) && !RegExp('^08').hasMatch(backupPhone) && !RegExp('^9').hasMatch(backupPhone) && !RegExp('^8').hasMatch(backupPhone)) {
        return CommonSnackBar.showSnackBar('Please enter a valid backup phone number.');
      }

      if (backupPhone == Global.phoneNumber) {
        return CommonSnackBar.showSnackBar('The registered mobile phone number cannot be used as an alternate number');
      }
    }

    certificationModel = (await Get.toNamed(ApplicationRoutes.contact, arguments: certificationModel)) as CertificationEntity?;
  }
}
