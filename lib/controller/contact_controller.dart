import 'dart:convert';

import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/application.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/certification_entity.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

import '../models/certify_selection_data_entity.dart';
import '../util/constant.dart';
import '../util/file_manager.dart';

enum ContactType { contact, additional }

class ContactController extends GetxController {
  var nameOfContact1 = ''.obs;
  var phoneOfContact1 = ''.obs;
  var relationOfContact1 = ''.obs;
  var nameOfContact2 = ''.obs;
  var phoneOfContact2 = ''.obs;
  var relationOfContact2 = ''.obs;
  var nameOfAdditional1 = ''.obs;
  var phoneOfAdditional1 = ''.obs;
  var relationOfAdditional1 = ''.obs;
  var nameOfAdditional2 = ''.obs;
  var phoneOfAdditional2 = ''.obs;
  var relationOfAdditional2 = ''.obs;
  var nameOfAdditional3 = ''.obs;
  var phoneOfAdditional3 = ''.obs;
  var relationOfAdditional3 = ''.obs;

  // control the indicator show
  var isNameOfContact1Empty = false.obs;
  var isPhoneOfContact1Empty = false.obs;
  var isRelationOfContact1Empty = false.obs;
  var isNameOfContact2Empty = false.obs;
  var isPhoneOfContact2Empty = false.obs;
  var isRelationOfContact2Empty = false.obs;
  var isNameOfAdditionalEmpty1 = false.obs;
  var isPhoneOfAdditionalEmpty1 = false.obs;
  var isRelationOfAdditionalEmpty1 = false.obs;
  var isNameOfAdditionalEmpty2 = false.obs;
  var isPhoneOfAdditionalEmpty2 = false.obs;
  var isRelationOfAdditionalEmpty2 = false.obs;
  var isNameOfAdditionalEmpty3 = false.obs;
  var isPhoneOfAdditionalEmpty3 = false.obs;
  var isRelationOfAdditionalEmpty3 = false.obs;

  final FlutterContactPicker _picker = FlutterContactPicker();

  late CertifySelectionDataEntity optionalsData;

  CertificationEntity? certificationModel;

  Map<String, String> _selectedPhone = {};

  @override
  void onInit() {
    super.onInit();
    _readOptionsFromSandbox();
    certificationModel = Get.arguments;
    _updateInfo();
  }

  void _readOptionsFromSandbox() async {
    var data = await FileManager.getFileContentFromTempDirectory(Constant.CERTIFICATION_OPTIONAL_CONTENT);
    optionalsData = CertifySelectionDataEntity.fromJson(jsonDecode(data));
  }

  void backAction() {
    Get.back(result: certificationModel);
  }

  void _updateInfo() {
    nameOfContact1.value = certificationModel?.gxName ?? '';
    phoneOfContact1.value = certificationModel?.gxPhone ?? '';
    relationOfContact1.value = certificationModel?.gxOne ?? '';
    _selectedPhone['1'] = certificationModel?.gxPhone ?? '';

    nameOfContact2.value = certificationModel?.gxNameTwo ?? '';
    phoneOfContact2.value = certificationModel?.gxPhoneTwo ?? '';
    relationOfContact2.value = certificationModel?.gxTwo ?? '';
    _selectedPhone['2'] = certificationModel?.gxPhoneTwo ?? '';

    nameOfAdditional1.value = certificationModel?.gxNameThree ?? '';
    phoneOfAdditional1.value = certificationModel?.gxPhoneThree ?? '';
    relationOfAdditional1.value = certificationModel?.gxThree ?? '';
    _selectedPhone['3'] = certificationModel?.gxPhoneThree ?? '';

    nameOfAdditional2.value = certificationModel?.gxNameFour ?? '';
    phoneOfAdditional2.value = certificationModel?.gxPhoneFour ?? '';
    relationOfAdditional2.value = certificationModel?.gxFour ?? '';
    _selectedPhone['4'] = certificationModel?.gxPhoneFour ?? '';

    nameOfAdditional3.value = certificationModel?.gxNameFive ?? '';
    phoneOfAdditional3.value = certificationModel?.gxPhoneFive ?? '';
    relationOfAdditional3.value = certificationModel?.gxFive ?? '';
    _selectedPhone['5'] = certificationModel?.gxPhoneFive ?? '';
  }

