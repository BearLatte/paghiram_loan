import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/card_ocr_controller.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/certifications/certify_input_item.dart';
import 'package:paghiram_loan/view/certifications/certify_selection_item.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

class CardOcrView extends StatelessWidget {
  CardOcrView({super.key});

  final controller = Get.find<CardOcrController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
        child: CommonView(
            title: 'Identity Authentication',
            navLeadingAction: controller.backAction,
            navTrailings: [IconButton(onPressed: controller.go2customerService, icon: CommonImage(src: 'asset/icons/certify_customer_service_icon.png'))],
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.fromLTRB(12, 20, 34, 20),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Facial Recognition', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
                              InkWell(
                                  onTap:  controller.go2doingLiveness,
                                  child: Container(
                                    width: 100,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                    child: CommonImage(src: controller.livenessImg.value),
                                  ))
                            ],
                          ),
                        ),
                        CertifySelectionItem('Type of document to submit', selectedContent: controller.cardType.value, onTap: controller.go2selectCardType),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Column(children: [
                            InkWell(
                                onTap: controller.go2takeCardPicture,
                                child: Container(
                                  width: 200,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                                  child: CommonImage(src: controller.cardImg.value, width: 200, fit: BoxFit.cover),
                                )),
                            SizedBox(height: 16),
                            Text('Front photo of ID card', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15))
                          ]),
                        ),
                        CertifyInputItem('Document ID Number', inputController: controller.cardNumController),
                        CertifyInputItem('First Name', inputController: controller.firstNameController),
                        CertifyInputItem('Last Name', inputController: controller.lastNameController),
                        CertifyInputItem('Middle Name (Optional)', inputController: controller.midNameController),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('Gender', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                            Row(children: [
                              TextButton(
                                  onPressed: () => controller.genderOptionsOnPressed(true),
                                  child: Row(
                                    children: [
                                      Icon(controller.selectedGender.value == 'Male' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                          color: controller.selectedGender.value == 'Male' ? Constant.themeColor : HexColor('#FFCCCCCC')),
                                      SizedBox(width: 8),
                                      Text('Male', style: TextStyle(color: controller.selectedGender.value == 'Male' ? Constant.themeColor : HexColor('#FFCCCCCC')))
                                    ],
                                  )),
                              TextButton(
                                  onPressed: () => controller.genderOptionsOnPressed(false),
                                  child: Row(
                                    children: [
                                      Icon(controller.selectedGender.value == 'Female' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                          color: controller.selectedGender.value == 'Female' ? Constant.themeColor : HexColor('#FFCCCCCC')),
                                      SizedBox(width: 8),
                                      Text('Female', style: TextStyle(color: controller.selectedGender.value == 'Female' ? Constant.themeColor : HexColor('#FFCCCCCC')))
                                    ],
                                  )),
                            ])
                          ]),
                        ),
                        CertifySelectionItem('Date of Birth', selectedContent: controller.birth.value, onTap: controller.go2selectBirthday),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: HexColor('#1448D072'), borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.error_outlined, color: HexColor('#FF06A77D'), size: 24),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              'Warm reminder: Please fill in your name and ID information correctly. Incorrect information will result in failure to pass the review.',
                              style: TextStyle(fontSize: 13, color: HexColor('#FF06A77D')),
                            ))
                          ]),
                        )
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
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Constant.themeColor),
                      onPressed: controller.submitAction,
                      child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ))
            ])));
  }
}
