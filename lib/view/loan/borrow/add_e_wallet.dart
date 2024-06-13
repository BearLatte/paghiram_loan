import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/add_e_wallet_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
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
                    _generateItem(
                      'Full Name',
                      editingController: controller.fullNameController,
                    ),
                    _generateItem('E-Wallet Name', type: 1, editingController: controller.walletNameController, textFieldOnTap: controller.go2selectEWalletName),
                    _generateItem(
                      'E-Wallet Account No.',
                      keyboardType: TextInputType.phone,
                      editingController: controller.walletNoController,
                    ),
                    _generateItem(
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

  Widget _generateItem(
    String title, {
    int type = 0,
    TextEditingController? editingController,
    TextInputType keyboardType = TextInputType.text,
    void Function()? textFieldOnTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
          SizedBox(height: 12),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 24),
              child: TextField(
                style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15),
                controller: editingController,
                onTap: textFieldOnTap,
                readOnly: type == 1,
                keyboardType: type == 1 ? TextInputType.none : keyboardType,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: type == 0 ? 'Please fill in' : 'Please select',
                  hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  suffixIcon: type == 1 ? Padding(padding: EdgeInsets.zero, child: Icon(Icons.keyboard_arrow_right_outlined, color: HexColor('#CCCCCC'))) : null,
                ),
              ))
        ],
      ),
    );
  }
}
