import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/repayment_code_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

class BarCodeViewController extends GetxController {
  var isShowBarCode = false.obs;
  var title = ''.obs;
  var repaymentAmount = ''.obs;
  var contractNumber = ''.obs;
  var isShowBarcodeItem = false.obs;
  var billerName = ''.obs;
  var barcodeData = Uint8List(0).obs;

  @override
  void onInit() async {
    super.onInit();
    title.value = Get.arguments['title'];
    isShowBarCode.value = Get.arguments['isShowBarCode'];
    _repaymentType = Get.arguments['type'];
    _gid = Get.arguments['gid'];

    RepaymentCodeModel? model = await NetworkService.fetchSkyCode(type: _repaymentType, gid: _gid);
    if (model == null) return null;
    repaymentAmount.value = 'PHP ${Global.formatCurrency(model.amount)}';
    contractNumber.value = model.formattedContractNumber;
    billerName.value = model.accountName;

    if (isShowBarCode.value) {
      String photoString = await NetworkService.generateBarcode(gid: model.goid, type: _repaymentType);
      Uint8List bytes = base64Decode(photoString);
      barcodeData.value = bytes;
    }
  }

  void copyContractNumber() async {
    await Clipboard.setData(ClipboardData(text: contractNumber.value));
    EasyLoading.showToast('Copy successful!');
  }

  void guidelineOnTap() {
    late String img;
    switch (title.value) {
      case 'GCash':
        img = 'asset/images/gcash_instruction_img.png';
      case 'PayMaya':
        img = 'asset/images/paymaya_instruction_img.png';
      case 'ShopeePay':
        img = 'asset/images/shopee_instruction_img.png';
      case 'BPI QuickPay':
        img = 'asset/images/bpi_instruction_img.png';
      case 'Lazada':
        img = 'asset/images/lazada_instruction_img.png';
      case 'Bank':
        img = 'asset/images/bank_instruction_img.png';
      default:
        img = 'asset/images/711_instruction_img.png';
    }
    Get.toNamed(
      ApplicationRoutes.repaymentInstructionView,
      arguments: {'title': title.value, 'imgPath': img},
    );
  }

  late String _repaymentType;
  late String _gid;
}
