import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/controller/device_check_dialog_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

class DeviceCheckDialog extends StatelessWidget {
  DeviceCheckDialog({super.key});

  final controller = Get.find<DeviceCheckDialogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: SingleChildScrollView(
          child: Obx(
            () => HideKeyboardWrapper(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Container(
                          height: 52,
                          width: double.infinity,
                          color: Constant.themeColor,
                          alignment: Alignment.center,
                          child: Text('Verify identity', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(12, 16, 12, 24),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                              Text('Mobile number', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                              Container(
                                  margin: EdgeInsets.only(top: 16, bottom: 16),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: HexColor('#FFCCCCCC'), width: 0.5)),
                                  child: Text(controller.phoneNumber.value, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15))),
                              Text('Verification code', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                              Container(
                                height: 48,
                                margin: EdgeInsets.symmetric(vertical: 16),
                                child: Row(children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller.codeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                        hintText: '6 Bits',
                                        hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#cccccc'), width: 0.5)),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#cccccc'), width: 0.5)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: controller.sendAction,
                                    child: Container(
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller.sendBtnEnable.value ? Constant.themeColor : HexColor('#cccccc'),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Text(controller.sendBtnText.value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                    ),
                                  )
                                ]),
                              ),
                              Row(children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: Get.back,
                                    child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                                      child: Text('Cancel', style: TextStyle(color: Constant.themeColor, fontSize: 15, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(
                                  child: InkWell(
                                    onTap: controller.confirmAction,
                                    child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                                      child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ])
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
