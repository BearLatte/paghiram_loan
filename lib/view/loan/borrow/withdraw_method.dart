import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/withdraw_method_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class WithdrawMethod extends StatelessWidget {
  WithdrawMethod({super.key});

  final controller = Get.find<WithdrawMethodController>();

  @override
  Widget build(BuildContext context) {
    double itemWidth = (MediaQuery.of(context).size.width - 36) / 3.0;
    return CommonView(
      isShowConnectCustomers: true,
      title: 'Withdrawal method',
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 64,
              color: Constant.themeColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) {
                    late String title;
                    switch (index) {
                      case 0:
                        title = 'E-Wallet';
                      case 1:
                        title = 'Cash';
                      case 2:
                        title = 'BankCard';
                    }
                    return InkWell(
                      onTap: () => controller.itemSelectAction(index),
                      child: Container(
                        width: itemWidth,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: controller.selectedItem == index ? Colors.white : HexColor('#1AFFFFFF'), borderRadius: BorderRadius.circular(100)),
                        child: Text(title,
                            style: TextStyle(
                                color: controller.selectedItem.value == index ? Constant.themeColor : Colors.white,
                                fontSize: 16,
                                fontWeight: controller.selectedItem.value == index ? FontWeight.w600 : FontWeight.normal)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(child: [_eWalletListView(), _generateCashView(), _generateBankCardView()][controller.selectedItem.value])
          ],
        ),
      ),
    );
  }

  Widget _eWalletListView() {
    return Obx(() {
      if (controller.eWalletList.isEmpty) {
        return Column(
          children: [
            CommonImage(src: 'asset/icons/withdraw_empty_icon.png'),
            _generateAddButton(controller.addButtonAction),
          ],
        );
      } else {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ...controller.eWalletList.map((wallet) {
              return InkWell(
                  onTap: () => Get.back(result: wallet),
                  child: Container(
                    margin: EdgeInsets.only(left: 12, bottom: 16, right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: wallet.isDefault == '1' ? Border.all(color: Constant.themeColor, width: 1.0) : null,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        CommonImage(src: wallet.icon),
                        SizedBox(width: 7),
                        Text(wallet.title, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16)),
                      ]),
                      Text(
                        wallet.formattedAccountNumber,
                        style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16),
                      )
                    ]),
                  ));
            }),
            _generateAddButton(controller.addButtonAction),
          ]),
        );
      }
    });
  }

  Widget _generateCashView() {
    return Container(child: Center(child: Text('现金取款')));
  }

  Widget _generateBankCardView() {
    return Container(child: Center(child: Text('银行卡列表')));
  }

  Widget _generateAddButton(void Function()? addAction) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: InkWell(
        onTap: addAction,
        child: Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
          child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
        ),
      ),
    );
  }
}