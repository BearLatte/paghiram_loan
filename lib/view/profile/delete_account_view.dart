import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/delete_account_controller.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class DeleteAccountView extends StatelessWidget {
  DeleteAccountView({super.key});

  final controller = Get.find<DeleteAccountController>();

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'Delete Account',
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(12, 40, 12, 50),
            child: Column(children: [
              CommonImage(src: 'asset/icons/delete_account_icon.png'),
              SizedBox(height: 32),
              Text(
                controller.phoneNumber ?? '',
                style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 22),
              Text('We need to review the following information to ensure the security of your account:',
                  style: TextStyle(color: HexColor('#FF102729'), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 22),
              Text('1、No outstanding orders and services in the account.', style: TextStyle(color: HexColor('#FF102729'), fontSize: 14)),
              Text('2.The account is currently a valid and unfrozen account.', style: TextStyle(color: HexColor('#FF102729'), fontSize: 14)),
              Text('3、Identity and account information will be cleared and cannot be recovered.', style: TextStyle(color: HexColor('#FF102729'), fontSize: 14)),
              Text('4、Transaction history will be erased and cannot be recovered.', style: TextStyle(color: HexColor('#FF102729'), fontSize: 14)),
              SizedBox(height: 40),
              TextButton(
                  onPressed: controller.deleteAccountAction,
                  style: TextButton.styleFrom(padding: EdgeInsets.all(5)),
                  child: Container(
                      width: double.infinity,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: HexColor('#FFFF3232')),
                      child: Text('Request Deletion', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)))),
              SizedBox(height: 20),
              InkWell(onTap: controller.go2contactCustomerService,child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: HexColor('#FFFAFAFA')),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Customer Service', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Customer service online time：9:00-18:00', style: TextStyle(color: HexColor('#FF757F8C'), fontSize: 13))
                    ]),
                    Icon(Icons.keyboard_arrow_right, color: HexColor('#FFCCCCCC'), size: 24)
                  ])))
            ])));
  }
}
