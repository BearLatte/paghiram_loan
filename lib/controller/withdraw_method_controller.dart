import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/controller/borrow_detail_controller.dart';
import 'package:paghiram_loan/models/bank_card_model.dart';
import 'package:paghiram_loan/models/e_wallet_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';

class WithdrawMethodController extends GetxController {
  var selectedItem = 0.obs;
  var eWalletList = <EWalletModel>[].obs;
  var bankCards = <BankCardModel>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await _getBoundEWalletList();
  }

  void itemSelectAction(int index) {
    selectedItem.value = index;
    if (index == 0) {
      _getBoundEWalletList();
    }

    if (index == 2) {
      _getBoundBankCardList();
    }
  }

  Future<void> _getBoundEWalletList() async {
    List<EWalletModel>? wallets = await NetworkService.fetchUserBoundEWallet();
    if (wallets == null) return;
    eWalletList.value = wallets;
  }

  Future<void> _getBoundBankCardList() async {
    List<BankCardModel>? bankCardList = await NetworkService.fetchUserBoundBankCards();
    if(bankCardList == null) return;
    bankCards.value = bankCardList;
  }

  void go2cashWithdraw() {
    debugPrint('DEBUG: 进行现金取款');
  }

  void addButtonAction() async {
    if (selectedItem.value == 0) {
      var result = await Get.toNamed(ApplicationRoutes.addEWallet);
      if (result != null) {
        await _getBoundEWalletList();
        late EWalletModel wallet;
        for (var item in eWalletList) {
          if (item.isDefault == '1') {
            wallet = item;
            break;
          }
        }
        Get.back(result: wallet);
      }
    } else if (selectedItem.value == 2) {
      Get.toNamed(ApplicationRoutes.addBankCard);
    }
  }
}
