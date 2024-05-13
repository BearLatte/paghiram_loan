import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/web_view_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  WebView({super.key});

  final controller = Get.find<InternalWebViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonView(
          title: controller.title.value,
          navLeadingAction: controller.backAction,
          child: Column(children: [
            Expanded(child: WebViewWidget(controller: controller.webViewController)),
            if (controller.isShowBottomBar.value)
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: InkWell(
                  onTap: controller.acceptPrivacyPolicy,
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                    child: Text('Aceptar', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              )
          ])),
    );
  }
}
