import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';

class WithdrawConfirmController extends GetxController {
  var loanAmount = ''.obs;
  var loanTerm = ''.obs;
  var isObscureText = true.obs;
  var withdrawName = ''.obs;
  var withdrawNumber = ''.obs;
  var withdrawType = 0.obs;
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loanAmount.value = Get.arguments['amount'];
    loanTerm.value = Get.arguments['term'];
    withdrawName.value = Get.arguments['withdrawName'];
    withdrawNumber.value = Get.arguments['withdrawNumber'];
    withdrawType.value = Get.arguments['withdrawType'];

    passwordController.addListener(() {
      if (passwordController.text.trim().length > 6) {
        passwordController.text = passwordController.text.substring(0, 6);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }

  void confirmAction() {
    String password = passwordController.text.trim();
    if (password.length != 6) {
      return CommonSnackBar.showSnackBar('Please enter correct password.');
    }
    Get.back(result: password);
  }
}
