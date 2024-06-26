import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/certification/certification_index_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CertificationIndexView extends StatelessWidget {
  CertificationIndexView({super.key});

  final controller = Get.find<CertificationIndexController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Certification',
        child: Stack(children: [
          Container(
              padding: EdgeInsets.all(12),
              color: Colors.white,
              child: Row(children: [
                CommonImage(src: 'asset/icons/safe_icon.png'),
                SizedBox(width: 8),
                Expanded(child: Text('The personal information you fill out in your application will be kept confidential and will only be used for loan credit evaluation.'))
              ])),
          SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(6, 100, 12, 6),
              child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    if (controller.isProductApply.value)
                      Column(children: [
                        _styleButton(
                            title: 'Basic Information',
                            onPressed: controller.basicInfoOnPressed,
                            rightIcon: controller.isBasicFinished.value ? 'asset/icons/checkbox_full_icon.png' : null),
                        SizedBox(height: 24),
                        _styleButton(
                            title: 'Identity Authentication',
                            onPressed: controller.isFaceFinished.value ? null : controller.identityInfoOnPressed,
                            rightIcon: controller.isFaceFinished.value ? 'asset/icons/checkbox_full_icon.png' : null),
                      ]),
                    if (!controller.isProductApply.value) _styleButton(title: 'Smile Certification(Optional)', type: 'smile', onPressed: controller.smailOnPressed),
                    SizedBox(height: 48),
                    ElevatedButton(
                      onPressed: controller.canSubmit.value ? controller.submitOnPressed : null,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: HexColor('#FFCCCCCC'),
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: Constant.themeColor),
                    )
                    // Container(child: ,),)
                  ])))
        ]));
  }

  Widget _styleButton({required String title, String? type, String? rightIcon, void Function()? onPressed}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.all(5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 16, 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: type == null ? [HexColor('#FFEBF8F9'), HexColor('#FF99DDE3')] : [HexColor('#FFFFF9F7'), HexColor('#FFFFDFD6'), HexColor('#FFFEB099')],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                  width: 2,
                  height: type == null ? 40 : 60,
                  decoration: BoxDecoration(color: type == null ? Constant.themeColor : HexColor('#FFFEB099'), borderRadius: BorderRadius.circular(100))),
              SizedBox(width: 20),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: type == null ? Constant.themeColor : HexColor('#FFFEB099'))),
                if (type != null) Text('Filling in the certification options will increase the pass rate by 30%')
              ])),
              rightIcon == null ? Icon(Icons.arrow_forward_rounded, size: 24, color: Colors.white) : CommonImage(src: rightIcon)
            ],
          ),
        ));
  }
}
