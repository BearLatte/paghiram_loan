import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/borrow_rate_model.dart';

// import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

import '../common/common_snack_bar.dart';

class BorrowIndexController extends GetxController {
  // product_id
  late String productId;
  var productMaxLoanAmount = ''.obs;

  late BorrowRateModel borrowModel;
  late BorrowRateModelUserData currentUserData;
  var productMaxAmount = ''.obs;
  var partOfProductMinAmount = ''.obs;
  var partOfProductMaxAmount = ''.obs;
  var canBorrowAmount = ''.obs;

  var sliderValue = 0.0.obs;
  var slierMaxValue = 0.0.obs;

  late BorrowRateModelUserDataInfoData _currentInfoData;

  @override
  void onInit() async {
    super.onInit();
    productId = Get.arguments['product_id'];
  }

  Future<void> fetchProductRate() async {
    BorrowRateModel? detailModel = await NetworkService.fetchProductRate(productId);
    if (detailModel == null) return;
    borrowModel = detailModel;

    productMaxLoanAmount.value = borrowModel.maxPriceFormat;

    BorrowRateModelUserData lastData = detailModel.userData[0];
    for (var userData in detailModel.userData) {
      if (userData.info.instalmentNum > lastData.info.instalmentNum) {
        lastData = userData;
      }
    }

    currentUserData = lastData;
    partOfProductMinAmount.value = Global.formatCurrency(int.parse(currentUserData.info.min));
    partOfProductMaxAmount.value = Global.formatCurrency(int.parse(currentUserData.info.max));
    canBorrowAmount.value = Global.formatCurrency(currentUserData.info.money);

    slierMaxValue.value = (currentUserData.info.data.length - 1) / 1.0;
    sliderValueChangedEnd(slierMaxValue.value);

    int currentAmount = currentUserData.info.money;
    for (var item in currentUserData.info.data) {
      if (currentAmount == item.amount) {
        _currentInfoData = item;
        break;
      }
    }
  }

  void termSelectAction(int index) {
    if (index != 0) {
      CommonSnackBar.showSnackBar("Repay on time for a longer loan term.");
    }
  }

  void sliderValueChanged(double value) {
    sliderValue.value = value;
    BorrowRateModelUserDataInfoData dataInfoData = currentUserData.info.data[value.truncate()];
    _currentBorrowAmount = dataInfoData.amount;
    canBorrowAmount.value = Global.formatCurrency(_currentBorrowAmount);
  }

  void sliderValueChangedEnd(double value) {
    BorrowRateModelUserDataInfoData dataInfoData = currentUserData.info.data[value.truncate()];
    if (dataInfoData.amount > currentUserData.info.money) {
      late BorrowRateModelUserDataInfoData currentMaxData;
      for (var item in currentUserData.info.data) {
        if (item.amount == currentUserData.info.money) {
          currentMaxData = item;
        }
      }
      _currentInfoData = currentMaxData;
      _currentBorrowAmount = currentMaxData.amount;
      canBorrowAmount.value = Global.formatCurrency(_currentBorrowAmount);
      sliderValue.value = currentUserData.info.data.indexOf(currentMaxData) / 1.0;
    }
  }

  void confirmWithdraw() async {
    Map<String, dynamic> params = {};
    params['days'] = currentUserData.days;
    params['price'] = _currentBorrowAmount.toString();
    params['pro_id'] = currentUserData.info.proId;
    params['product_id'] = productId;
    params['rate_id'] = _currentInfoData.rid;
    params['tid'] = currentUserData.termId;

    await Global.channel.invokeMapMethod('changeSecureScreenStatus', {'isSecureScreen': true});
    Get.toNamed(ApplicationRoutes.borrowDetail, arguments: params)?.then((_) async {
      await Global.channel.invokeMapMethod('changeSecureScreenStatus', {'isSecureScreen': false});
    });
  }

  late int _currentBorrowAmount;
}
