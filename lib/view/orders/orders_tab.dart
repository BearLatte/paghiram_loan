import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/orders_controller.dart';
import 'package:paghiram_loan/models/order_model.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class OrdersTab extends StatelessWidget {
  OrdersTab({super.key});

  final controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      isShowConnectCustomers: true,
      isCneterTitle: false,
      title: 'Orders',
      backgroundColor: HexColor('#FFFAFAFA'),
      isShowBackIcon: false,
      child: Obx(
        () => controller.orders.isEmpty
            ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                CommonImage(src: 'asset/icons/order_empty_icon.png'),
                Container(
                  alignment: Alignment.center,
                  child: Text('You have not borrowed yet, No loan details yet', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)),
                ),
                SizedBox(height: 24),
                TextButton(
                  onPressed: controller.go2loan,
                  child: Container(
                    width: 130,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(20)),
                    child: Text('Get Loan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                )
              ])
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(controller.orders.length, ((index) {
                      OrderModel item = controller.orders[index];
                      if (item.status == 1) {
                        return Container(
                          margin: EdgeInsets.only(top: 16),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: HexColor('#FFFF3232'), width: 0.5)),
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6')))),
                              child: Column(children: [
                                Row(children: [
                                  CommonImage(src: 'asset/icons/product_logo_normal.png'),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(item.packName, style: TextStyle(color: HexColor('#FF102729'))))
                                ])
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  _itemRow(title: 'Total Repayment', value: 'PHP ${Global.formatCurrency(item.price)}'),
                                  _itemRow(title: 'Repayment Date', value: item.formattedBackTime, valueColor: '#FFFF3232'),
                                  _itemRow(title: 'Overdue days', value: item.overdueDays + 'days', valueColor: '#FFFF3232'),
                                  SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () => controller.repaymentAction(item.pid),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor('#FFFF3232'),
                                      foregroundColor: Colors.white,
                                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    child: Text('Late Payment'),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: 16),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
                              child: Row(children: [CommonImage(src: 'asset/icons/product_logo_normal.png'), SizedBox(width: 8), Text(item.packName)]),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 16, 12, 20),
                              child: Column(
                                children: [
                                  _itemRow(title: 'Total Repayment', value: 'PHP ${Global.formatCurrency(item.price)}'),
                                  _itemRow(title: 'Repayment Date', value: item.formattedBackTime),
                                  SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () => controller.repaymentAction(item.pid),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Constant.themeColor,
                                      foregroundColor: Colors.white,
                                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    child: Text('To Repay'),
                                  )
                                ],
                              ),
                            )
                          ]),
                        );
                      }
                    })),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 40),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(color: HexColor('#14FF3232'), borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Please do not make repayments through unofficial channels to avoid fraud. If you encounter any issues with repayment, you can always contact official customer service.',
                        style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _itemRow({required String title, required String value, String valueColor = '#FF102729'}) {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: TextStyle(color: HexColor('FF102729'), fontSize: 15)),
          Text(value, style: TextStyle(color: HexColor(valueColor), fontSize: 15)),
        ]));
  }
}
