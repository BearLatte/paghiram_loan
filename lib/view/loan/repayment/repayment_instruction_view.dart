import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';

import '../../../controller/repayment/repayment_instruction_controller.dart';

class RepaymentInstructionView extends StatelessWidget {
  RepaymentInstructionView({super.key});

  final controller = Get.find<RepaymentInstructionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CommonView(
        title: controller.title.value,
        isShowConnectCustomers: true,
        child: SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
          CommonImage(src: controller.imgPath.value, fit: BoxFit.cover,)
        ])),
      ),
    );
  }
}
