import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/withdraw_method_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';

class WithdrawMethodController extends GetxController {
  var selectedItem = 0.obs;
  var eWalletList = <WithdrawMethodModel>[].obs;
  var bankCards = <WithdrawMethodModel>[].obs;

  late String _fullName;

  @override
  void onInit() async {
    super.onInit();

    await _getBoundEWalletList();
    await _fetchBindingCardDefaultName();
  }

  void itemSelectAction(int index) {
    selectedItem.value = index;
    if (index == 0) {
      _getBoundEWalletList();
    }

    if (index == 1) {
      _getBoundBankCardList();
    }
  }

  void didSelectedItem(WithdrawMethodModel item) async {
    if (item.type == 0) {
      bool isSuccess = await NetworkService.updateDefaultEWalletAccount(item.id);
      if (isSuccess) Get.back(result: {'type': 0, 'item': item});
    } else {
      bool isSuccess = await NetworkService.updateDefaultBankAccount(item.id);
      if (isSuccess) Get.back(result: {'type': 1, 'item': item});
    }
  }

  Future<void> _getBoundEWalletList() async {
    List<WithdrawMethodModel>? wallets = await NetworkService.fetchUserBoundEWallet();
    if (wallets == null) return;
    eWalletList.value = wallets;
  }

  Future<void> _getBoundBankCardList() async {
    List<WithdrawMethodModel>? bankCardList = await NetworkService.fetchUserBoundBankCards();
    if (bankCardList == null) return;
    bankCards.value = bankCardList;
  }

  Future<void> _fetchBindingCardDefaultName() async {
    CardBindingData? nameData = await NetworkService.fetchCardBindingNameData();
    if (nameData == null) return;
    _fullName = '${nameData.nameOne} ${nameData.nameTwo} ${nameData.nameThree}';
  }

  void addButtonAction() async {
    if (selectedItem.value == 0) {
      var result = await Get.toNamed(ApplicationRoutes.addEWallet, arguments: _fullName);
      if (result != null) {
        await _getBoundEWalletList();
        late WithdrawMethodModel wallet;
        for (var item in eWalletList) {
          if (item.isDefault == '1') {
            wallet = item;
            break;
          }
        }
        Get.back(result: wallet);
      }
    } else if (selectedItem.value == 1) {
      var result = await Get.toNamed(ApplicationRoutes.addBankCard, arguments: _fullName);
      if (result == 'success') _getBoundBankCardList();
    }
  }
}
