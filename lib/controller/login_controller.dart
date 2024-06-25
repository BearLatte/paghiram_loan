import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/base_response.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/widget/count_down_button.dart';

class LoginController extends GetxController {
  var phone = ''.obs;
  var isLoginPart = true.obs;
  var isPasswordSafety = true.obs;
  var isShowVerifyItem = false.obs;
  var isCheckedPolicy = false.obs;
  var isShowPhoneClearBtn = false.obs;
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController verifyCodeInputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  // login required parameter, 0: show verify code item, 1: to login
  int? _codeType;

  // SnackBar show status
  SnackbarStatus? currentSnackBarStatus = SnackbarStatus.CLOSED;

  String? previousInputtedText;
  CountDownButtonState? _countDownState;

  @override
  void onInit() {
    super.onInit();
    phoneInputController.addListener(() {
      isShowPhoneClearBtn.value = phoneInputController.text.trim().length > 0 ? true : false;
      if (RegExp('^09').hasMatch(phoneInputController.text) || RegExp('^08').hasMatch(phoneInputController.text)) {
        if (phoneInputController.text.length > 11) {
          phoneInputController.text = phoneInputController.text.substring(0, 11);
          focusNode.unfocus();
        }
      } else {
        if (phoneInputController.text.length > 10) {
          phoneInputController.text = phoneInputController.text.substring(0, 10);
          focusNode.unfocus();
        }
      }

      if (phoneInputController.text != previousInputtedText) {
        _countDownState?.stopCountDown();
        verifyCodeInputController.text = '';
        if (isLoginPart.value) isShowVerifyItem.value = false;
      }
    });

    verifyCodeInputController.addListener(() {
      if (isLoginPart.value && verifyCodeInputController.text.trim().length > 6) {
        verifyCodeInputController.text = verifyCodeInputController.text.substring(0, 6);
      }

      if (!isLoginPart.value && verifyCodeInputController.text.trim().length > 4) {
        verifyCodeInputController.text = verifyCodeInputController.text.substring(0, 4);
      }
    });

    passwordInputController.addListener(() {
      if (passwordInputController.text.trim().length > 6) {
        passwordInputController.text = passwordInputController.text.substring(0, 6);
      }
    });
  }

  @override
  void onClose() {
    phoneInputController.dispose();
    passwordInputController.dispose();
    verifyCodeInputController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void loginMenuClicked() {
    passwordInputController.text = '';
    verifyCodeInputController.text = '';
    isLoginPart.value = true;
  }

  void signUpMenuClicked() {
    passwordInputController.text = '';
    verifyCodeInputController.text = '';
    isLoginPart.value = false;
  }

  void policyCheckBoxClicked() => isCheckedPolicy.value = !isCheckedPolicy.value;

  void turnPasswordSafetyStatus() => isPasswordSafety.value = !isPasswordSafety.value;

  void go2ChangePassword() async {
    var result = await Get.toNamed(ApplicationRoutes.changePwd, arguments: {'phone': phoneInputController.text, 'type': 0});
    if (result != null) phoneInputController.text = result;
  }

  void go2ReadPrivacyPolicy() async {
    var result = await Get.toNamed(ApplicationRoutes.webView, arguments: {
      'title': 'Privacy Policy',
      'url': 'https://api.paghiram.top/Api/Help/register_ios',
      'isShowBottomBar': '1',
      'buttonText': 'Aceptar',
    });
    if (result != null) isCheckedPolicy.value = true;
  }

  void loginAndRegisterAction() => isLoginPart.value ? loginAction() : registerAction();

  void registerAction() async {
    final phone = phoneInputController.text.trim();
    final verifyCode = verifyCodeInputController.text.trim();
    final pwd = passwordInputController.text.trim();

    if (phone.isEmpty) {
      if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
        return CommonSnackBar.showSnackBar('Please enter a valid phone number');
      } else {
        return;
      }
    }

    if (verifyCode.isEmpty) {
      if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
        return CommonSnackBar.showSnackBar('Verification code error.');
      } else {
        return;
      }
    }

    if (pwd.isEmpty) {
      if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
        return CommonSnackBar.showSnackBar('The password cannot be empty.');
      } else {
        return;
      }
    }

    if (!isCheckedPolicy.value) return CommonSnackBar.showSnackBar('Please read and agree to the agreement.');

    bool isPhoneNumberAvailable = await NetworkService.checkIfPhoneNumberAvailable(phone: phone, verifyCode: verifyCode);
    if (isPhoneNumberAvailable) {
      NetworkService.register(
          phone: phone,
          verifyCode: verifyCode,
          password: pwd,
          successCallback: () {
            loginAction();
          });
    }
  }

  void loginAction() async {
    final phone = phoneInputController.text.trim();
    final pwd = passwordInputController.text.trim();
    if (phone.isEmpty) {
      if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
        return CommonSnackBar.showSnackBar('Please enter a valid phone number');
      } else {
        return;
      }
    }

    if (pwd.isEmpty) {
      if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
        return CommonSnackBar.showSnackBar('The password cannot be empty.');
      } else {
        return;
      }
    }

    if (!isShowVerifyItem.value) _codeType = await NetworkService.checkDeviceRisk(phone: phone, password: pwd);
    if (_codeType == null) return;
    if (_codeType == 0) {
      _codeType = 1;
      isShowVerifyItem.value = true;
      return CommonSnackBar.showSnackBar('Please enter verification code.');
    }

    final verifyCode = verifyCodeInputController.text.trim();

    if (isShowVerifyItem.value) {
      if (verifyCode.isEmpty) {
        if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
          return CommonSnackBar.showSnackBar('Verification code error.');
        } else {
          return;
        }
      }
    }

    NetworkService.login(
        phoneNumber: phone,
        password: pwd,
        verifyCode: verifyCode,
        successCallback: (data) {
          // _countDownState?.stopCountDown();
          verifyCodeInputController.clear();
          passwordInputController.clear();
          isCheckedPolicy.value = false;
          isLoginPart.value = true;
          Global.prefs?.setString(Constant.TOKEN_FLAG, data['token']);
          Global.prefs?.setBool(Constant.LOGIN_FLAG, true);
          Global.prefs?.setString(Constant.PHONE_NUMBER_FLAG, '0${data['phone']}');
          Get.until((route) => route.isFirst);
        });
  }

  void sendVerifyCodeAction(CountDownButtonState state) async {
    String phone = phoneInputController.text.trim();
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
        phoneNumber: phoneInputController.text,
        type: isLoginPart.value ? VerifyCodeType.login : VerifyCodeType.register,
        successCallback: () {
          previousInputtedText = phoneInputController.text;
          state.startTimer();
          _countDownState = state;
        });
  }

  void _showSnackBarLogic(String message) {
    if (currentSnackBarStatus == SnackbarStatus.CLOSED) {
      return CommonSnackBar.showSnackBar(message);
    } else {
      return;
    }
  }
}