  void _saveContactInfo() async {
    var objStr = certificationModel.toString();
    await FileManager.saveFile(Global.phoneNumber!, objStr);
  }

  void submitCertificationInfo() async {
    String nameContact1 = nameOfContact1.value.trim();
    String phoneContact1 = phoneOfContact1.value.trim();
    String relationContact1 = relationOfContact1.value.trim();
    String nameContact2 = nameOfContact2.value.trim();
    String phoneContact2 = phoneOfContact2.value.trim();
    String relationContact2 = relationOfContact2.value.trim();
    String nameAdditional1 = nameOfAdditional1.value.trim();
    String phoneAdditional1 = phoneOfAdditional1.value.trim();
    String relationAdditional1 = relationOfAdditional1.value.trim();
    String nameAdditional2 = nameOfAdditional2.value.trim();
    String phoneAdditional2 = phoneOfAdditional2.value.trim();
    String relationAdditional2 = relationOfAdditional2.value.trim();
    String nameAdditional3 = nameOfAdditional3.value.trim();
    String phoneAdditional3 = phoneOfAdditional3.value.trim();
    String relationAdditional3 = relationOfAdditional3.value.trim();

    if (nameContact1.isEmpty) {
      isNameOfContact1Empty.value = true;
      return;
    }

    if (phoneContact1.isEmpty) {
      isPhoneOfContact1Empty.value = true;
      return;
    }

    if (relationContact1.isEmpty) {
      isRelationOfContact1Empty.value = true;
      return;
    }

    if (nameContact2.isEmpty) {
      isNameOfContact2Empty.value = true;
      return;
    }

    if (phoneContact2.isEmpty) {
      isPhoneOfContact2Empty.value = true;
      return;
    }

    if (relationContact2.isEmpty) {
      isRelationOfContact2Empty.value = true;
      return;
    }

    if (nameAdditional1.isEmpty) {
      isNameOfAdditionalEmpty1.value = true;
      return;
    }

    if (phoneAdditional1.isEmpty) {
      isPhoneOfAdditionalEmpty1.value = true;
      return;
    }

    if (relationAdditional1.isEmpty) {
      isRelationOfAdditionalEmpty1.value = true;
      return;
    }

    if (nameAdditional2.isEmpty) {
      isNameOfAdditionalEmpty2.value = true;
      return;
    }

    if (phoneAdditional2.isEmpty) {
      isPhoneOfAdditionalEmpty2.value = true;
      return;
    }

    if (relationAdditional2.isEmpty) {
      isRelationOfAdditionalEmpty2.value = true;
      return;
    }

    if (nameAdditional3.isEmpty) {
      isNameOfAdditionalEmpty3.value = true;
      return;
    }

    if (phoneAdditional3.isEmpty) {
      isPhoneOfAdditionalEmpty3.value = true;
      return;
    }

    if (relationAdditional3.isEmpty) {
      isRelationOfAdditionalEmpty3.value = true;
      return;
    }

    NetworkService.submitBasicInfo(certificationModel!.toJson(), successCallback: () {
      Get.toNamed(ApplicationRoutes.cardOCR, arguments: {'type': 0});
    });
  }

