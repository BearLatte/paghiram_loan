import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_alert.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../router/application_routes.dart';

class DeleteAccountController extends GetxController {
  var phoneNumber = '+63 ' + (Global.prefs?.getString(Constant.PHONE_NUMBER_FLAG) ?? '');

  String? password;

  void deleteAccountAction() async {
    String result = await CommonAlert.showAlert(
      title: 'Are you sure to delete the account?',
      message: 'After the account is canceled, all user data cannot be restored, please operate with caution.',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );
    if (result == 'cancel') return;

    String? pwdResult = await _showPasswordInputAlert();
    if (pwdResult == null) return;

    NetworkService.deleteAccount(
        password: password!,
        successCallback: () {
          deleteAccountSuccessAction();
        });
  }

  Future<String?> _showPasswordInputAlert() async {
    return await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 64, 12, 24),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [HexColor('#FFFFEBD2'), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text('Please complete the following certification',
                            textAlign: TextAlign.center, style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        Text('Please enter the registration password', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                        SizedBox(height: 20),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          keyboardType: TextInputType.number,
                          textStyle: TextStyle(color: Constant.themeColor, fontSize: 19, fontWeight: FontWeight.w600),
                          onCompleted: (pwd) => password = pwd,
                          pinTheme: PinTheme(
                            activeColor: Constant.themeColor,
                            inactiveColor: HexColor('#FFCCCCCC'),
                            inactiveBorderWidth: 0.5,
                            activeBorderWidth: 0.5,
                            selectedBorderWidth: 0.5,
                            borderRadius: BorderRadius.all(Radius.circular(7.5)),
                            fieldHeight: 36,
                            fieldWidth: 36,
                            shape: PinCodeFieldShape.box,
                          ),
                        ),
                        TextButton(onPressed: () => Get.toNamed(ApplicationRoutes.changePwd, arguments: Global.phoneNumber), child: Text('Forgot password?')),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                      onTap: Get.back,
                                      child: Container(
                                        height: 44,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                                        child: Text('Cancel', style: TextStyle(color: Constant.themeColor, fontSize: 15, fontWeight: FontWeight.w600)),
                                      ))),
                              SizedBox(width: 28),
                              Expanded(
                                  child: InkWell(
                                      onTap: () {
                                        if (password != null) Get.back(result: 'confirm');
                                      },
                                      child: Container(
                                        height: 44,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                                        child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                                      ))),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ])
              ],
            ),
          );
        });
  }

  void deleteAccountSuccessAction() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 64, 16, 24),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [HexColor('#FFEBF8F9'), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(children: [
                      Text('Account Deleted Successfully', style: TextStyle(color: HexColor('#FF06A77D'), fontSize: 18, fontWeight: FontWeight.w600)),
                      SizedBox(height: 16),
                      Text('The current account has been deleted. You can re-register or log in with an existing account',
                          style: TextStyle(color: HexColor('#FF102729'), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 24),
                      TextButton(
                          onPressed: () {
                            Global.clearLoginInfo();
                            Get.until((route) => route.isFirst);
                          },
                          child: Container(
                              width: 200,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: HexColor('#FF06A77D'), borderRadius: BorderRadius.circular(100)),
                              child: Text('OK', style: TextStyle(color: Colors.white))))
                    ]),
                  )
                ])
              ]));
        });
  }

  void go2contactCustomerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });
}
