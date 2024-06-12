import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
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

  @override
  void onInit() {
    super.onInit();
    _fetchDetailData(Get.arguments);
  }

  void _fetchDetailData(Map<String, dynamic> params) async {
    BorrowDetailModel? detailModel = await NetworkService.fetchBorrowDetail(params);
    if (detailModel == null) return;
    loanAmount.value = Global.formatCurrency(detailModel.loanAmount);
    if (detailModel.serviceFee > 0) isShowServiceFee.value = true;
    String servicePrice = detailModel.serviceFee > 1000 ? Global.formatCurrency(detailModel.serviceFee) : detailModel.serviceFee.toString();
    serviceFee.value = 'PHP $servicePrice';
    // withdrawMethod.value = detailModel
  }

  void checkLoanAgreementStatus() => loanAgreementChecked.value = !loanAgreementChecked.value;

  void withdrawAction() {}

  void go2readLoanAgreement() {
    debugPrint('DEBUG: 去查看贷款协议');
  }

  void switchTermShowStatus() {
    isShowFullTerm.value = !isShowFullTerm.value;
  }

  void topListItemAction(int index) {
    if (index == 2) {
      _showServiceFeeDetailInfo();
    }

    if (index == 3) {
      Get.toNamed(ApplicationRoutes.withdrawMethod);
    }
  }

  void _showServiceFeeDetailInfo() {
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
                    _generateItemRow(title: 'Service Fees', value: '占位文字'),
                    Container(
                      padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                      decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(16)),
                      child: Column(children: [
                        _generateItemRow(title: 'Technical Service Fees', value: '占位文字'),
                        _generateItemRow(title: 'Account Management Fees', value: '占位文字'),
                        _generateItemRow(title: 'Credit Assessment Fees', value: '占位文字'),
                      ]),
                    ),
                  ])),
              SizedBox(height: 16),
              _generateItemRow(title: 'Issued Amount', value: '占位文字', isHorizontalPadding: true)
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
