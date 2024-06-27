import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/borrow/borrow_detail_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

import '../../../models/borrow_detail_model.dart';

class BorrowDetailView extends StatelessWidget {
  BorrowDetailView({super.key});

  final controller = Get.find<BorrowDetailController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Loan Details',
      isShowConnectCustomers: true,
      child: Obx(() => Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: List.generate(4, (index) {
                          late String title;
                          late String value;
                          switch (index) {
                            case 0:
                              title = 'Loan Amount';
                              value = 'PHP ${controller.loanAmount.value}';
                            case 1:
                              title = 'Loan Term';
                              value = controller.loanTerm.value;
                            case 2:
                              title = 'Service Fee';
                              value = controller.serviceFee.value;
                            case 3:
                              title = 'Withdraw method';
                              value = controller.withdrawMethod.value;
                          }
                          if (index == 2 && !controller.isShowServiceFee.value) {
                            return SizedBox();
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(border: index != 3 ? Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 1.0)) : null),
                            child: InkWell(
                                onTap: () => controller.topListItemAction(index),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Text(title, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                                  Row(children: [
                                    Text(value, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                                    if (index > 1) SizedBox(width: 8),
                                    if (index == 2) CommonImage(src: 'asset/icons/question_icon.png'),
                                    if (index == 3) Icon(Icons.keyboard_arrow_right_sharp, size: 24, color: HexColor('#CCCCCC'))
                                  ])
                                ])),
                          );
                        }),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Repayment schedule', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Column(
                        children: List.generate(controller.borrowPeriodList.length, (index) {
                      if (controller.isShowFullTerm.value) {
                        return _generateRepaymentTermItemView(index + 1, periodItem: controller.borrowPeriodList[index], isCurrent: index == 0);
                      } else {
                        if (index < 2) {
                          return _generateRepaymentTermItemView(index + 1, periodItem: controller.borrowPeriodList[index], isCurrent: index == 0);
                        } else {
                          return SizedBox();
                        }
                      }
                    }).toList()),
                    InkWell(
                        onTap: controller.switchTermShowStatus,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(controller.isShowFullTerm.value ? 'Put away' : 'View more', style: TextStyle(color: HexColor('#FFA3A8B0'), fontSize: 14)),
                          CommonImage(src: controller.isShowFullTerm.value ? 'asset/icons/up_double_arrow.png' : 'asset/icons/down_double_arrow.png')
                        ])),
                    if (controller.isShowIndicator.value)
                      Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(color: HexColor('#14FFA940'), borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Icon(Icons.error, size: 24, color: HexColor('#FFA940')),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text('After the second installment of the loan is paid off on time, other installments of the loan can be forgiven.',
                                      style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 13))),
                            ],
                          )),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    InkWell(
                        onTap: controller.checkLoanAgreementStatus,
                        child: Icon(controller.loanAgreementChecked.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                            color: controller.loanAgreementChecked.value ? Constant.themeColor : HexColor('#888888'), size: 24)),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: 'I have read and understand the', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 13)),
                      TextSpan(
                          text: '"Loan Agreement"',
                          style: TextStyle(color: Constant.themeColor, fontSize: 13),
                          recognizer: TapGestureRecognizer()..onTap = controller.go2readLoanAgreement)
                    ]))
                  ],
                )),
            SafeArea(
              child: TextButton(
                onPressed: controller.withdrawAction,
                child: Container(
                  height: 35,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                  child: Text('Withdraw Money', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            )
          ])),
    );
  }

  Widget _generateRepaymentTermItemView(int index, {required BorrowDetailModelRepayData periodItem, bool isCurrent = false}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 1.0))),
          child: Text('Term $index', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15, fontWeight: FontWeight.w600)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Repayment Date', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
              Text(periodItem.backTime, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
            ]),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Repayment Amount', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
              Text('PHP ${Global.formatCurrency(periodItem.repayPrice)}', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
            ]),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Principal', style: TextStyle(color: isCurrent ? HexColor('#FF102729') : HexColor('#FF757F8C'), fontSize: 14)),
                  Text('PHP ${Global.formatCurrency(periodItem.principal)}', style: TextStyle(color: isCurrent ? HexColor('#FF102729') : HexColor('#FF757F8C'), fontSize: 14))
                ]),
                SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Interest', style: TextStyle(color: isCurrent ? HexColor('#FF102729') : HexColor('#FF757F8C'), fontSize: 14)),
                  Text('PHP ${Global.formatCurrency(periodItem.interest)}', style: TextStyle(color: isCurrent ? HexColor('#FF102729') : HexColor('#FF757F8C'), fontSize: 14))
                ]),
              ]),
            )
          ]),
        )
      ]),
    );
  }
}
