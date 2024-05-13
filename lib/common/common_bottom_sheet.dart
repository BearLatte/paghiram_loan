import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import '../util/constant.dart';

class CommonBottomSheet {
  static Future<int?> showBottomSheet(String title, {required List<String> options}) async {
    return await Get.bottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        Container(
          constraints: BoxConstraints(maxHeight: 350),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(children: [
                Container(
                    width: double.infinity,
                    height: 52,
                    alignment: Alignment.center,
                    color: Constant.themeColor,
                    child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
                Positioned(top: 5, right: 0, child: IconButton(onPressed: Get.back, icon: Icon(Icons.close, size: 20, color: Colors.white)))
              ]),
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        options.length,
                        (index) => TextButton(
                            onPressed: () => Get.back(result: index),
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                            child: Container(
                                alignment: Alignment.center,
                                height: 52,
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
                                child: Text(options[index], style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15))))),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
