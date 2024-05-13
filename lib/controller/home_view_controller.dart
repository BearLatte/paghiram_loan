import 'package:get/get.dart';
import 'package:paghiram_loan/controller/loan_tab_controller.dart';

class HomeViewController extends GetxController {
  var selectedIndex = 2.obs;

  final controller = Get.find<LoanTabController>();

  void changeSelectIndex(int currentIndex) {
    selectedIndex.value = currentIndex;
    if(currentIndex == 2) {
      controller.fetchData();
    }
  }
}