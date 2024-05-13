import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/personal_info_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/certifications/certify_input_item.dart';
import 'package:paghiram_loan/view/certifications/certify_selection_item.dart';
import 'package:paghiram_loan/view/certifications/section_header.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../common/common_image.dart';

enum MailType { gmail, outlook, hotmail, yahoo, aol }

class PersonalInfoView extends StatelessWidget {
  PersonalInfoView({super.key});

  final controller = Get.find<PersonalInfoController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
      child: CommonView(
        title: 'Personal Information',
        navLeadingAction: controller.backAction,
        navTrailings: [IconButton(onPressed: controller.go2customerService, icon: CommonImage(src: 'asset/icons/certify_customer_service_icon.png'))],
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionHeader('Personal Information'),
                      CertifySelectionItem('Marital Status',
                          selectedContent: controller.maritalStatus.value, isEmpty: controller.isMaritalEmpty.value, onTap: controller.go2selectMaritalStatus),
                      CertifySelectionItem('Number of Children',
                          selectedContent: controller.numOfChildren.value, isEmpty: controller.isChildrenEmpty.value, onTap: controller.go2selectNumOfChildren),
                      CertifySelectionItem('Residential Ownership',
                          selectedContent: controller.residentialOwnership.value,
                          isEmpty: controller.isResidentialOwnershipEmpty.value,
                          onTap: controller.go2selectResidentialOwnership),
                      CertifySelectionItem('Residence',
                          selectedContent: '${controller.residenceProvince.value} ${controller.residenceCity.value} ${controller.residenceDistrict.value}',
                          isEmpty: controller.isResidenceEmpty.value,
                          onTap: controller.go2selectResidence),
                      CertifyInputItem(
                        'Detailed Address',
                        isEmpty: controller.isDetailAddressEmpty.value,
                        inputController: controller.addressInputController,
                        inputNode: controller.addressNode,
                        onEditingCompleted: controller.onDetailAddressEditingCompleted,
                      ),
                      SectionHeader('Contact Information'),
                      if (controller.isShowDropDown.value)
                        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          _createMailDropDownItem(controller.dropMenuGmail.value, onTap: controller.mailDropDownMenuDidClicked, type: MailType.gmail),
                          _createMailDropDownItem(controller.dropMenuYahoo.value, onTap: controller.mailDropDownMenuDidClicked, type: MailType.yahoo),
                          _createMailDropDownItem(controller.dropMenuOutlook.value, onTap: controller.mailDropDownMenuDidClicked, type: MailType.outlook),
                          _createMailDropDownItem(controller.dropMenuAol.value, onTap: controller.mailDropDownMenuDidClicked, type: MailType.aol),
                          _createMailDropDownItem(controller.dropMenuHotmail.value, onTap: controller.mailDropDownMenuDidClicked, type: MailType.hotmail)
                        ]),
                      CertifyInputItem(
                        'E-mail',
                        isEmpty: controller.isEmailEmpty.value,
                        inputController: controller.emailInputController,
                        inputNode: controller.emailNode,
                        onEditingCompleted: controller.onEmailEditingCompleted,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                        decoration: BoxDecoration(color: HexColor('#1448D072'), borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Row(children: [
                          Icon(Icons.error_outlined, color: HexColor('#FF06A77D'), size: 24),
                          SizedBox(width: 8),
                          Expanded(child: Text('Email is used for offline withdrawal, Please fill in accurately！', style: TextStyle(color: HexColor('#FF06A77D'))))
                        ]),
                      ),
                      CertifyInputItem(
                        'Facebook/Messenger Link',
                        isEmpty: controller.isFbEmpty.value,
                        inputNode: controller.fbNode,
                        inputController: controller.fbInputController,
                        onEditingCompleted: controller.onFBEditingCompleted,
                      ),
                      CertifyInputItem(
                        'Viber Phone Number',
                        isEmpty: controller.isViberEmpty.value,
                        inputController: controller.viberInputController,
                        keyboardType: TextInputType.phone,
                      ),
                      CertifyInputItem(
                        'Backup Phone Number(Optional)',
                        inputController: controller.backupController,
                        keyboardType: TextInputType.phone,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 34),
              child: Container(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.submitPersonalInfo,
                    style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
                    child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  )),
            )
          ],
        ),
      ),
    );
  }

  _createMailDropDownItem(String text, {required void Function(String selectedText) onTap, required MailType type}) {
    int index = text.indexOf('@');
    if (index != -1) {
      switch (type) {
        case MailType.gmail:
          text = '${text.substring(0, text.indexOf('@'))}@gmail.com';
        case MailType.hotmail:
          text = '${text.substring(0, text.indexOf('@'))}@hotmail.com';
        case MailType.outlook:
          text = '${text.substring(0, text.indexOf('@'))}@outlook.com';
        case MailType.yahoo:
          text = '${text.substring(0, text.indexOf('@'))}@yahoo.com';
        case MailType.aol:
          text = '${text.substring(0, text.indexOf('@'))}@aol.com';
      }
    }

    return InkWell(
      onTap: () => onTap(text),
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), border: Border(bottom: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
        child: Text(text, style: TextStyle(color: HexColor('#FF00A9B8'), fontSize: 12)),
      ),
    );
  }
}
