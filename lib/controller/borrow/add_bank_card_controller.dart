import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/service/index.dart';

import '../../models/withdraw_method_model.dart';

class AddBankCardController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();
  TextEditingController repeatNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  List<BankCardCategory> _bankList = [];

  BankCardCategory? _selectedBankCard;

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = Get.arguments;

    bankNumberController.addListener(() {
      if (bankNumberController.text.trim().length > 16) {
        bankNumberController.text = bankNumberController.text.substring(0, 16);
      }
    });

    repeatNumberController.addListener(() {
      if (repeatNumberController.text.trim().length > 16) {
        repeatNumberController.text = repeatNumberController.text.substring(0, 16);
      }
    });

    phoneNumberController.addListener(() {
      if (RegExp('^09').hasMatch(phoneNumberController.text) || RegExp('^08').hasMatch(phoneNumberController.text)) {
        if (phoneNumberController.text.trim().length > 11) {
          phoneNumberController.text = phoneNumberController.text.substring(0, 11);
        }
      } else {
        if (phoneNumberController.text.trim().length > 10) {
          phoneNumberController.text = phoneNumberController.text.substring(0, 10);
        }
      }
    });

    _getBankList();
  }

  void _getBankList() async {
    List<BankCardCategory>? allBank = await NetworkService.fetchBankList();
    if (allBank == null) return;
    _bankList = allBank;
  }

  void go2selectBankName() async {
    List<String> options = [];
    _bankList.forEach((item) => options.add(item.bankname));
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('Bank Name', options: options);
    if (selectedIndex == null) return;
    _selectedBankCard = _bankList[selectedIndex];
    bankNameController.text = _selectedBankCard?.bankname ?? '';
  }

  void confirmAction() async {
    String userName = fullNameController.text.trim();
    String phone = phoneNumberController.text.trim();
    String bankNumber = bankNumberController.text.trim();
    String repeatNumber = repeatNumberController.text.trim();

    if (RegExp('[\\-\\*\\&\\%\$\\@\\#\\^\\.\\~\\?\\)\\(\\[\\]\\+\\=\\!]').hasMatch(userName)) {
      return CommonSnackBar.showSnackBar('Please input your name in the correct format!');
    }

    if (_selectedBankCard == null) {
      return CommonSnackBar.showSnackBar('Please select bank name!');
    }

    if (bankNumber.length < 10) {
      return CommonSnackBar.showSnackBar('Please enter the correct bank card number.!');
    }

    if (bankNumber != repeatNumber) {
      return CommonSnackBar.showSnackBar('The accounts filled in twice are different. Please check again.');
    }

    if (!RegExp('^9').hasMatch(phone) && !RegExp('^8').hasMatch(phone) && !RegExp('^09').hasMatch(phone) && !RegExp('^08').hasMatch(phone)) {
      if ((RegExp('^9').hasMatch(phone) || RegExp('^8').hasMatch(phone)) && phone.length != 10) {
        return CommonSnackBar.showSnackBar('Please enter a valid phone number.');
      }

      if ((RegExp('^09').hasMatch(phone) || RegExp('^08').hasMatch(phone)) && phone.length != 11) {
        return CommonSnackBar.showSnackBar('Please enter a valid phone number.');
      }
    }

    Map<String, dynamic> params = {
      'phone': phone,
      'username': userName,
      'bank_number': bankNumber,
      'bid': _selectedBankCard!.bankid,
    };

    bool isSuccess = await NetworkService.addNewBankCard(params);
    if (isSuccess) {
      Get.back(result: 'success');
    }
  }
}
