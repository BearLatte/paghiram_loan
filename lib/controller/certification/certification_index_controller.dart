import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/auth_state_entity.dart';
import 'package:paghiram_loan/models/certification_entity.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CertificationIndexController extends GetxController {
  var isBasicFinished = false.obs;
  var isFaceFinished = false.obs;
  var isProductApply = true.obs;
  var canSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getAuthStatus();
    isProductApply.value = Get.arguments['type'] == 'product';
  }

  void _getAuthStatus() async {
    AuthStateEntity? authStatus = await NetworkService.fetchAuthStatus();

    if (authStatus?.identityState == 1) {
      isBasicFinished.value = true;
    } else {
      _getSelectionContent();
    }

    if (authStatus?.faceState == 1) {
      isFaceFinished.value = true;
    }

    canSubmit.value = authStatus?.identityState == 1 && authStatus?.faceState == 1;
  }

  void _getSelectionContent() async {
    var selectionData = await NetworkService.fetchCertificationSheetContent();
    FileManager.saveFileToTempDirectory(Constant.CERTIFICATION_OPTIONAL_CONTENT, selectionData);
  }

  void basicInfoOnPressed() {
    if (isBasicFinished.value) {
      return CommonSnackBar.showSnackBar("Please note that the data can't be changed after submission");
    } else {
      Get.toNamed(ApplicationRoutes.basicInfo)?.then((value) => _getAuthStatus());
    }
  }

  void identityInfoOnPressed() {
    if (isFaceFinished.value) return CommonSnackBar.showSnackBar("Please note that the data can't be changed after submission");
    if (!isBasicFinished.value) {
      Get.toNamed(ApplicationRoutes.basicInfo)?.then((value) => _getAuthStatus());
    } else if (!isFaceFinished.value) {
      Get.toNamed(ApplicationRoutes.cardOCR, arguments: {'type': 0})?.then((value) => _getAuthStatus());
    }
  }

  void smailOnPressed() => debugPrint('smail认证');

  void submitOnPressed() async {
    String itemId = Get.arguments['itemId'];
    NetworkService.submitCertificationInfo(itemId, () async {
      var result = await _showAlert();
      // if (result != null && await inAppReview.isAvailable()) {
      //   inAppReview.openStoreListing(appStoreId: '');
      //   inAppReview.requestReview();
      // }
      Get.back();
    });
  }

  Future<String> _showAlert() async {
    return await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 100, 10, 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [HexColor('##FFEBF8F9'), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text('Submitted Successfully', style: TextStyle(color: HexColor('#FF06A77D'), fontSize: 18, fontWeight: FontWeight.w600)),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                          child: Text('Your loan application has been submitted. Keep your phone on, we will contact you for verification. Thank you for your support.',
                              style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15, fontWeight: FontWeight.w600))),
                      TextButton(
                          onPressed: () => Get.back(result: 'confirm'),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Container(
                              width: double.infinity,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: HexColor('#FF06A77D'), borderRadius: BorderRadius.circular(22)),
                              child: Text('OK', style: TextStyle(color: Colors.white))))
                    ],
                  ),
                ),
                Positioned(top: -80, child: CommonImage(src: 'asset/icons/submit_success_icon.png'))
              ])
            ]),
          );
        });
  }
}
