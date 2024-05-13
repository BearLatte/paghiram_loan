import 'package:flutter/material.dart';

import '../../util/constant.dart';
import '../../util/hex_color.dart';
import '../../widget/count_down_button.dart';

class VerifyCodeItem extends StatelessWidget {
  final String? hitText;
  final TextEditingController editingController;
  final void Function(CountDownButtonState state)? sendBtnOnTap;

  const VerifyCodeItem({super.key, required this.editingController, this.sendBtnOnTap, this.hitText});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Verification code', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
          Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: editingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: hitText,
                            hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#FFCCCCCC'))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: Constant.themeColor)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16)))),
                CountDownButton(
                    countDownValue: 60,
                    session: 'paghiram_loan',
                    width: 100,
                    height: 48,
                    margin: const EdgeInsets.only(left: 16),
                    backgroundColor: Constant.themeColor,
                    disabledBackgroundColor: HexColor('#FFEBF8F9'),
                    cornerRadius: 24,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    disabledTextStyle: TextStyle(color: Constant.themeColor, fontSize: 16, fontWeight: FontWeight.w600),
                    text: 'Send',
                    onTap: sendBtnOnTap)
              ]))
        ]));
  }
}
