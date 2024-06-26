import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/change_password_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/login/password_item.dart';
import 'package:paghiram_loan/view/login/phone_number_item.dart';
import 'package:paghiram_loan/view/login/verify_code_item.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../util/constant.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final controller = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
        child: CommonView(
            title: 'Forgot password ?',
            child: Obx(() => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  PhoneNumberItem(
                      focusNode: controller.focusNode,
                      editingController: controller.phoneEditingController,
                      clearAction: () => controller.phoneEditingController.clear(),
                      isShowSuffix: controller.isShowSuffix.value),
                  // VerifyCodeItem(hitText: '4 bit',editingController: controller.verifyCodeEditingController, sendBtnOnTap: controller.sendVerifyCodeAction),
                  Container(
                      padding: EdgeInsets.only(top: 32),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Text('Verification code', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                        SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 48),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: HexColor('#FF102729'), fontSize: 15),
                                  keyboardType: TextInputType.number,
                                  controller: controller.verifyCodeEditingController,
                                  decoration: InputDecoration(
                                      hintText: '4 Bits',
                                      hintStyle: TextStyle(color: HexColor('#cccccc')),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5), borderRadius: BorderRadius.circular(100)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Constant.themeColor, width: 0.5), borderRadius: BorderRadius.circular(100))),
                                ),
                              ),
                              InkWell(
                                onTap: controller.sendSMSCode,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: 100,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: controller.isSendBtnEnable.value ? Constant.themeColor : HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                                  child: Text(controller.sendBtnTitle.value, style: TextStyle(color: controller.isSendBtnEnable.value ? Colors.white : Constant.themeColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        )
                      ])),
                  PasswordItem(
                      editingController: controller.passwordEditingController, isObscureText: controller.isObscureText.value, suffixOnTap: controller.turnPasswordSafetyStatus),
                  const SizedBox(height: 40),
                  TextButton(
                      onPressed: controller.changePwdAction,
                      child: Container(
                        height: 52,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(26)),
                        child: const Text('Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                      ))
                ])))));
  }
}
