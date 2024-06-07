import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/borrow_index_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
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
                // Text(
                //   controller.borrowModel.value.maxPriceFormat ?? '',
                //   style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Impact'),
                // ),
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
              SizedBox(height: 16),
              SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 9,
                    activeTrackColor: Constant.themeColor,
                    inactiveTrackColor: HexColor('#FFEBF8F9'),
                    trackShape: CustomTrackShape(addHeight: 9),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  ),
                  child: Slider(value: 0, onChanged: (value) {})),
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('2000', style: TextStyle(color: HexColor('#FFAAAAAA'), fontSize: 12)),
                    Text('50000', style: TextStyle(color: HexColor('#FFAAAAAA'), fontSize: 12)),
                  ],
                ),
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(padding: EdgeInsets.only(bottom: 10), child: Text('Loan Term', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) {
                    return InkWell(
                        onTap: () => controller.termSelectAction(index),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(8)),
                            child: Text('90days', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))));
                  },
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  CustomTrackShape({this.addHeight = 0});

  double addHeight;

  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 1;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
  }
}
