import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/controller/withdraw_confirm_controller.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../../common/common_image.dart';
import '../../../router/application_routes.dart';
import '../../../util/constant.dart';
import '../../../util/hex_color.dart';

class WithdrawConfirmView extends StatelessWidget {
  WithdrawConfirmView({super.key});

  final controller = Get.find<WithdrawConfirmController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: HideKeyboardWrapper(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 52,
                        alignment: Alignment.center,
                        color: Constant.themeColor,
                        child: Text('Confirm loan information', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      ...List.generate(4, (index) {
                        late String title;
                        late String value;
                        switch (index) {
                          case 0:
                            title = 'Loan Amount';
                            value = 'PHP ${controller.loanAmount.value}';
                          case 1:
                            title = 'Loan Term';
                            value = controller.loanTerm.value;
                          case 2:
                            if (controller.withdrawType.value == 0) {
                              title = 'E-Wallet';
                            } else {
                              title = 'Bank Name';
                            }
                            value = controller.withdrawName.value;
                          case 3:
                            if (controller.withdrawType.value == 0) {
                              title = 'E-Wallet Account No.';
                            } else {
                              title = 'Bank Account No.';
                            }
                            value = controller.withdrawNumber.value;
                        }
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16)),
                                Text(value, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 16))
                              ],
                            ));
                      }),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Text('Please enter the registration password', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 48),
                        child: Obx(() => TextField(
                              obscureText: controller.isObscureText.value,
                              controller: controller.passwordController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#FF102729'), width: 0.5)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: HexColor('#FF102729'), width: 0.5)),
                                suffixIcon: IconButton(
                                    onPressed: () => controller.isObscureText.value = !controller.isObscureText.value,
                                    icon: controller.isObscureText.value ? CommonImage(src: 'asset/icons/eye_close_icon.png') : CommonImage(src: 'asset/icons/eye_open_icon.png')),
                              ),
                            )),
                      ),
                      InkWell(
                          onTap: () => Get.toNamed(ApplicationRoutes.changePwd, arguments: ''),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('Forget Password?', style: TextStyle(color: Constant.themeColor, fontSize: 15)),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 14),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            InkWell(
                                onTap: Get.back,
                                child: Container(
                                  width: 140,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: HexColor('#FFEBF8F9'), borderRadius: BorderRadius.circular(100)),
                                  child: Text('Cancel', style: TextStyle(color: Constant.themeColor, fontSize: 15, fontWeight: FontWeight.w600)),
                                )),
                            InkWell(
                                onTap: () => Get.back(result: 'confirm'),
                                child: Container(
                                  width: 140,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Constant.themeColor, borderRadius: BorderRadius.circular(100)),
                                  child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                                )),
                          ]))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
