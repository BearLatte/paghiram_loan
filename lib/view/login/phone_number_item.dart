import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/common_image.dart';
import '../../util/constant.dart';
import '../../util/hex_color.dart';

class PhoneNumberItem extends StatelessWidget {
  final bool isShowSuffix;
  final FocusNode focusNode;
  final void Function()? clearAction;
  final TextEditingController editingController;
  const PhoneNumberItem({super.key, required this.focusNode, required this.editingController, this.clearAction, this.isShowSuffix = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mobile number', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
          const SizedBox(height: 16),
          Row(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(50)),
                child: Row(children: [const CommonImage(src: 'asset/icons/flag_icon.png'), const SizedBox(width: 10), Text('+63', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15))])),
            Expanded(
                child: Container(
                    height: 48,
                    margin: const EdgeInsets.only(left: 12),
                    child: TextField(
                        maxLines: 1,
                        focusNode: focusNode,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: HexColor('#FF102729')),
                        controller: editingController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                        decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                            suffixIcon: isShowSuffix ? IconButton(onPressed: clearAction, icon: Icon(Icons.clear, size: 15)) : null,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#FFCCCCCC'))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Constant.themeColor, width: 0.5))))))
          ])
        ]));
  }
}
