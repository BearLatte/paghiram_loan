import 'package:flutter/material.dart';
import '../../util/constant.dart';
import '../../util/hex_color.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      color: HexColor('#FFEBF8F9'),
      child: Text(title, style: TextStyle(color: Constant.themeColor, fontSize: 15)),
    );
  }
}
