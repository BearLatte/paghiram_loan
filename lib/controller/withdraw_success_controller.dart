import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/router/application_pages.dart';

class WithdrawSuccessController extends GetxController {
  void go2certifyingSmile() {
    CommonSnackBar.showSnackBar('Developing');
  }

  void backAction() {
    Get.until((route) => route.settings.name == ApplicationPages.initial);
  }
}
