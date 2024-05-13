import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/controller/home_view_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/loan/loan_tab.dart';
import 'package:paghiram_loan/view/notes/notes_tab.dart';

import 'orders/orders_tab.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.find<HomeViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [HexColor('#FFFFBC6A'), HexColor('#FFFFA63D')]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextButton(
          onPressed: () => controller.changeSelectIndex(2),
          child: const Center(child: Text('Loan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() => tabViews[controller.selectedIndex.value]),
      bottomNavigationBar: BottomAppBar(
        height: 49,
        elevation: 0.0,
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.changeSelectIndex(0),
                    child: Obx(() => Column(children: [
                          CommonImage(src: controller.selectedIndex.value == 0 ? 'asset/icons/tab_notes_selected.png' : 'asset/icons/tab_notes_normal.png', height: 24),
                          Text('Notes', style: TextStyle(fontSize: 10, color: controller.selectedIndex.value == 0 ? Constant.themeColor : HexColor('#FFB7BAC4')))
                        ])))),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.changeSelectIndex(1),
                    child: Obx(() => Column(children: [
                          CommonImage(src: controller.selectedIndex.value == 1 ? 'asset/icons/tab_orders_selected.png' : 'asset/icons/tab_orders_normal.png', height: 24),
                          Text('Orders', style: TextStyle(fontSize: 10, color: controller.selectedIndex.value == 1 ? Constant.themeColor : HexColor('#FFB7BAC4')))
                        ])))),
          ],
        ),
      ),
    );
  }
}

List<Widget> tabViews = [NotesTab(), OrdersTab(), LoanTab()];
