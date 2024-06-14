import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hex_color.dart';

class Global {
  static bool get isLogin {
    return prefs?.getBool(Constant.LOGIN_FLAG) ?? false;
  }

  static String? get accessToken {
    return prefs?.getString(Constant.TOKEN_FLAG);
  }

  static String? get phoneNumber {
    return prefs?.getString(Constant.PHONE_NUMBER_FLAG);
  }

  static SharedPreferences? prefs;
  static IosDeviceInfo? deviceInfo;
  static String deviceUUID = '';
  static late String appVersion;
  static final MethodChannel channel = const MethodChannel('paghiram.method.channel');

  static Future<void> initGlobal() async {
    prefs = await SharedPreferences.getInstance();
    deviceInfo = await DeviceInfoPlugin().iosInfo;
    deviceUUID = deviceInfo?.identifierForVendor?.replaceAll('-', '') ?? '00000000000000000000000000000000';

    PackageInfo info = await PackageInfo.fromPlatform();
    appVersion = info.version;
  }


  static void clearLoginInfo() async {
    prefs?.setBool(Constant.LOGIN_FLAG, false);
    prefs?.remove(Constant.TOKEN_FLAG);
    prefs?.remove(Constant.PHONE_NUMBER_FLAG);
    Get.back();
  }

  static String formatCurrency(int amount) => NumberFormat('0,000').format(amount);

  static Widget generateAddWithdrawMethodItem(
      String title, {
        int type = 0,
        TextEditingController? editingController,
        TextInputType keyboardType = TextInputType.text,
        void Function()? textFieldOnTap,
      }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
          SizedBox(height: 12),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 24),
              child: TextField(
                style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15),
                controller: editingController,
                onTap: textFieldOnTap,
                readOnly: type == 1,
                keyboardType: type == 1 ? TextInputType.none : keyboardType,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: type == 0 ? 'Please fill in' : 'Please select',
                  hintStyle: TextStyle(color: HexColor('#FFCCCCCC'), fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  suffixIcon: type == 1 ? Padding(padding: EdgeInsets.zero, child: Icon(Icons.keyboard_arrow_right_outlined, color: HexColor('#CCCCCC'))) : null,
                ),
              ))
        ],
      ),
    );
  }
}
