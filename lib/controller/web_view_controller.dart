import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InternalWebViewController extends GetxController {
  var title = ''.obs;
  var url = ''.obs;
  var isShowBottomBar = false.obs;
  late String onlineUrl;
  late List<String> serviceNumbs;

  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    String tempTitle = Get.arguments['title'];
    title.value = tempTitle;
    url.value = Get.arguments['url'];

    if (tempTitle == 'Help Center') {
      _getFBOnlineUrl();
      serviceNumbs = [
        Global.prefs?.getString(Constant.SERVICE_PHONE_NUMBER_ONE) ?? '',
        Global.prefs?.getString(Constant.SERVICE_PHONE_NUMBER_TWO) ?? '',
      ];
    }

    isShowBottomBar.value = Get.arguments['isShowBottomBar'] == '1';


    EasyLoading.showProgress(0.0);
    webViewController = WebViewController.fromPlatformCreationParams(WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    ));

    webViewController
      ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
        EasyLoading.showProgress(progress.toDouble() / 100.0);
        if (progress == 100) {
          EasyLoading.dismiss();
        }
      }))
      ..addJavaScriptChannel('AppModel', onMessageReceived: jsMessageReceived)
      ..loadRequest(Uri.parse(url.value));
  }

  void jsMessageReceived(JavaScriptMessage message) async {
    var actions = jsonDecode(message.message);
    int? index = actions['type'];
    if (index == 2) {
      String? currentPhoneNumb = await _showServiceList();
      if (currentPhoneNumb == null) return;
      _launchPhone(currentPhoneNumb);
    } else if (index == 0) {
      if (await canLaunchUrl(Uri.parse(onlineUrl))) {
        await launchUrl(Uri.parse(onlineUrl), mode: LaunchMode.externalApplication);
      } else {
        CommonSnackBar.showSnackBar('Cannot open $onlineUrl');
      }
    }
  }

  void _launchPhone(String phone) async {
    String url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      CommonSnackBar.showSnackBar('Cannot launch $url');
    }
  }

  void _getFBOnlineUrl() async {
    String? url = await NetworkService.getCustomerServiceOnlineUrl();
    if (url != null) onlineUrl = url;
  }

  void acceptPrivacyPolicy() {
    Get.back(result: 'confirm');
  }

  void backAction() async {
    bool webCanGoBack = await webViewController.canGoBack();
    if (webCanGoBack) {
      webViewController.goBack();
    } else {
      Get.back();
    }
  }

  Future<String?> _showServiceList() async {
    return await Get.bottomSheet(
        isDismissible: false,
        enableDrag: false,
        Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Stack(children: [
            Container(
              width: double.infinity,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
              child: Text('Please select the enquiry tel to call', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Positioned(top: 3, right: 0, child: IconButton(onPressed: Get.back, icon: Icon(Icons.close, size: 20, color: Colors.white)))
          ]),
          Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 24),
              color: Colors.white,
              child: Column(children: [
                ...List.generate(serviceNumbs.length, (index) {
                  return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                    border: Border(
                                        top: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5),
                                        left: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5),
                                        bottom: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5))),
                                child: Text('0${serviceNumbs[index]}', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)))),
                        GestureDetector(
                            onTap: () => Get.back(result: '0${serviceNumbs[index]}'),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              decoration:
                                  BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
                              child: CommonImage(src: 'asset/icons/telephone_icon.png'),
                            ))
                      ]));
                }),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text('9:00 AM TO 18:00 PM', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)),
                )
              ]))
        ]));
  }
}
