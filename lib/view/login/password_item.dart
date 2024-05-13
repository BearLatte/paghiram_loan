import 'package:flutter/material.dart';

import '../../common/common_image.dart';
import '../../util/constant.dart';
import '../../util/hex_color.dart';

class PasswordItem extends StatelessWidget {
  final bool isObscureText;
  final TextEditingController editingController;
  final void Function()? suffixOnTap;
  const PasswordItem({super.key, required this.editingController, required this.isObscureText, this.suffixOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Password', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
        const SizedBox(height: 16),
        Container(
            height: 48,
            margin: const EdgeInsets.only(top: 16),
            child: TextField(
                maxLines: 1,
                style: TextStyle(color: HexColor('#FF102729'), fontSize: 15),
                controller: editingController,
                obscureText: isObscureText,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '6 Bits',
                    hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#FFCCCCCC'))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Constant.themeColor, width: 0.5)),
                    suffixIcon: IconButton(
                        onPressed: suffixOnTap,
                        icon: CommonImage(src: isObscureText ? 'asset/icons/eye_close_icon.png' : 'asset/icons/eye_open_icon.png')))))
      ]),
    );
  }
}
