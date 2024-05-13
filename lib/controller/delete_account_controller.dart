import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_alert.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class DeleteAccountController extends GetxController {
  var phoneNumber = '+63 ' + (Global.prefs?.getString(Constant.PHONE_NUMBER_FLAG) ?? '');

  void deleteAccountAction() async {
    String result = await CommonAlert.showAlert(
        title: 'Are you sure to delete the account?', message: 'After the account is canceled, all user data cannot be restored, please operate with caution.');
    if (result == 'cancel') return;

    NetworkService.deleteAccount(successCallback: () {
      deleteAccountSuccessAction();
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

  void go2contactCustomerService() {
    print('联系客服');
  }
}
