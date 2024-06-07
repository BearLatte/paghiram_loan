import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

import '../router/application_routes.dart';

class CommonView extends StatelessWidget {
  final Widget child;
  final Widget? navLeading;
  List<Widget>? navTrailings;
  final String? title;
  final bool isShowBackIcon;
  final bool isShowAppBar;
  final Color? backgroundColor;
  final Function()? navLeadingAction;
  final bool resizeToAvoidBottomInset;
  final bool isShowConnectCustomers;

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
    this.resizeToAvoidBottomInset = true,
    this.isShowConnectCustomers = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: isShowAppBar
          ? AppBar(
              title: Text(title ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              backgroundColor: Constant.themeColor,
              foregroundColor: Colors.white,
              leading: navLeading ?? _navLeading(),
              actions: isShowConnectCustomers
                  ? [
                      IconButton(
                        onPressed: () => Get.toNamed(ApplicationRoutes.webView, arguments: {
                          'title': 'Help Center',
                          'url': 'https://api.paghiram.top/Api/Help/index',
                        }),
                        icon: CommonImage(src: 'asset/icons/certify_customer_service_icon.png'),
                      )
                    ]
                  : navTrailings,
            )
          : null,
      body: Container(color: backgroundColor ?? HexColor('#FFFAFAFA'), child: child),
    );
  }

  Widget _navLeading() {
    return GestureDetector(onTap: navLeadingAction ?? Get.back, child: isShowBackIcon ? const CommonImage(src: 'asset/icons/back.png') : null);
  }
}
