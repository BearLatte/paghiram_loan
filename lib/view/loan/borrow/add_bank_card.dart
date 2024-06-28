import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/borrow/add_bank_card_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../../util/constant.dart';
import '../../../util/global.dart';

class AddBankCard extends StatelessWidget {
  AddBankCard({super.key});

  final controller = Get.find<AddBankCardController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Add Bank Card',
        child: Column(children: [
          Container(
              color: HexColor('#1AFF3232'),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(Icons.error, color: HexColor('#FFFF3232'), size: 24),
                SizedBox(width: 4),
                Expanded(
                    child: Text(
                  'Kindly reminder: The name filled in the the loan application is inconsistent with the name of the bound bank card account, which may lead to the withdrawal failure.',
                  style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 13),
                ))
              ])),
          Expanded(
              child: HideKeyboardWrapper(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Column(children: [
                        Global.generateAddWithdrawMethodItem('Full Name', editingController: controller.fullNameController),
                        Global.generateAddWithdrawMethodItem(
                          'Bank Name',
                          type: 1,
                          editingController: controller.bankNameController,
                          textFieldOnTap: controller.go2selectBankName,
                        ),
                        Global.generateAddWithdrawMethodItem(
                          'Bank Account No.',
                          keyboardType: TextInputType.number,
                          editingController: controller.bankNumberController,
                        ),
                        Global.generateAddWithdrawMethodItem(
                          'Same Bank Account No.',
                          keyboardType: TextInputType.number,
                          editingController: controller.repeatNumberController,
                        ),
                        Global.generateAddWithdrawMethodItem(
                          'Cell Phone No.',
                          keyboardType: TextInputType.phone,
                          editingController: controller.phoneNumberController,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: controller.confirmAction,
                            style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor, foregroundColor: Colors.white),
                            child: Text('Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        )
                      ]))))
        ]));
  }
}
