import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/service/index.dart';

import '../util/constant.dart';
import '../util/global.dart';

class ChangePasswordController extends GetxController {
  FocusNode focusNode = FocusNode();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController verifyCodeEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  var isObscureText = true.obs;
  var isShowSuffix = false.obs;

  // SnackBar show status
  SnackbarStatus? _snackBarStatus = SnackbarStatus.CLOSED;

  String? previousPhoneNum;

  void turnPasswordSafetyStatus() => isObscureText.value = !isObscureText.value;

  int _enterType = 0;

  var sendBtnTitle = 'Send'.obs;
  var isSendBtnEnable = true.obs;

  Timer? _countdownTimer;

  void changePwdAction() async {
    final phone = phoneEditingController.text.trim();
    final code = verifyCodeEditingController.text.trim();
    final pwd = passwordEditingController.text.trim();
    if (phone.isEmpty) return _showSnackBarLogic('Please enter a valid phone number');

    if (code.isEmpty) return _showSnackBarLogic('Verification code error.');

    if (pwd.isEmpty) return _showSnackBarLogic('Password cannot be empty.');

    bool isValid = await NetworkService.checkIfPhoneAndVerifyCodeAvailable(phone: phone, verifyCode: code);
    if (!isValid) return;

    bool isSuccess = await NetworkService.changePassword(phone: phone, verifyCode: code, newPassword: pwd);
    if (!isSuccess) return;

    if (_enterType == 0) {
      NetworkService.login(
          phoneNumber: phone,
          password: pwd,
          verifyCode: '',
          successCallback: (data) {
            Global.prefs?.setString(Constant.TOKEN_FLAG, data['token']);
            Global.prefs?.setBool(Constant.LOGIN_FLAG, true);
            Global.prefs?.setString(Constant.PHONE_NUMBER_FLAG, data['phone']);
            Get.until((route) => route.isFirst);
          });
    } else {
      Get.back();
    }
  }

  void sendSMSCode() {
    if (!isSendBtnEnable.value) return;
    final phone = phoneEditingController.text.trim();
    if (phone.isEmpty) return _showSnackBarLogic('Mobile number cannot be empty.');

    if (RegExp('^09').hasMatch(phone) || RegExp('^08').hasMatch(phone)) {
      if (phone.length != 11) {
        return _showSnackBarLogic('Incorrect phone number format.');
      }
    } else if (RegExp('^9').hasMatch(phone) || RegExp('^8').hasMatch(phone)) {
      if (phone.length != 10) {
        return _showSnackBarLogic('Incorrect phone number format.');
      }
    } else {
      return _showSnackBarLogic('Incorrect phone number format.');
    }

    NetworkService.sendVerifyCode(
        phoneNumber: phone,
        type: VerifyCodeType.changePassword,
        successCallback: () {
          previousPhoneNum = phone;
          sendBtnTitle.value = '60S';
          _startCountdown();
        });
  }

  void _startCountdown() {
    isSendBtnEnable.value = false;
    int totalCount = 60;
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (_) {
      totalCount--;
      if (totalCount > 0) {
        sendBtnTitle.value = totalCount.toString() + 'S';
      } else {
        sendBtnTitle.value = 'Send';
        isSendBtnEnable.value = true;
        totalCount = 60;
        _countdownTimer?.cancel();
      }
    });
  }

  void _showSnackBarLogic(String message) {
    if (_snackBarStatus == SnackbarStatus.CLOSED) {
      return CommonSnackBar.showSnackBar(message);
    } else {
      return;
    }
  }

  @override
  void onReady() {
    super.onReady();
    _currentPhoneNumber = Get.arguments['phone'];
    phoneEditingController.text = _currentPhoneNumber;
    _enterType = Get.arguments['type'];
    phoneEditingController.addListener(() {
      isShowSuffix.value = phoneEditingController.text.trim().length > 0 ? true : false;
      if (RegExp('^09').hasMatch(phoneEditingController.text) || RegExp('^08').hasMatch(phoneEditingController.text)) {
        if (phoneEditingController.text.length > 11) {
          phoneEditingController.text = phoneEditingController.text.substring(0, 11);
          focusNode.unfocus();
        }
      } else {
        if (phoneEditingController.text.length > 10) {
          phoneEditingController.text = phoneEditingController.text.substring(0, 10);
          focusNode.unfocus();
        }
      }

      if (_enterType != 0) {
        phoneEditingController.text = _currentPhoneNumber;
      }
    });

    verifyCodeEditingController.addListener(() {
      if (verifyCodeEditingController.text.trim().length > 4) {
        verifyCodeEditingController.text = verifyCodeEditingController.text.substring(0, 4);
      }
    });

    passwordEditingController.addListener(() {
      if (passwordEditingController.text.trim().length > 6) {
        passwordEditingController.text = passwordEditingController.text.substring(0, 6);
      }
    });
  }

  @override
  void onClose() {
    focusNode.dispose();
    phoneEditingController.dispose();
    verifyCodeEditingController.dispose();
    _countdownTimer?.cancel();
    super.onClose();
  }

  late String _currentPhoneNumber;
}
