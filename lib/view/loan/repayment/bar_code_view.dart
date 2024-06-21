import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/bar_code_view_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class BarCodeView extends StatelessWidget {
  BarCodeView({super.key});

  final controller = Get.find<BarCodeViewController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: Get.arguments['title'],
      isShowConnectCustomers: true,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(12)),
                child: Column(children: [
                  Text('Repayment Amount', style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 16),
                  Text(controller.repaymentAmount.value, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Impact')),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Biller name：${controller.billerName}', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16)),
                  CommonImage(src: 'asset/icons/sky_pay_icon.png')
                ]),
              ),
              if (controller.isShowBarCode.value)
                _showBarcodeView(
                  controller.isShowBarcodeItem.value,
                  barcodeData: controller.barcodeData.value,
                  contractNumber: controller.contractNumber.value,
                  copyAction: controller.copyContractNumber,
                  contractNumberOnTap: () => controller.isShowBarcodeItem.value = false,
                  barcodeOnTap: () => controller.isShowBarcodeItem.value = true,
                ),
              if (!controller.isShowBarCode.value) _showNumberView(controller.contractNumber.value, copyAction: controller.copyContractNumber),
              InkWell(
                  onTap: controller.guidelineOnTap,
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        CommonImage(src: 'asset/icons/guideline_icon.png'),
                        SizedBox(width: 8),
                        Text(
                          controller.title.value == 'Bank' ? ' Repayment Guidelines' : controller.title.value + ' Repayment Guidelines',
                          style: TextStyle(color: HexColor('#FF00A9B8'), fontSize: 16),
                        ),
                      ]),
                      Icon(Icons.keyboard_arrow_right_outlined, color: HexColor('#FF00A9B8')),
                    ]),
                  )),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: HexColor('#14FF3232'), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Payment Instructions:\nWe don't accept unofficial repayment channels. In order to prevent fraud, please do not listen to other people changing the repayment channel. If there is any loss, you must bear it yourself. If you have any questions, please contact customer service.",
                  style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showBarcodeView(
    bool isShowBarcode, {
    required Uint8List barcodeData,
    required String contractNumber,
    void Function()? copyAction,
    void Function()? contractNumberOnTap,
    void Function()? barcodeOnTap,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: InkWell(
              onTap: contractNumberOnTap,
              child: Container(
                height: 52,
                alignment: Alignment.center,
                child: Text(
                  'Contract Number',
                  style: TextStyle(
                    color: !isShowBarcode ? HexColor('#FF00A9B8') : HexColor('#FF3B414B'),
                    fontSize: 16,
                    fontWeight: !isShowBarcode ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Container(height: 14, decoration: BoxDecoration(border: Border(left: BorderSide(color: HexColor('#FFB7BAC4'), width: 0.5)))),
          Expanded(
            child: InkWell(
              onTap: barcodeOnTap,
              child: Container(
                height: 52,
                alignment: Alignment.center,
                child: Text(
                  'Barcode',
                  style: TextStyle(
                    color: isShowBarcode ? HexColor('#FF00A9B8') : HexColor('#FF3B414B'),
                    fontSize: 16,
                    fontWeight: isShowBarcode ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ]),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
          child: controller.isShowBarcodeItem.value ? _barcodeView(barcodeData) : _contractNumberView(contractNumber, copyAction: copyAction),
        )
      ]),
    );
  }

  Widget _showNumberView(String contractNumber, {void Function()? copyAction}) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Container(padding: EdgeInsets.symmetric(vertical: 16), child: Text('Contract Number', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16))),
        _contractNumberView(contractNumber, copyAction: copyAction),
      ]),
    );
  }

  Widget _contractNumberView(String contractNumber, {void Function()? copyAction}) {
    return Stack(children: [
      Container(
        height: 52,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(12)),
        child: Text(contractNumber, style: TextStyle(color: HexColor('#FF00A9B8'), fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Positioned(
          right: 0,
          child: InkWell(
            onTap: copyAction,
            child: Container(
              width: 64,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: HexColor('#FF00A9B8'), borderRadius: BorderRadius.circular(12)),
              child: Text('Copy', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ))
    ]);
  }

  Widget _barcodeView(Uint8List barcodeImg) {
    return Column(children: [
      Image.memory(barcodeImg),
      SizedBox(height: 16),
      Text('Barcode is vaild for 24 hours', style: TextStyle(color: HexColor('#FF8C8C8C'), fontSize: 16)),
    ]);
  }
}
