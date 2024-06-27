import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/repayment/sky_pay_method_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

import '../../../models/repayment_method_model.dart';

class SkyPayMethodView extends StatelessWidget {
  SkyPayMethodView({super.key});

  final controller = Get.find<SkyPayMethodController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Loan payment',
        child: Obx(() => Column(
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) {
                        late String title;
                        switch (index) {
                          case 0:
                            title = 'E-wallet';
                          case 1:
                            title = 'Remittance outlet';
                          case 2:
                            title = 'Bank';
                        }
                        return InkWell(
                          onTap: () => controller.methodItemClicked(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                                color: controller.selectedItem.value == index ? Constant.themeColor : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: controller.selectedItem.value != index ? Border.all(color: HexColor('#FFE6E6E6'), width: 0.5) : null),
                            child: Text(
                              title,
                              style: TextStyle(color: controller.selectedItem.value == index ? Colors.white : HexColor('#FF757F8C')),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: SafeArea(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: [
                              _eWalletList(controller.methodsList[0], onTap: controller.selectedMethod),
                              _outletList(controller.methodsList[1], onTap: controller.selectedMethod),
                              _bankList(controller.methodsList[2], onTap: controller.selectedMethod)
                            ][controller.selectedItem.value]))),
              ],
            )));
  }

  Widget _eWalletList(List<RepaymentMethodModel> methodList, {required void Function(RepaymentMethodModel item) onTap}) {
    return Column(
      children: methodList.map((item) => InkWell(onTap: () => onTap(item), child: _methodItem(item))).toList(),
    );
  }

  Widget _outletList(List<RepaymentMethodModel> methodList, {required void Function(RepaymentMethodModel item) onTap}) {
    return Column(
      children: methodList.map((item) => InkWell(onTap: () => onTap(item), child: _methodItem(item))).toList(),
    );
    ;
  }

  Widget _bankList(List<RepaymentMethodModel> methodList, {required void Function(RepaymentMethodModel item) onTap}) {
    return Column(
      children: methodList.map((item) => InkWell(onTap: () => onTap(item), child: _methodItem(item))).toList(),
    );
  }

  Widget _methodItem(RepaymentMethodModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          CommonImage(src: item.img),
          SizedBox(width: 12),
          Text(item.title, style: TextStyle(color: HexColor(item.titleColor), fontSize: 16)),
        ]),
        Row(children: [
          if (item.isRecommended)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
              child: Text('Recommended', style: TextStyle(color: HexColor('#FF00A9B8'))),
            ),
          Icon(Icons.keyboard_arrow_right_sharp, color: HexColor('#cccccc'))
        ]),
      ]),
    );
  }
}
