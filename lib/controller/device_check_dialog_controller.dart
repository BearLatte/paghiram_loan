import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/util/global.dart';

import '../service/index.dart';

class DeviceCheckDialogController extends GetxController {
  var sendBtnText = 'Send'.obs;
  var sendBtnEnable = false.obs;
  var phoneNumber = ''.obs;
  TextEditingController codeController = TextEditingController();

  Timer? _timer;
  int _countdownNumber = 60;

  @override
  void onInit() {
    super.onInit();
    String tempNum = Global.phoneNumber ?? '';
    if (tempNum.isNotEmpty) {
      tempNum = tempNum.replaceRange(2, tempNum.length, '*********');
    }
    phoneNumber.value = tempNum;

    codeController.addListener(() {
      if (codeController.text.trim().length > 6) {
        codeController.text = codeController.text.substring(0, 6);
      }
    });

    _timerAction();
  }

  @override
  void onClose() {
    codeController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void sendAction() async {
    if (_timer?.isActive == true) return;
    bool isSendSuccess = await NetworkService.withdrawSendVerifyCode(Global.phoneNumber ?? '');
    if (isSendSuccess) {
      sendBtnEnable.value = false;
      sendBtnText.value = '$_countdownNumber';
      _timerAction();
    }
  }

  void _timerAction() {
    _countdownNumber = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (_countdownNumber <= 0) {
        t.cancel();
        sendBtnEnable.value = true;
        sendBtnText.value = 'Send';
      } else {
        _countdownNumber--;
        sendBtnText.value = '$_countdownNumber';
      }
    });
  }

  void confirmAction() {
    String code = codeController.text.trim();
    if (code.isEmpty) {
      return CommonSnackBar.showSnackBar('Verify code cannot be empty.');
    }

    Get.back(result: code);
  }
}
