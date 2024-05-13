import 'package:flutter/material.dart';

import '../../util/hex_color.dart';

class CitySelectionItem {
  static Widget generateSectionBar(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
      child: Text(title, style: TextStyle(color: HexColor('#FFAAAAAA'))),
    );
  }

  static Widget generateItem(String title, {String textColor = '#FF3B414B', void Function()? onPressed}) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
          child: Text(title, style: TextStyle(color: HexColor(textColor), fontSize: 15)),
        ));
  }
}
