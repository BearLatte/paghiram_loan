import 'package:flutter/material.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/controller/pay_cools_method_controller.dart';

import '../../../util/constant.dart';
import '../../../util/hex_color.dart';

class PayCoolsMethodView extends StatelessWidget {
  PayCoolsMethodView({super.key});

  final controller = Get.find<PayCoolsMethodController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Loan payment',
      child: Obx(
        () => Column(
          children: [
            Container(
                color: Constant.themeColor,
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(color: HexColor('#29FFFFFF'), borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Repayment Amount', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(controller.repaymentAmount.value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ]),
                )),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: controller.methodList
                      .map((item) => InkWell(
                          onTap: () => controller.itemSelected(item),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: item.isChecked ? Border.all(color: HexColor('#FF00A9B8'), width: 0.5) : null,
                            ),
                            child: Row(children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CommonImage(src: item.img),
                                    SizedBox(width: 12),
                                    Text(item.title, style: TextStyle(color: HexColor(item.titleColor), fontSize: 15)),
                                    SizedBox(width: 12),
                                    if (item.isRecommended)
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                                          child: Text('Recommended', style: TextStyle(color: HexColor('#FF00A9B8'), fontSize: 13)))
                                  ],
                                ),
                              ),
                              if (item.isChecked) Icon(Icons.check, color: Constant.themeColor),
                            ]),
                          )))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
