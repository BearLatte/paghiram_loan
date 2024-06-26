import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/certification/liveness_instructions_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

enum InstructType { correct, squint, backLight }

class LivenessInstructionsView extends StatelessWidget {
  LivenessInstructionsView({super.key});

  final controller = Get.find<LivenessInstructionsControll>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Face Photo',
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Face  Authentication', textAlign: TextAlign.center, style: TextStyle(color: Constant.themeColor, fontSize: 22, fontWeight: FontWeight.w600)),
              Text('Face in the frame please. Make sure your face is clear.', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
              Container(padding: EdgeInsets.symmetric(horizontal: 57), child: CommonImage(src: 'asset/icons/liveness_instruction_main.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _createInstructItem(InstructType.correct),
                  _createInstructItem(InstructType.squint),
                  _createInstructItem(InstructType.backLight),
                ],
              ),
              TextButton(
                  onPressed: controller.go2doLiveness,
                  child: Container(
                      decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                      height: 52,
                      alignment: Alignment.center,
                      child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))))
            ],
          ),
        ),
      ),
    );
    CommonView(
        title: 'Face Photo', child: Container(color: Colors.white, child: SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 34), child: Container())));
  }

  Widget _createInstructItem(InstructType type) {
    late String text;
    late String icon;
    late String markIcon;
    switch (type) {
      case InstructType.correct:
        text = 'Face the phone';
        icon = 'asset/icons/instruction_correct.png';
        markIcon = 'asset/icons/instruct_correct_mark.png';
      case InstructType.squint:
        text = 'FSquint phone';
        icon = 'asset/icons/instruction_squint.png';
        markIcon = 'asset/icons/instruct_error_mark.png';
      case InstructType.backLight:
        text = 'Back light';
        icon = 'asset/icons/instruct_back_light.png';
        markIcon = 'asset/icons/instruct_error_mark.png';
    }

    return Column(
      children: [
        CommonImage(src: icon),
        SizedBox(height: 5),
        CommonImage(src: markIcon),
        SizedBox(height: 5),
        Text(text, style: TextStyle(fontSize: 12, color: HexColor('#FF757F8C'))),
      ],
    );
  }
}
