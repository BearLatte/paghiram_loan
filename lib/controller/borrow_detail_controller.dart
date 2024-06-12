import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

class BorrowDetailController extends GetxController {
  var loanAgreementChecked = false.obs;
  var isShowFullTerm = false.obs;
  var loanAmount = ''.obs;
  var loanTerm = '90 days'.obs;
  var serviceFee = ''.obs;
  var withdrawMethod = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchDetailData(Get.arguments);
  }

  void _fetchDetailData(Map<String, dynamic> params) async {
    BorrowDetailModel? detailModel = await NetworkService.fetchBorrowDetail(params);
    if(detailModel == null) return;
    loanAmount.value = Global.formatCurrency(detailModel.loanAmount);
    serviceFee.value = 'PHP ${Global.formatCurrency(detailModel.serviceFee)}';

  }

  void checkLoanAgreementStatus() => loanAgreementChecked.value = !loanAgreementChecked.value;

  void withdrawAction() {}

  void go2readLoanAgreement() {
    debugPrint('DEBUG: 去查看贷款协议');
  }

  void switchTermShowStatus() {
    isShowFullTerm.value = !isShowFullTerm.value;
  }
}
