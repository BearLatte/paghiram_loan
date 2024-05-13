import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CommonView extends StatelessWidget {
  final Widget child;
  final Widget? navLeading;
  List<Widget>? navTrailings;
  final String? title;
  final bool isShowBackIcon;
  final bool isShowAppBar;
  final Color? backgroundColor;
  final Function()? navLeadingAction;

  CommonView({
    super.key,
    required this.child,
    this.navLeading,
    this.navTrailings,
    this.title,
    this.isShowBackIcon = true,
    this.isShowAppBar = true,
    this.backgroundColor,
    this.navLeadingAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowAppBar
          ? AppBar(
              title: Text(title ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              backgroundColor: Constant.themeColor,
              foregroundColor: Colors.white,
              leading: navLeading ?? _navLeading(),
              actions: navTrailings,
            )
          : null,
      body: Container(color: backgroundColor ?? HexColor('#FFFAFAFA'), child: child),
    );
  }

  Widget _navLeading() {
    return GestureDetector(onTap: navLeadingAction ?? Get.back, child: isShowBackIcon ? const CommonImage(src: 'asset/icons/back.png') : null);
  }
}