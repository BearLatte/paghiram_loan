import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/controller/settings_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Settings',
      isShowBackIcon: true,
      child: ListView(
        children: [
          _settingItem(title: 'Language', subtitle: 'English', isShowMoreIcon: false),
          Obx(() => _settingItem(title: 'Current Version', subtitle: 'v${controller.appVersion.value}', isShowMoreIcon: false)),
          _settingItem(title: 'About Us', onPressed: controller.go2AboutUsPage),
          _settingItem(title: 'Delete Account', subtitle: 'Operate with caution!', subtitleColor: HexColor('#FFFF3232'), onPressed: controller.go2DeleteAccountPage),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 48),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: controller.logout,
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Constant.themeColor)),
              child: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }

  Widget _settingItem({required String title, String? subtitle, Color? subtitleColor, bool isShowMoreIcon = true, void Function()? onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
        child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
            child: Row(children: [
              Text(title, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
              const Spacer(),
              Text(subtitle ?? '', style: TextStyle(color: subtitleColor ?? HexColor('#FF757F8C'))),
              if (isShowMoreIcon) Icon(Icons.keyboard_arrow_right_sharp, color: HexColor('#FFCCCCCC'))
            ])));
  }
}
