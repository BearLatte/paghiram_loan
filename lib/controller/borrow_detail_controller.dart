import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/models/withdraw_method_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class BorrowDetailController extends GetxController {
  var loanAgreementChecked = false.obs;
  var isShowFullTerm = false.obs;
  var loanAmount = ''.obs;
  var loanTerm = '90 days'.obs;
  var serviceFee = ''.obs;
  var withdrawMethod = ''.obs;
  var isShowServiceFee = false.obs;
  var borrowPeriodList = <BorrowDetailModelRepayData>[].obs;

  WithdrawMethodModel? defaultWithdrawMethod;

  late BorrowDetailModel curDetailModel;

  @override
  void onInit() {
    super.onInit();
    _days = Get.arguments['days'];
    _fetchDetailData(Get.arguments);
    _fetchDefaultWithdrawMethod();
  }

  void _fetchDetailData(Map<String, dynamic> params) async {
    BorrowDetailModel? detailModel = await NetworkService.fetchBorrowDetail(params);
    if (detailModel == null) return;
    curDetailModel = detailModel;
    loanAmount.value = Global.formatCurrency(detailModel.loanAmount);
    if (detailModel.serviceFee > 0) isShowServiceFee.value = true;
    String servicePrice = Global.formatCurrency(detailModel.serviceFee);
    serviceFee.value = 'PHP $servicePrice';
    _generateBorrowPeriod(detailModel.repayData);
  }

  void _generateBorrowPeriod(List<BorrowDetailModelRepayData> period) {
    final dateFormat = DateFormat('MM-dd-yyyy');
    List<BorrowDetailModelRepayData> tempList = period;
    while (tempList.length < 6) {
      BorrowDetailModelRepayData lastData = tempList.last;
      int newDateTimestamp = dateFormat.parse(lastData.backTime).millisecondsSinceEpoch + 24 * 60 * 60 * 1000 * 15;
      String currentDate = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(newDateTimestamp));

      BorrowDetailModelRepayData newData = BorrowDetailModelRepayData();
      newData.backTime = currentDate;
      newData.principal = 10;
      newData.interest = 10;
      newData.repayPrice = 10;
      tempList.add(newData);
    }
    borrowPeriodList.value = tempList;
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

  void withdrawAction() async {
    if (defaultWithdrawMethod == null) return CommonSnackBar.showSnackBar('Please select withdraw method.');
    if (!loanAgreementChecked.value) return CommonSnackBar.showSnackBar('Please read and agree to the loan agreement. ');

    var result = await Get.toNamed(ApplicationRoutes.withdrawConfirm, arguments: {
      'amount': loanAmount.value,
      'term': loanTerm.value,
      'type': defaultWithdrawMethod!.type,
      'withdrawName': defaultWithdrawMethod!.type == 0 ? defaultWithdrawMethod!.title : defaultWithdrawMethod!.name,
      'withdrawNumber': defaultWithdrawMethod!.type == 0 ? defaultWithdrawMethod!.formattedNoPrefixNumber : defaultWithdrawMethod!.formattedBankNumber,
    });

    if (result != 'confirm') return;

    late String account;
    late String type;
    if (defaultWithdrawMethod?.type == 0) {
      account = defaultWithdrawMethod!.accountNumber;
      type = '1';
    } else {
      account = defaultWithdrawMethod!.bankNumber;
      type = '2';
    }
    bool isNeedCheck = await NetworkService.deviceRiskCheck(withdrawType: type, account: account);
  }

  void go2readLoanAgreement() async {
    String url = 'https://api.paghiram.top/Api/Contract/lending_ios?money=${curDetailModel.loanAmount}&use_days=$_days&token=${Global.accessToken}';
    var result = await Get.toNamed(ApplicationRoutes.webView, arguments: {
      'title': 'Loan Agreement',
      'url': url,
      'isShowBottomBar': '1',
      'buttonText': 'Ok, I have read it',
    });
    if (result == 'confirm') loanAgreementChecked.value = true;
  }

  void switchTermShowStatus() => isShowFullTerm.value = !isShowFullTerm.value;

  void topListItemAction(int index) async {
    if (index == 2) {
      _showServiceFeeDetailInfo();
    }

    if (index == 3) {
      var result = await Get.toNamed(ApplicationRoutes.withdrawMethod);
      if (result != null) {
        if (result['type'] != 2) {
          defaultWithdrawMethod = result['item'];
        }

        if (result['type'] == 0) {
          withdrawMethod.value = defaultWithdrawMethod!.formattedNoPrefixNumber;
        } else if (result['type'] == 1) {
          withdrawMethod.value = defaultWithdrawMethod!.name + ' ' + defaultWithdrawMethod!.formattedBankNumber;
        } else if (result['type'] == 2) {
          withdrawMethod.value = 'Cash';
        }
        defaultWithdrawMethod?.type = result['type'];
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

  String? _days;
}
