import 'package:diamond_node_slider/diamond_node_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/borrow_index_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

import '../../../common/common_image.dart';
import '../../../router/application_routes.dart';

class BorrowIndex extends StatelessWidget {
  BorrowIndex({super.key});

  final controller = Get.find<BorrowIndexController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Loan',
      navTrailings: [
        IconButton(
          onPressed: () => Get.toNamed(ApplicationRoutes.webView, arguments: {
            'title': 'Help Center',
            'url': 'https://api.paghiram.top/Api/Help/index',
          }),
          icon: CommonImage(src: 'asset/icons/certify_customer_service_icon.png'),
        )
      ],
      child: FutureBuilder(
        future: controller.fetchProductRate(),
        builder: (BuildContext context, AsyncSnapshot snapshot) => Column(children: [
          Container(
            color: Constant.themeColor,
            padding: EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: HexColor('#33FFFFFF'), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text('Maximum Loan Amount', style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(height: 12),
                Text(
                  controller.borrowModel?.value.maxPriceFormat ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Impact'),
                ),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 3),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('Lan Amount(PHP)', style: TextStyle(color: HexColor('#FF102729'))),
              SizedBox(height: 10),
              Text(controller.currentBorrowAmount.value, style: TextStyle(color: HexColor('#FF102729'), fontSize: 24)),
              SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 9,
                    activeTrackColor: Constant.themeColor,
                    inactiveTrackColor: HexColor('#FFEBF8F9'),
                  ),
                  child: Slider(value: 0, onChanged: (value) {}))
            ]),
          )
        ]),
      ),
    );
  }
}
