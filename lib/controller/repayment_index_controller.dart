import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/models/repayment_detail_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class RepaymentIndexController extends GetxController {
  late RepaymentDetailModel detailModel;

  var isShowAllTerms = false.obs;
  var finalRepaymentAmount = ''.obs;
  var repaidAmount = ''.obs;
  var repaymentTermList = <RepaymentDetailModelPayData>[].obs;

  var isMultipleTerm = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _productId = Get.arguments;
    RepaymentDetailModel? model = await NetworkService.fetchRepaymentData(_productId);
    if (model == null) return;
    detailModel = model;

    List<RepaymentDetailModelPayData> terms = [];

    if (detailModel.isInsRepay == 0) {
      finalRepaymentAmount.value = 'PHP ${Global.formatCurrency(detailModel.finalAmount - detailModel.repaidAmount)}';
      _isFullPayment = true;
    } else {
      isMultipleTerm.value = true;
      finalRepaymentAmount.value = 'PHP ${Global.formatCurrency(detailModel.currentAmount - detailModel.repaidAmount)}';
    }

    RepaymentDetailModelPayData firstData = RepaymentDetailModelPayData();
    firstData.backTime = detailModel.repayTime;
    firstData.money = detailModel.isInsRepay == 0 ? detailModel.finalAmount.toString() : detailModel.currentAmount.toString();
    firstData.isChecked = true;
    firstData.canClick = false;
    terms.add(firstData);

    if (detailModel.payData != null) {
      detailModel.payData!.canClick = true;
      terms.add(detailModel.payData!);
    }

    RepaymentDetailModelPayData lastPayData = terms.last;
    int termLength = 6;
    if (detailModel.isInstalment == 1 && detailModel.payData == null) {
      termLength = 5;
    }

    if (detailModel.repaidAmount > 0) {
      repaidAmount.value = 'PHP ${Global.formatCurrency(detailModel.repaidAmount)}';
    }

    while (terms.length < termLength) {
      RepaymentDetailModelPayData newData = RepaymentDetailModelPayData();
      newData.money = '10';
      if (terms.length != 6) {
        newData.backTime = lastPayData.backTime + 60 * 60 * 24 * 15;
      } else {
        newData.backTime = lastPayData.backTime + 60 * 60 * 24 * 20;
      }
      terms.add(newData);
      lastPayData = newData;
    }
    repaymentTermList.value = terms;
  }

  void showAllTermsStatusChangeAction() => isShowAllTerms.value = !isShowAllTerms.value;

  void selectedTermAction(RepaymentDetailModelPayData payData) {
    bool isChecked = !payData.isChecked;
    repaymentTermList.forEach((item) {
      if (item == payData) {
        item.isChecked = isChecked;
        return;
      }
    });
    repaymentTermList.refresh();
    if (isChecked) {
      _isFullPayment = true;
      finalRepaymentAmount.value = 'PHP ${Global.formatCurrency(detailModel.finalAmount)}';
    } else {
      _isFullPayment = false;
      finalRepaymentAmount.value = 'PHP ${Global.formatCurrency(detailModel.currentAmount)}';
    }
  }

  void go2payOffEntireLoan() async {
    var result = await Get.dialog(
        barrierDismissible: false,
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              Container(
                color: Constant.themeColor,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Detail', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Amount due', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                    Text('PHP ${Global.formatCurrency(detailModel.finalAmount)}', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16, fontWeight: FontWeight.bold)),
                  ])),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(16)),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Total Repayment', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                      Text('PHP ${Global.formatCurrency(detailModel.finalAmount)}', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                    ]),
                    if (detailModel.repaidAmount > 0)
                      Column(children: [
                        SizedBox(height: 16),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('Repaid Amount', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                          Text(repaidAmount.value, style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                        ]),
                      ]),
                    SizedBox(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Repayment Date', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                      Text(DateFormat('MM/dd/yyyy').format(DateTime.now()), style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                    ]),
                  ])),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton(
                  onPressed: () => Get.back(result: 'confirm'),
                  style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
                  child: Text('Full Payment', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              )
            ]),
          ),
          IconButton(onPressed: Get.back, icon: CommonImage(src: 'asset/icons/close_icon.png'))
        ]));

    if (result == 'confirm') payAction();
  }

  void payAction() {
    String repaymentAmount = _isFullPayment ? 'PHP ${Global.formatCurrency(detailModel.finalAmount)}' : finalRepaymentAmount.value;

    switch (detailModel.paymentId) {
      case 1:
        Get.toNamed(ApplicationRoutes.repaymentMethodSkyPay, arguments: {
          'repaymentAmount': repaymentAmount,
          'type': _isFullPayment ? '1' : '3',
          'gid': detailModel.adId,
        });
      case 2:
        Get.toNamed(ApplicationRoutes.repaymentMethodPayCools, arguments: {
          'repaymentAmount': repaymentAmount,
          'type': _isFullPayment ? '1' : '3',
          'gid': detailModel.adId,
        });
    }
  }

  late String _productId;
  bool _isFullPayment = false;
}
