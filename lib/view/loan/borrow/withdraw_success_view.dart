import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/withdraw_success_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class WithdrawSuccessView extends StatelessWidget {
  WithdrawSuccessView({super.key});

  final controller = Get.find<WithdrawSuccessController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
      title: 'Paghiram Loan',
      backgroundColor: Colors.white,
      navLeadingAction: controller.backAction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  CommonImage(src: 'asset/icons/withdraw_success_icon.png'),
                  SizedBox(height: 20),
                  Container(
                      alignment: Alignment.center, child: Text('Submitted Successfully', style: TextStyle(color: Constant.themeColor, fontSize: 18, fontWeight: FontWeight.w600))),
                  SizedBox(height: 16),
                  Text('The withdrawal operation is successful, your loan will be credited to your account as soon as possible.',
                      style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
                ],
              ),
            ),
            // InkWell(
            //   onTap: controller.go2certifyingSmile,
            //   child: Container(
            //     width: double.infinity,
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            //     decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(12)),
            //     child: Column(children: [
            //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //         Text('Smile Certification', style: TextStyle(color: Constant.themeColor, fontSize: 16, fontWeight: FontWeight.bold)),
            //         Icon(
            //           Icons.arrow_forward_rounded,
            //           color: Constant.themeColor,
            //           size: 24,
            //         )
            //       ]),
            //       Container(
            //         padding: EdgeInsets.only(top: 14),
            //         child: Text('Adding authentication information can increase the credit limit for loans.', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 13)),
            //       )
            //     ]),
            //   ),
            // ),
            SizedBox(height: 40),
            InkWell(
              onTap: controller.backAction,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                child: Text('Close', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
