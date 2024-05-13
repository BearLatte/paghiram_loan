import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/feedback_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../common/common_snack_bar.dart';

class FeedbackView extends StatelessWidget {
  FeedbackView({super.key});

  final controller = Get.find<FeedbackController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
        child: CommonView(
      title: 'Feedback',
      child: SafeArea(
        bottom: false,
        child: Obx(() => Column(
              children: [
                Container(
                    color: Constant.themeColor,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 72,
                    child: Row(children: [
                      Expanded(
                          child: InkWell(
                              onTap: controller.productItemOnTap,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: controller.isProductItem.value ? Colors.white : HexColor('#1AFFFFFF'), borderRadius: BorderRadius.circular(100)),
                                child: Text('Product Issue',
                                    style: TextStyle(
                                        color: controller.isProductItem.value ? Constant.themeColor : Colors.white,
                                        fontSize: 16,
                                        fontWeight: controller.isProductItem.value ? FontWeight.w600 : FontWeight.normal)),
                              ))),
                      SizedBox(width: 15),
                      Expanded(
                          child: InkWell(
                              onTap: controller.collectionItemOnTap,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: controller.isProductItem.value ? HexColor('#1AFFFFFF') : Colors.white, borderRadius: BorderRadius.circular(100)),
                                child: Text('Collection Problems',
                                    style: TextStyle(
                                        color: controller.isProductItem.value ? Colors.white : Constant.themeColor,
                                        fontSize: 16,
                                        fontWeight: controller.isProductItem.value ? FontWeight.normal : FontWeight.w600)),
                              ))),
                    ])),
                Expanded(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(children: [
                          if (!controller.isProductItem.value)
                            InkWell(
                              onTap: controller.go2selectProblemType,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text('Feedback type', style: TextStyle(color: Colors.black, fontSize: 15)),
                                  Icon(Icons.keyboard_arrow_right, color: HexColor('#FFCCCCCC'))
                                ]),
                              ),
                            ),
                          if (!controller.isProductItem.value)
                            Column(
                                children: List.generate(
                                    controller.selectedProblems.length,
                                    (index) => Row(children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 12),
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                            child: Row(children: [
                                              Text(controller.selectedProblems.value[index]),
                                              SizedBox(width: 14),
                                              InkWell(onTap: () => controller.problemBtnDeleteOnTap(index), child: CommonImage(src: 'asset/icons/del_icon.png', width: 24))
                                            ]),
                                          )
                                        ]))),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: TextField(
                                  maxLines: 5,
                                  controller: controller.problemInputController,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'Please write down your problem',
                                      hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                                      border: InputBorder.none))),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              if (controller.selectedImageFilePath.value.trim().isEmpty)
                                InkWell(
                                    onTap: controller.go2selectImage,
                                    child: Container(
                                      width: 64,
                                      height: 64,
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(10)),
                                      child: Icon(Icons.add, size: 24, color: Constant.themeColor),
                                    )),
                              if (!controller.selectedImageFilePath.value.trim().isEmpty)
                                Stack(children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: InkWell(onTap: controller.enlargeImageToSee, child: CommonImage(src: controller.selectedImageFilePath.value, fit: BoxFit.cover)),
                                  ),
                                  Positioned(top: 0, right: 0,child: InkWell(onTap: controller.deleteImgAction, child: CommonImage(src: 'asset/icons/feedback_del_icon.png')))
                                ]),
                              Expanded(child: Text(controller.imgName.value, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15))),
                            ]),
                          ),
                          SizedBox(height: 40),
                          TextButton(
                              onPressed: controller.submitFeedback,
                              style: TextButton.styleFrom(padding: EdgeInsets.all(5)),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                height: 52,
                                decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                                child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                              ))
                        ]))),
                Container(
                    padding: EdgeInsets.only(bottom: 34), child: Text('Customer service online time : 9:00-18:00', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)))
              ],
            )),
      ),
    ));
  }
}
