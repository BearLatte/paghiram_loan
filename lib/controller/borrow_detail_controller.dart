import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/models/withdraw_method_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/loan/borrow/withdraw_method.dart';

class BorrowDetailController extends GetxController {
  var loanAgreementChecked = false.obs;
  var isShowFullTerm = false.obs;
  var loanAmount = ''.obs;
  var loanTerm = '90 days'.obs;
  var serviceFee = ''.obs;
  var withdrawMethod = ''.obs;
  var isShowServiceFee = false.obs;

  WithdrawMethodModel? defaultWithdrawMethod;

  late BorrowDetailModel curDetailModel;

  @override
  void onInit() {
    super.onInit();
    _fetchDetailData(Get.arguments);
    _fetchDefaultWithdrawMethod();
  }

  void _fetchDetailData(Map<String, dynamic> params) async {
    BorrowDetailModel? detailModel = await NetworkService.fetchBorrowDetail(params);
    if (detailModel == null) return;
    curDetailModel = detailModel;
    loanAmount.value = Global.formatCurrency(detailModel.loanAmount);
    if (detailModel.serviceFee > 0) isShowServiceFee.value = true;
    String servicePrice = detailModel.serviceFee > 1000 ? Global.formatCurrency(detailModel.serviceFee) : detailModel.serviceFee.toString();
    serviceFee.value = 'PHP $servicePrice';
    // withdrawMethod.value = detailModel
  }

  void _fetchDefaultWithdrawMethod() async {
    List<WithdrawMethodModel>? wallets = await NetworkService.fetchUserBoundEWallet();
    if (wallets == null) return;
    wallets.forEach((item) {
      if (item.isDefault == '1') {
        withdrawMethod.value = item.formattedNoPrefixNumber;
        defaultWithdrawMethod = item;
      }
    });
  }

  void checkLoanAgreementStatus() => loanAgreementChecked.value = !loanAgreementChecked.value;

  void withdrawAction() {}

  void go2readLoanAgreement() {
    debugPrint('DEBUG: 去查看贷款协议');
  }

  void switchTermShowStatus() {
    isShowFullTerm.value = !isShowFullTerm.value;
  }

  void topListItemAction(int index) async {
    if (index == 2) {
      _showServiceFeeDetailInfo();
    }

    if (index == 3) {
      var result = await Get.toNamed(ApplicationRoutes.withdrawMethod);
      if (result != null) {
        WithdrawMethodModel model = result['item'];
        defaultWithdrawMethod = model;

        if (result['type'] == 0) {
          withdrawMethod.value = model.formattedNoPrefixNumber;
        } else {
          withdrawMethod.value = model.name + ' ' + model.formattedBankNumber;
        }
      }
    }
  }

  void _showServiceFeeDetailInfo() {
    String totalFee = curDetailModel.serviceFee > 1000 ? 'PHP ${Global.formatCurrency(curDetailModel.serviceFee)}' : 'PHP ${curDetailModel.serviceFee}';
    String techFee = curDetailModel.techPrice > 1000 ? 'PHP ${Global.formatCurrency(curDetailModel.techPrice)}' : 'PHP ${curDetailModel.techPrice}';
    String accountManagementFee = curDetailModel.managePrice > 1000 ? 'PHP ${Global.formatCurrency(curDetailModel.managePrice)}' : 'PHP ${curDetailModel.managePrice}';
    String creditFee = curDetailModel.creditPrice > 1000 ? 'PHP ${Global.formatCurrency(curDetailModel.creditPrice)}' : 'PHP ${curDetailModel.creditPrice}';
    String issuedFee = curDetailModel.issuedAmount > 1000 ? 'PHP ${Global.formatCurrency(curDetailModel.issuedAmount)}' : 'PHP ${curDetailModel.issuedAmount}';
    Get.dialog(
        barrierDismissible: false,
        Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                color: Constant.themeColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Text('Service Fee', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#E6E6E6'), width: 1.0))),
                  child: Column(children: [
                    _generateItemRow(title: 'Service Fees', value: totalFee),
                    Container(
                      padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                      decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(16)),
                      child: Column(children: [
                        _generateItemRow(title: 'Technical Service Fees', value: techFee),
                        _generateItemRow(title: 'Account Management Fees', value: accountManagementFee),
                        _generateItemRow(title: 'Credit Assessment Fees', value: creditFee),
                      ]),
                    ),
                  ])),
              SizedBox(height: 16),
              _generateItemRow(title: 'Issued Amount', value: issuedFee, isHorizontalPadding: true)
            ]),
          ),
          IconButton(onPressed: Get.back, icon: CommonImage(src: 'asset/icons/close_icon.png')),
        ]));
  }

  Widget _generateItemRow({required String title, required String value, bool isHorizontalPadding = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, left: isHorizontalPadding ? 12 : 0, right: isHorizontalPadding ? 12 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title, style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)), Text(value, style: TextStyle(color: HexColor('#FF102729'), fontSize: 16))],
      ),
    );
  }
}
