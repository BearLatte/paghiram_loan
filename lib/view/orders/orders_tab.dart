import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/orders_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class OrdersTab extends StatelessWidget {
  OrdersTab({super.key});

  final controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        isShowConnectCustomers: true,
        navLeading: Center(child: Text('BILL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        child: Obx(() => Column(children: [
              Container(
                  color: Constant.themeColor,
                  height: 72,
                  child: Row(children: [
                    Expanded(
                      child: TextButton(
                          onPressed: controller.pendingItemOnTap,
                          child: Container(
                              width: double.infinity,
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              height: 40,
                              alignment: Alignment.center,
                              decoration:
                                  BoxDecoration(color: controller.isOrderTypePending.value ? Colors.white : HexColor('#29FFFFFF'), borderRadius: BorderRadius.circular(100)),
                              child: Text('Pending',
                                  style: TextStyle(color: controller.isOrderTypePending.value ? Constant.themeColor : Colors.white, fontSize: 16, fontWeight: FontWeight.w600)))),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: controller.historyItemOnTap,
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              alignment: Alignment.center,
                              decoration:
                                  BoxDecoration(color: controller.isOrderTypePending.value ? HexColor('#29FFFFFF') : Colors.white, borderRadius: BorderRadius.circular(100)),
                              child: Text('History',
                                  style: TextStyle(color: controller.isOrderTypePending.value ? Colors.white : Constant.themeColor, fontSize: 16, fontWeight: FontWeight.w600)))),
                    )
                  ])),
              Expanded(
                  child: SingleChildScrollView(
                      child: controller.isOrderTypePending.value ? pendingWidget(controller.pendingOrders.value) : historyWidget(controller.historyOrders.value)))
            ])));
  }

  Widget pendingWidget(List orders) {
    return orders.isEmpty
        ? Column(children: [
            SizedBox(height: 40),
            CommonImage(src: 'asset/icons/order_empty_icon.png'),
            SizedBox(height: 24),
            Text('You have not borrowed yet, No loan details yet', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)),
            SizedBox(height: 24),
            TextButton(
                onPressed: controller.go2loan,
                child: Container(
                  width: 130,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(20)),
                  child: Text('Get Loan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ))
          ])
        : Column();
  }

  Widget historyWidget(List orders) {
    return orders.isEmpty
        ? Column(children: [
            SizedBox(height: 40),
            CommonImage(src: 'asset/icons/order_empty_icon.png'),
            SizedBox(height: 24),
            Text('You have not borrowed yet, No loan details yet', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 15)),
            SizedBox(height: 24),
            TextButton(
                onPressed: controller.go2loan,
                child: Container(
                  width: 130,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(20)),
                  child: Text('Get Loan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ))
          ])
        : Column();
  }
}
