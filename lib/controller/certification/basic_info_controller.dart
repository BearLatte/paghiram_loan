import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_alert.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/models/certification_entity.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/util/verify_selection_util.dart';
import 'package:paghiram_loan/widget/select_day_widget.dart';

class BasicInfoController extends GetxController {
  var isShowWorkDetail = false.obs;
  var companyNameInputController = TextEditingController();
  var addressInputController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode addressNode = FocusNode();

  var usage = ''.obs;
  var edu = ''.obs;
  var industry = ''.obs;
  var experience = ''.obs;
  var payday1 = ''.obs;
  var payday2 = ''.obs;
  var salary = ''.obs;
  var companyProvince = ''.obs;
  var companyCity = ''.obs;
  var companyDistrict = ''.obs;

  // control the indicator show
  var isPurposeEmpty = false.obs;
  var isEduEmpty = false.obs;
  var isIndustryEmpty = false.obs;
  var isExperienceEmpty = false.obs;
  var isPayday1Empty = false.obs;
  var isPayday2Empty = false.obs;
  var isSalaryEmpty = false.obs;
  var isCompanyAddressEmpty = false.obs;
  var isNameEmpty = false.obs;
  var isDetailAddressEmpty = false.obs;

  CertificationEntity? certificationModel;

  @override
  void onInit() {
    super.onInit();
    _getCertificationInfo();
    _fillInItemAddListener();
  }

  void _getCertificationInfo() async {
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    String info = await FileManager.getContents(Global.phoneNumber!);
    EasyLoading.dismiss();
    if (info == 'null' || info.trim().isEmpty) {
      certificationModel = CertificationEntity();
      return;
    }

    var json = jsonDecode(info);
    certificationModel = CertificationEntity.fromJson(json);
    _updateInfo();
  }

  void _fillInItemAddListener() {
    companyNameInputController.addListener(() {
      isNameEmpty.value = companyNameInputController.text.trim().isEmpty;
    });

    addressInputController.addListener(() {
      isDetailAddressEmpty.value = addressInputController.text.trim().isEmpty;
    });
  }

