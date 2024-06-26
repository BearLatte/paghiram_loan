import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/router/application_routes.dart';

import '../models/withdraw_method_model.dart';
import '../service/index.dart';

class AddEWalletController extends GetxController {
  var eWalletCategories = <EWalletCategory>[].obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController walletNameController = TextEditingController();
  TextEditingController walletNoController = TextEditingController();
  TextEditingController repeatNoController = TextEditingController();

  EWalletCategory? selectedWalletCategory;

  @override
  void onInit() async {
    super.onInit();
    await _getEWalletCategories();

    fullNameController.text = Get.arguments;

    walletNoController.addListener(() {
      if (RegExp('^09').hasMatch(walletNoController.text) || RegExp('^08').hasMatch(walletNoController.text)) {
        if (walletNoController.text.trim().length > 11) {
          walletNoController.text = walletNoController.text.substring(0, 11);
        }
      } else {
        if (walletNoController.text.trim().length > 10) {
          walletNoController.text = walletNoController.text.substring(0, 10);
        }
      }
    });
    repeatNoController.addListener(() {
      if (RegExp('^09').hasMatch(repeatNoController.text) || RegExp('^08').hasMatch(repeatNoController.text)) {
        if (repeatNoController.text.trim().length > 11) {
          repeatNoController.text = repeatNoController.text.substring(0, 11);
        }
      } else {
        if (repeatNoController.text.trim().length > 10) {
          repeatNoController.text = repeatNoController.text.substring(0, 10);
        }
      }
    });
  }

  @override
  void onClose() {
    fullNameController.dispose();
    walletNameController.dispose();
    walletNoController.dispose();
    repeatNoController.dispose();
    super.onClose();
  }

  Future<void> _getEWalletCategories() async {
    List<EWalletCategory>? categories = await NetworkService.fetchEWalletCategories();
    if (categories == null) return;
    eWalletCategories.value = categories;
  }

  void go2selectEWalletName() async {
    List<String> options = [];
    eWalletCategories.forEach((item) => options.add(item.title));
    int? selectedIndex = await CommonBottomSheet.showBottomSheet('E-Wallet', options: options);
    if (selectedIndex == null) return;
    selectedWalletCategory = eWalletCategories[selectedIndex];
    walletNameController.text = selectedWalletCategory?.title ?? '';
  }

  void confirmAction() async {
    String fullName = fullNameController.text.trim();
    String walletNumber = walletNoController.text.trim();
    String repeatNumber = repeatNoController.text.trim();

    if (RegExp('[\\-\\*\\&\\%\$\\@\\#\\^\\.\\~\\?\\)\\(\\[\\]\\+\\=\\!]').hasMatch(fullName)) return CommonSnackBar.showSnackBar('Please input your name in the correct format!');

    if (fullName.isEmpty) return CommonSnackBar.showSnackBar('Full name item cannot be empty!');
    if (selectedWalletCategory == null) return CommonSnackBar.showSnackBar('Please select E-Wallet name!');

    if (!RegExp('^9').hasMatch(walletNumber) && !RegExp('^8').hasMatch(walletNumber) && !RegExp('^09').hasMatch(walletNumber) && !RegExp('^08').hasMatch(walletNumber)) {
      if ((RegExp('^9').hasMatch(walletNumber) || RegExp('^8').hasMatch(walletNumber)) && walletNumber.length != 10) {
        return CommonSnackBar.showSnackBar('Please enter the correct e-wallet account number.');
      }

      if ((RegExp('^09').hasMatch(walletNumber) || RegExp('^08').hasMatch(walletNumber)) && walletNumber.length != 11) {
        return CommonSnackBar.showSnackBar('Please enter the correct e-wallet account number.');
      }
    }
    if (walletNumber != repeatNumber) return CommonSnackBar.showSnackBar('The accounts filled in twice are different. Please check again.');

    Map<String, dynamic> params = {'account_number': walletNumber, 'channel_id': selectedWalletCategory!.id};

    bool isSuccess = await NetworkService.addNewEWallet(params);
    if (isSuccess) Get.back(result: 'success');
  }
}
