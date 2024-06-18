import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/repayment_index_controller.dart';

class RepaymentIndex extends StatelessWidget {
  RepaymentIndex({super.key});

  final controller = Get.find<RepaymentIndexController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(title: 'Repayment Details',child: Container());
  }
}
