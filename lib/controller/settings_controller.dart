import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/util/global.dart';

class SettingsController extends GetxController {
  var appVersion = ''.obs;

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    var packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  void go2AboutUsPage() => Get.toNamed(ApplicationRoutes.aboutUs);

  void go2DeleteAccountPage() => Get.toNamed(ApplicationRoutes.deleteAccount);

  void logout() {
    Global.clearLoginInfo();
    Get.back();
  }
}
