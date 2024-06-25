import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/add_e_wallet_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

class AddEWallet extends StatelessWidget {
  AddEWallet({super.key});

  final controller = Get.find<AddEWalletController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Add E-Wallet Account',
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: HexColor('#1AFF3232'),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.error, color: HexColor('#FFFF3232')),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Kindly reminder: The name filled in the the loan application is inconsistent with the name of the bound e-wallet account, which may lead to the withdrawal failure.',
                  style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 13),
                ),
              )
            ]),
          ),
          Expanded(
            child: HideKeyboardWrapper(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    Global.generateAddWithdrawMethodItem(
                      'Full Name',
                      editingController: controller.fullNameController,
                    ),
                    Global.generateAddWithdrawMethodItem('E-Wallet Name',
                        type: 1, editingController: controller.walletNameController, textFieldOnTap: controller.go2selectEWalletName),
                    Global.generateAddWithdrawMethodItem(
                      'E-Wallet Account No.',
                      keyboardType: TextInputType.phone,
                      editingController: controller.walletNoController,
                    ),
                    Global.generateAddWithdrawMethodItem(
                      'Same E-Wallet Account No.',
                      keyboardType: TextInputType.phone,
                      editingController: controller.repeatNoController,
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
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
