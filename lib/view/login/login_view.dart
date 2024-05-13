import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/controller/login_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/login/password_item.dart';
import 'package:paghiram_loan/view/login/phone_number_item.dart';
import 'package:paghiram_loan/view/login/verify_code_item.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
        child: CommonView(
            child: Obx(() => Stack(children: [
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(12, 60, 12, 32),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        PhoneNumberItem(
                            focusNode: controller.focusNode,
                            editingController: controller.phoneInputController,
                            isShowSuffix: controller.isShowPhoneClearBtn.value,
                            clearAction: () => controller.phoneInputController.clear()),
                        if (!controller.isLoginPart.value)
                          VerifyCodeItem(
                            hitText: '4 bit',
                            editingController: controller.verifyCodeInputController,
                            sendBtnOnTap: controller.sendVerifyCodeAction,
                          ),
                        PasswordItem(
                            editingController: controller.passwordInputController,
                            isObscureText: controller.isPasswordSafety.value,
                            suffixOnTap: controller.turnPasswordSafetyStatus),
                        if (controller.isLoginPart.value && controller.isShowVerifyItem.value)
                          VerifyCodeItem(
                            hitText: '6 bit',
                            editingController: controller.verifyCodeInputController,
                            sendBtnOnTap: controller.sendVerifyCodeAction,
                          ),
                        if (controller.isLoginPart.value)
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              alignment: Alignment.center,
                              child: TextButton(onPressed: controller.go2ChangePassword, child: const Text('Forgot password ?', style: TextStyle(fontSize: 15)))),
                        if (!controller.isLoginPart.value)
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Row(children: [
                                IconButton(
                                    onPressed: controller.policyCheckBoxClicked,
                                    icon: Icon(controller.isCheckedPolicy.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_sharp,
                                        size: 24, color: controller.isCheckedPolicy.value ? Constant.themeColor : HexColor('#FFCCCCCC'))),
                                Expanded(
                                    child: Text.rich(TextSpan(children: [
                                  TextSpan(text: 'I have read and agree to the ', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)),
                                  TextSpan(
                                      text: '”Privacy Policy”',
                                      style: TextStyle(color: Constant.themeColor, fontSize: 15),
                                      recognizer: TapGestureRecognizer()..onTap = controller.go2ReadPrivacyPolicy)
                                ])))
                              ])),
                        TextButton(
                            onPressed: controller.loginAndRegisterAction,
                            child: Container(
                              height: 52,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(26)),
                              child:
                                  Text(controller.isLoginPart.value ? 'Login' : 'Sign up', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                            ))
                      ]))),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(color: Constant.themeColor, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: controller.loginMenuClicked,
                                    child: Text('Login',
                                        style: TextStyle(fontSize: 24, fontWeight: controller.isLoginPart.value ? FontWeight.bold : FontWeight.w400, color: Colors.white)))),
                            Container(color: Colors.white, width: 1, height: 18),
                            Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: controller.signUpMenuClicked,
                                    child: Text('Sign Up',
                                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: controller.isLoginPart.value ? FontWeight.w400 : FontWeight.bold))))
                          ])))
                ]))));
  }
}
