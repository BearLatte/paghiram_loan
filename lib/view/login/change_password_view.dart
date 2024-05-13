import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/change_password_controller.dart';
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
                  VerifyCodeItem(hitText: '4 bit',editingController: controller.verifyCodeEditingController, sendBtnOnTap: controller.sendVerifyCodeAction),
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
