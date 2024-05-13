import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/controller/feedback_type_select_controller.dart';
import 'package:paghiram_loan/util/constant.dart';

import '../../util/hex_color.dart';

class FeedbackTypeSelectView extends StatelessWidget {
  FeedbackTypeSelectView({super.key});

  final controller = Get.find<FeedbackTypeSelectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: HexColor('#77000000'),
          body: GetBuilder<FeedbackTypeSelectController>(builder: (controller){
            return Stack(children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(children: [
                  Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                    child: Text('Feedback type', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  ...List.generate(controller.allTypes.length, (index) {
                    return InkWell(
                      onTap: () => controller.selectedTypeAction(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                            color: controller.selectedIndexes.contains(index) ? HexColor('#FFEBF8F9') : Colors.white,
                            border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.allTypes[index],
                                style: TextStyle(color: controller.selectedIndexes.contains(index) ? Constant.themeColor : HexColor('#FF3B414B'), fontSize: 16)),
                            Icon(controller.selectedIndexes.contains(index) ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                                size: 20, color: controller.selectedIndexes.contains(index) ? Constant.themeColor : HexColor('#FFCCCCCC')),
                          ],
                        ),
                      ),
                    );
                  }),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: Get.back,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                            decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                            child: Text('Cancel', style: TextStyle(color: Constant.themeColor, fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        InkWell(
                          onTap: controller.confirmAction,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
                            decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                            child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              )
            ]);
          }),
        );
  }
}
