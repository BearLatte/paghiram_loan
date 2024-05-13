import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';

class FeedbackImageEnlargeView extends StatelessWidget {
  FeedbackImageEnlargeView({super.key});

  final _imagePath = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.only(left: 38, right: 38),
            constraints: BoxConstraints(maxHeight: 650),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.blueAccent),
            child: CommonImage(src: _imagePath, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          IconButton(onPressed: Get.back, icon: CommonImage(src: 'asset/icons/close_icon.png'))
        ]),
      ),
    );
  }
}
