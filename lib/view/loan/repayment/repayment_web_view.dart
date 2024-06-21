import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/repayment_webview_controller.dart';

class RepaymentWebView extends StatelessWidget {
  RepaymentWebView({super.key});

  final controller = Get.find<RepaymentWebviewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonView(
        title: controller.title.value,
        isShowConnectCustomers: true,
        child: Container(),
      ),
    );
  }
}