  @override
  void onClose() {
    companyNameInputController.dispose();
    addressInputController.dispose();
    nameNode.dispose();
    addressNode.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void backAction() async {
    String result = await CommonAlert.showAlert(
      title: 'Warm Reminder',
      message: 'You have not finished filling in the authentication information. Still return it?',
      cancelText: 'Return',
      confirmText: 'Continue',
    );
    if (result == 'confirm') {
      Get.back();
    }
  }

  void go2customerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });

  void submitBasicInfo() async {
    String purpose = usage.value.trim();
    String eduBg = edu.value.trim();
    String curIndustry = industry.value.trim();
    String companyName = companyNameInputController.text.trim();
    String curExperience = experience.value.trim();
    String curPayday1 = payday1.value.trim();
    String curPayday2 = payday2.value.trim();
    String curSalary = salary.value.trim();
    String companyPro = companyProvince.value.trim();
    String companyCT = companyCity.value.trim();
    String companyDis = companyDistrict.value.trim();
    String companyDetailAdd = addressInputController.text.trim();

    bool isShowDetail = isShowWorkDetail.value;

    if (purpose.isEmpty) {
      isPurposeEmpty.value = true;
      Scrollable.ensureVisible(GlobalObjectKey(1).currentContext!);
      return;
    }

    if (eduBg.isEmpty) {
      isEduEmpty.value = true;
      Scrollable.ensureVisible(GlobalObjectKey(2).currentContext!);
      return;
    }

    if (curIndustry.isEmpty) {
      isIndustryEmpty.value = true;
      Scrollable.ensureVisible(GlobalObjectKey(3).currentContext!);
      return;
    }

    if (isShowDetail) {
      if (companyName.isEmpty) {
        isNameEmpty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(4).currentContext!);
        return;
      }

      if (curExperience.isEmpty) {
        isExperienceEmpty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(5).currentContext!);
        return;
      }

      if (curPayday1.isEmpty) {
        isPayday1Empty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(6).currentContext!);
        return;
      }

      if (curPayday2.isEmpty) {
        isPayday2Empty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(7).currentContext!);
        return;
      }

      if (curSalary.isEmpty) {
        isSalaryEmpty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(8).currentContext!);
        return;
      }

      if (companyPro.isEmpty || companyCT.isEmpty || companyDis.isEmpty) {
        isCompanyAddressEmpty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(9).currentContext!);
        return;
      }

      if (companyDetailAdd.isEmpty) {
        isDetailAddressEmpty.value = true;
        Scrollable.ensureVisible(GlobalObjectKey(10).currentContext!);
        return;
      }
    }
    certificationModel = (await Get.toNamed(ApplicationRoutes.personalInfo, arguments: certificationModel)) as CertificationEntity?;
  }

  void go2selectUsageOfLoan() async {
    List<String> options = await VerifySelectionUtil.getOptions(SelectionType.usage);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Loan purpose', options: options);
    if (selectedIndex == null) return;
    isPurposeEmpty.value = false;
    certificationModel?.usageType = options[selectedIndex];
    _updateInfo();
    _saveInfo();
    if (edu.value.isEmpty) go2selectEduBackground();
  }

  void go2selectEduBackground() async {
    List<String> options = await VerifySelectionUtil.getOptions(SelectionType.edu);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Education Background', options: options);
    if (selectedIndex == null) return;
    certificationModel?.eschool = options[selectedIndex];
    _updateInfo();
    isEduEmpty.value = false;

    if (industry.value.isEmpty) go2selectIndustry();
  }

  void go2selectIndustry() async {
    var optionalsData = await VerifySelectionUtil.optionalsData;
    List<String> options = await VerifySelectionUtil.getOptions(SelectionType.industry);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Industry Classification', options: options);
    if (selectedIndex == null) return;
    certificationModel?.branch = options[selectedIndex];
    certificationModel?.industryType = optionalsData.branch[selectedIndex].type;
    isIndustryEmpty.value = false;

    _updateInfo();
    _saveInfo();

    if (certificationModel?.industryType == '0') {
      isShowWorkDetail.value = true;
      if (companyNameInputController.text.trim().isEmpty) nameNode.requestFocus();
    } else {
      isShowWorkDetail.value = false;
      certificationModel?.companyName = null;
      certificationModel?.workTimeLong = null;
      certificationModel?.payDateOne = null;
      certificationModel?.payDateTwo = null;
      certificationModel?.clientSalary = null;
      certificationModel?.wkPro = null;
      certificationModel?.wkCity = null;
      certificationModel?.wkDistrict = null;
      certificationModel?.wkAddr = null;
      _updateInfo();
      _saveInfo();
    }
  }

  void companyNameEditingCompleted() {
    nameNode.unfocus();
    certificationModel?.companyName = companyNameInputController.text;
    _saveInfo();
    if (experience.value.isEmpty) go2selectExperience();
  }

  void companyNameOnChanged(String companyName) {
    certificationModel?.companyName = companyNameInputController.text;
    _saveInfo();
  }

  void completeAddressOnChanged(String completeAddress) {
    certificationModel?.wkAddr = addressInputController.text;
    _saveInfo();
  }

  void go2selectExperience() async {
    List<String> options = await VerifySelectionUtil.getOptions(SelectionType.experience);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Work Experience', options: options);
    if (selectedIndex == null) return;
    certificationModel?.workTimeLong = options[selectedIndex];
    isExperienceEmpty.value = false;
    _updateInfo();
    _saveInfo();
    if (payday1.value.isEmpty) go2selectPaydayOne();
  }

  void go2selectPaydayOne() async {
    String? selectedDay = await _showSelectDaySheet();
    if (selectedDay == null) return;
    certificationModel?.payDateOne = selectedDay;
    isPayday1Empty.value = false;
    _updateInfo();
    _saveInfo();
    if (payday2.value.isEmpty) go2selectPaydayTwo();
  }

  void go2selectPaydayTwo() async {
    String? selectedDay = await _showSelectDaySheet();
    if (selectedDay == null) return;
    certificationModel?.payDateTwo = selectedDay;
    isPayday2Empty.value = false;
    _updateInfo();
    _saveInfo();
    if (salary.value.isEmpty) go2selectIncome();
  }

  void go2selectIncome() async {
    List<String> options = await VerifySelectionUtil.getOptions(SelectionType.salary);
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Working Experience', options: options);
    if (selectedIndex == null) return;
    certificationModel?.clientSalary = options[selectedIndex];
    isSalaryEmpty.value = false;
    _updateInfo();
    _saveInfo();
    if (companyProvince.value.isEmpty) go2selectAddressInfo();
  }

  void go2selectAddressInfo() async {
    await Get.toNamed(ApplicationRoutes.provinceListPage, arguments: 'basic');
    if (!companyProvince.value.trim().isEmpty && !companyCity.value.trim().isEmpty && !companyDistrict.value.trim().isEmpty) {
      certificationModel?.wkPro = companyProvince.value;
      certificationModel?.wkCity = companyCity.value;
      certificationModel?.wkDistrict = companyDistrict.value;
      isCompanyAddressEmpty.value = false;
      _saveInfo();
      if (addressInputController.text.trim().isEmpty) addressNode.requestFocus();
    }
  }

  void detailAddressEditingCompleted() {
    addressNode.unfocus();
    certificationModel?.wkAddr = addressInputController.text;
    _saveInfo();
  }

  void _updateInfo() async {
    usage.value = certificationModel?.usageType ?? '';
    edu.value = certificationModel?.eschool ?? '';
    industry.value = certificationModel?.branch ?? '';
    if (certificationModel?.industryType == '0') isShowWorkDetail.value = true;
    companyNameInputController.text = certificationModel?.companyName ?? '';
    experience.value = certificationModel?.workTimeLong ?? '';
    payday1.value = certificationModel?.payDateOne ?? '';
    payday2.value = certificationModel?.payDateTwo ?? '';
    salary.value = certificationModel?.clientSalary ?? '';
    companyProvince.value = certificationModel?.wkPro ?? '';
    companyCity.value = certificationModel?.wkCity ?? '';
    companyDistrict.value = certificationModel?.wkDistrict ?? '';
    addressInputController.text = certificationModel?.wkAddr ?? '';
  }

  void _saveInfo() async {
    await FileManager.saveFile(Global.phoneNumber!, certificationModel.toString());
  }

  Future<String?> _showSelectDaySheet() async {
    int? selectedDay;
    return await Get.bottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        SafeArea(
          child: Container(
            height: 375,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                  height: 52,
                  color: Constant.themeColor,
                  alignment: Alignment.center,
                  child: Text('Please set pay date', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
              Expanded(child: SelectDayWidget(itemOnTap: (selected) => selectedDay = selected)),
              Row(children: [
                Expanded(
                    child: Container(
                        height: 56,
                        child: ElevatedButton(
                            onPressed: Get.back,
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(), backgroundColor: HexColor('#FFEBF8F9')),
                            child: Text('Return', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 16, fontWeight: FontWeight.w600))))),
                Expanded(
                    child: Container(
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () => Get.back(result: selectedDay == null ? null : '${selectedDay! + 1}'),
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(), backgroundColor: Constant.themeColor),
                            child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))))),
              ]),
            ]),
          ),
        ));
    return null;
  }
}
