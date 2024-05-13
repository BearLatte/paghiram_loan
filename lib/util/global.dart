import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
