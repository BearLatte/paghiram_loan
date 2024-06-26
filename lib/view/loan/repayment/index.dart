import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/repayment_index_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

import '../../../models/repayment_detail_model.dart';

class RepaymentIndex extends StatelessWidget {
  RepaymentIndex({super.key});

  final controller = Get.find<RepaymentIndexController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Repayment Details',
      isShowConnectCustomers: true,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(12)),
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            color: Constant.themeColor,
                            child: Column(
                              children: [
                                Text('Total Repayment', style: TextStyle(color: Colors.white, fontSize: 16)),
                                SizedBox(height: 16),
                                Text(controller.finalRepaymentAmount.value, style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Impact')),
                              ],
                            ),
                          ),
                          if (controller.repaidAmount.value.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Repaid Amount', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16)),
                                  Text(controller.repaidAmount.value, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16)),
                                ],
                              ),
                            )
                        ]),
                      ),
                      ...List.generate(controller.repaymentTermList.length, (index) {
                        if (index < 2) {
                          return _generateRepaymentTermItem(controller.repaymentTermList.length == 5 ? index + 1 : index,
                              payData: controller.repaymentTermList[index], itemCheckAction: controller.selectedTermAction);
                        } else {
                          if (controller.isShowAllTerms.value) {
                            return _generateRepaymentTermItem(controller.repaymentTermList.length == 5 ? index + 1 : index,
                                payData: controller.repaymentTermList[index], itemCheckAction: controller.selectedTermAction);
                          } else {
                            return SizedBox();
                          }
                        }
                      }),
                      InkWell(
                        onTap: controller.showAllTermsStatusChangeAction,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(controller.isShowAllTerms.value ? 'Put away' : 'View more', style: TextStyle(color: HexColor('#FFA3A8B0'))),
                            CommonImage(src: controller.isShowAllTerms.value ? 'asset/icons/up_double_arrow.png' : 'asset/icons/down_double_arrow.png')
                          ]),
                        ),
                      ),
                      if (controller.isMultipleTerm.value)
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: HexColor('#14FFA940'), borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.error, color: HexColor('#FFFFA940'), size: 24),
                            SizedBox(width: 8),
                            Expanded(
                                child: Text(
                              'After the second installment of the loan is paid off on time, other installments of the loan can be forgiven.',
                              style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 13),
                            ))
                          ]),
                        )
                    ],
                  ),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Column(children: [
                    InkWell(
                      onTap: controller.go2payOffEntireLoan,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#cccccc'), width: 0.5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pay off the entire loan', style: TextStyle(color: Constant.themeColor, fontSize: 16)),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_double_arrow_right_sharp, color: Constant.themeColor)
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(controller.finalRepaymentAmount.value, style: TextStyle(color: Constant.themeColor, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('Amount due', style: TextStyle(color: HexColor('#FF9DA3AE'), fontSize: 16)),
                          ]),
                          ElevatedButton(
                            onPressed: controller.payAction,
                            style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
                            child: Text('Pay', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                          )
                        ]))
                  ]))
            ],
          )),
    );
  }

  Widget _generateRepaymentTermItem(int index, {required RepaymentDetailModelPayData payData, void Function(RepaymentDetailModelPayData data)? itemCheckAction}) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text('Term ${index + 1}', style: TextStyle(color: payData.isOvertime ? HexColor('#FFFF3232') : HexColor('#FF102729'), fontSize: 15, fontWeight: FontWeight.w600)),
              if (payData.isOvertime && index == 0)
                Container(
                  margin: EdgeInsets.only(left: 12),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(color: HexColor('#14FF3232'), borderRadius: BorderRadius.circular(100)),
                  child: Text('Overdue ${payData.overtimeDays} days', style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 13)),
                )
            ]),
            InkWell(
              onTap: () {
                if (itemCheckAction != null && payData.canClick) itemCheckAction(payData);
              },
              child: Icon(payData.isChecked ? Icons.check_circle_sharp : Icons.radio_button_unchecked_sharp,
                  size: 24, color: payData.canClick || payData.isChecked ? Constant.themeColor : HexColor('#cccccc')),
            )
          ]),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Repayment Date', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
                Text(payData.formattedBackTime, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
              ]),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Repayment Amount', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
                Text(payData.formattedMoney, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
              ]),
            ]))
      ]),
    );
  }
}
