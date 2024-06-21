import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class RepaymentWebviewController extends GetxController {
  var imgPath = ''.obs;
  var title = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    title.value = Get.arguments['title'];
    imgPath.value = Get.arguments['imgPath'];
  }

}
