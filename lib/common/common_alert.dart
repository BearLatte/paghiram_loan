// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CommonAlert {
  static Future<String> showAlert({String title = '', required String message, required String cancelText, required String confirmText}) async {
    return await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [HexColor('#FFFFEBD2'), HexColor('#FFFFFFFF')]),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  if (!title.trim().isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Text(title, textAlign: TextAlign.center, style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  Container(margin: EdgeInsets.symmetric(vertical: 24), child: Text(message, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15))),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(backgroundColor: HexColor('#FFEBF8F9')),
                            onPressed: () => Get.back(result: 'cancel'),
                            child: Text(cancelText, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)))),
                    SizedBox(width: 16),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(backgroundColor: Constant.themeColor),
                            onPressed: () => Get.back(result: 'confirm'),
                            child: Text(confirmText, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600)))),
                  ])
                ]),
              ),
              Positioned(
                  top: -40,
                  child: Container(
                    width: 80,
                    height: 80,
                    child: CommonImage(src: 'asset/icons/reminder_icon.png'),
                  ))
            ])
          ]));
        });
  }
}
