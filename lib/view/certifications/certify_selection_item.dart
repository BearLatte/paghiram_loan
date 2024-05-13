import 'package:flutter/material.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CertifySelectionItem extends StatelessWidget {
  final String title;
  final bool isEmpty;
  final String selectedContent;
  final void Function()? onTap;
  final bool isContact;

  const CertifySelectionItem(this.title, {super.key, this.isEmpty = false, this.selectedContent = '', this.isContact = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: isEmpty ? Border.all(color: Colors.red, width: 0.5) : null),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(title, style: TextStyle(fontSize: 15, color: HexColor('#FF3B414B'))),
                SizedBox(height: 15),
                Row(children: [
                  Expanded(
                      child: Text(selectedContent.trim().isEmpty ? 'Please select' : selectedContent,
                          style: TextStyle(color: selectedContent.trim().isEmpty ? HexColor('#FFCCCCCC') : HexColor('#FF102729'), fontSize: 15))),
                  isContact ? CommonImage(src: 'asset/icons/contact_icon.png', width: 24) : Icon(Icons.keyboard_arrow_right, size: 24, color: HexColor('#ffcccccc'))
                ]),
              ]),
            )),
        if (isEmpty)
          Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 20),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: HexColor('#1AFF3232'), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(Icons.error_outlined, color: HexColor('#FFFF3232'), size: 24),
                  SizedBox(width: 8),
                  Text('This field is required', style: TextStyle(fontSize: 13, color: HexColor('#FFFF3232')))
                ],
              ))
      ],
    );
  }
}