  void go2customerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });

  void contactItemOnTap(ContactType type, int index) async {
    Contact? contact = await _picker.selectContact();
    if (contact == null) return;
    String name = contact.fullName ?? '';
    String phone = contact.phoneNumbers!.isEmpty ? '' : contact.phoneNumbers![0];

    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    phone = phone.replaceFirst('0', '');

    if (!RegExp('^09').hasMatch(phone) && !RegExp('^08').hasMatch(phone) && !RegExp('^9').hasMatch(phone) && !RegExp('^8').hasMatch(phone)) {
      return CommonSnackBar.showSnackBar('Please fill in the valid emergency contact information,we will contact them randomly for verification !');
    }

    if ((RegExp('^09').hasMatch(phone) || RegExp('^08').hasMatch(phone)) && phone.length != 11) {
      return CommonSnackBar.showSnackBar('Please fill in the valid emergency contact information,we will contact them randomly for verification !');
    }

    if ((RegExp('^9').hasMatch(phone) || RegExp('^8').hasMatch(phone)) && phone.length != 10) {
      return CommonSnackBar.showSnackBar('Please fill in the valid emergency contact information,we will contact them randomly for verification !');
    }

    for (var key in _selectedPhone.keys) {
      if (phone == _selectedPhone[key]) return CommonSnackBar.showSnackBar("Tel No. should not be the same as the ${key}st contact's");
    }

    switch (type) {
      case ContactType.contact:
        switch (index) {
          case 0:
            if (!name.isEmpty) {
              isNameOfContact1Empty.value = false;
            }
            if (!phone.isEmpty) {
              isPhoneOfContact1Empty.value = false;
            }
            certificationModel?.gxName = name;
            certificationModel?.gxPhone = phone;

          case 1:
            if (!name.isEmpty) {
              isNameOfContact2Empty.value = false;
            }
            if (!phone.isEmpty) {
              isPhoneOfContact2Empty.value = false;
            }
            certificationModel?.gxNameTwo = name;
            certificationModel?.gxPhoneTwo = phone;
        }
      case ContactType.additional:
        switch (index) {
          case 0:
            if (!name.isEmpty) {
              isNameOfAdditionalEmpty1.value = false;
            }
            if (!phone.isEmpty) {
              isPhoneOfAdditionalEmpty1.value = false;
            }
            certificationModel?.gxNameThree = name;
            certificationModel?.gxPhoneThree = phone;
          case 1:
            if (!name.isEmpty) {
              isNameOfAdditionalEmpty2.value = false;
            }
            if (!phone.isEmpty) {
              isPhoneOfAdditionalEmpty2.value = false;
            }
            certificationModel?.gxNameFour = name;
            certificationModel?.gxPhoneFour = phone;
          case 2:
            if (!name.isEmpty) {
              isNameOfAdditionalEmpty3.value = false;
            }
            if (!phone.isEmpty) {
              isPhoneOfAdditionalEmpty3.value = false;
            }
            certificationModel?.gxNameFive = name;
            certificationModel?.gxPhoneFive = phone;
        }
    }

    _updateInfo();
    _saveContactInfo();
  }

  void relationItemOnTap(ContactType type, int index) async {
    var relations = optionalsData.relist;
    late List<String> options;
    if (type == ContactType.contact && index == 0) {
      options = relations.t1;
      if (options.contains(relationOfContact2.value)) {
        options.remove(relationOfContact2.value);
      }
    } else if (type == ContactType.contact && index == 1) {
      options = relations.t2;
      if (options.contains(relationOfContact1.value)) {
        options.remove(relationOfContact1.value);
      }
    } else {
      options = relations.t3;
    }
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Relation', options: options);
    if (selectedIndex == null) return;

    if (type == ContactType.contact && index == 0) {
      certificationModel?.gxOne = options[selectedIndex];
      isRelationOfContact1Empty?.value = false;
    } else if (type == ContactType.contact && index == 1) {
      certificationModel?.gxTwo = options[selectedIndex];
      isRelationOfContact2Empty.value = false;
    } else {
      switch (index) {
        case 0:
          certificationModel?.gxThree = options[selectedIndex];
          isRelationOfAdditionalEmpty1.value = false;
        case 1:
          certificationModel?.gxFour = options[selectedIndex];
          isRelationOfAdditionalEmpty2.value = false;
        case 2:
          certificationModel?.gxFive = options[selectedIndex];
          isRelationOfAdditionalEmpty3.value = false;
      }
    }

    _updateInfo();
    _saveContactInfo();
  }
}
