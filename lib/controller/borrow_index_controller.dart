import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

import '../common/common_snack_bar.dart';

class BorrowIndexController extends GetxController {
  // product_id
  late String productId;
  var productMaxLoanAmount = ''.obs;

  late BorrowDetailModel borrowModel;
  late BorrowDetailModelUserData currentUserData;
  var productMaxAmount = ''.obs;
  var partOfProductMinAmount = ''.obs;
  var partOfProductMaxAmount = ''.obs;
  var canBorrowAmount = ''.obs;

  var sliderValue = 0.0.obs;
  var slierMaxValue = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    productId = Get.arguments['product_id'];
  }

  Future<void> fetchProductRate() async {
    BorrowDetailModel? detailModel = await NetworkService.fetchProductRate(productId);
    if (detailModel == null) return;
    borrowModel = detailModel;

    productMaxLoanAmount.value = borrowModel.maxPriceFormat;

    BorrowDetailModelUserData lastData = detailModel.userData[0];
    for (var userData in detailModel.userData) {
      if (userData.info.instalmentNum > lastData.info.instalmentNum) {
        lastData = userData;
      }
    }

    currentUserData = lastData;
    partOfProductMinAmount.value = Global.formatCurrency(int.parse(currentUserData.info.min));
    partOfProductMaxAmount.value = Global.formatCurrency(int.parse(currentUserData.info.max));
    canBorrowAmount.value = Global.formatCurrency(int.parse(currentUserData.info.money));

    slierMaxValue.value = (currentUserData.info.data.length - 1) / 1.0;

    debugPrint(currentUserData.toString());
    // currentBorrowAmount.value = Global.formatCurrency(detailModel.maxPrice);
  }

  void termSelectAction(int index) {
    if (index != 0) {
      CommonSnackBar.showSnackBar("Repay on time for a longer loan term.");
    }
  }

  void sliderValueChanged(double value) {
    sliderValue.value = value;
    BorrowDetailModelUserDataInfoData dataInfoData = currentUserData.info.data[value.truncate()];
    canBorrowAmount.value = Global.formatCurrency(int.parse(dataInfoData.amount));
  }

  void sliderValueChangedEnd(double value) {
    BorrowDetailModelUserDataInfoData dataInfoData = currentUserData.info.data[value.truncate()];
    if(int.parse(dataInfoData.amount) > int.parse(currentUserData.info.money)) {
      late BorrowDetailModelUserDataInfoData currentMaxData;
      for(var item in currentUserData.info.data) {
        if(item.amount == currentUserData.info.money) {
          currentMaxData = item;
        }
        canBorrowAmount.value = Global.formatCurrency(int.parse(currentMaxData.amount));
        sliderValue.value = currentUserData.info.data.indexOf(currentMaxData) / 1.0;
      }
    }
  }

  void confirmWithdraw() {
    Get.toNamed(ApplicationRoutes.borrowDetail);
  }
}
