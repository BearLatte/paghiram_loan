import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/contact_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/view/certifications/certify_selection_item.dart';
import 'package:paghiram_loan/view/certifications/section_header.dart';

import '../../common/common_image.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Emergency Contact',
        navLeadingAction: controller.backAction,
        navTrailings: [IconButton(onPressed: controller.go2customerService, icon: CommonImage(src: 'asset/icons/certify_customer_service_icon.png'))],
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    ...List.generate(2, (index) {
                      return Column(children: [
                        SectionHeader('Personal Reference Contact ${index + 1}'),
                        CertifySelectionItem('Name',
                            isContact: true,
                            selectedContent: index == 0 ? controller.nameOfContact1.value : controller.nameOfContact2.value,
                            isEmpty: index == 0 ? controller.isNameOfContact1Empty.value : controller.isNameOfContact2Empty.value,
                            onTap: () => controller.contactItemOnTap(ContactType.contact, index)),
                        CertifySelectionItem('Phone',
                            selectedContent: index == 0 ? controller.phoneOfContact1.value : controller.phoneOfContact2.value,
                            isEmpty: index == 0 ? controller.isPhoneOfContact1Empty.value : controller.isPhoneOfContact2Empty.value,
                            onTap: () => controller.contactItemOnTap(ContactType.contact, index)),
                        CertifySelectionItem('Relation',
                            selectedContent: index == 0 ? controller.relationOfContact1.value : controller.relationOfContact2.value,
                            isEmpty: index == 0 ? controller.isRelationOfContact1Empty.value : controller.isRelationOfContact2Empty.value,
                            onTap: () => controller.relationItemOnTap(ContactType.contact, index))
                      ]);
                    }),
                    ...List.generate(3, (index) {
                      return Column(children: [
                        SectionHeader('Additional Contact Person ${index + 1}'),
                        CertifySelectionItem('Name',
                            isContact: true,
                            selectedContent:
                                index == 0 ? controller.nameOfAdditional1.value : (index == 1 ? controller.nameOfAdditional2.value : controller.nameOfAdditional3.value),
                            isEmpty: index == 0
                                ? controller.isNameOfAdditionalEmpty1.value
                                : (index == 1 ? controller.isNameOfAdditionalEmpty2.value : controller.isNameOfAdditionalEmpty3.value),
                            onTap: () => controller.contactItemOnTap(ContactType.additional, index)),
                        CertifySelectionItem('Phone',
                            isContact: true,
                            selectedContent:
                                index == 0 ? controller.phoneOfAdditional1.value : (index == 1 ? controller.phoneOfAdditional2.value : controller.phoneOfAdditional3.value),
                            isEmpty: index == 0
                                ? controller.isPhoneOfAdditionalEmpty1.value
                                : (index == 1 ? controller.isPhoneOfAdditionalEmpty2.value : controller.isPhoneOfAdditionalEmpty3.value),
                            onTap: () => controller.contactItemOnTap(ContactType.additional, index)),
                        CertifySelectionItem(
                          'Relation',
                          isEmpty: index == 0
                              ? controller.isRelationOfAdditionalEmpty1.value
                              : (index == 1 ? controller.isRelationOfAdditionalEmpty2.value : controller.isRelationOfAdditionalEmpty3.value),
                          selectedContent:
                              index == 0 ? controller.relationOfAdditional1.value : (index == 1 ? controller.relationOfAdditional2.value : controller.relationOfAdditional3.value),
                          onTap: () => controller.relationItemOnTap(ContactType.additional, index),
                        ),
                      ]);
                    }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 34),
            color: Colors.white,
            child: Container(
              height: 52,
              child: ElevatedButton(
                onPressed: controller.submitCertificationInfo,
                style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
                child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          )
        ]));
  }
}
