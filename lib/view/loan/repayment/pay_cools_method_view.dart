import 'package:flutter/material.dart';
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
        child: Obx(() => Column(children: [
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
            ])));
  }
}
