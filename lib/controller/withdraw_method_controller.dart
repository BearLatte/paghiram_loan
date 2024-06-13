import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_bottom_sheet.dart';
import 'package:paghiram_loan/controller/borrow_detail_controller.dart';
import 'package:paghiram_loan/models/e_wallet_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';

class WithdrawMethodController extends GetxController {
  var selectedItem = 0.obs;
  var eWalletList = <EWalletModel>[].obs;

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
  }

  Future<void> _getBoundEWalletList() async {
    List<EWalletModel>? wallets = await NetworkService.fetchUserBoundEWallet();
    if (wallets == null) return;
    eWalletList.value = wallets;
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
    }
  }
}
