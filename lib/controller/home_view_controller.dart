import 'package:get/get.dart';
import 'package:paghiram_loan/controller/loan_tab_controller.dart';
import 'package:paghiram_loan/controller/notes_tab_controller.dart';
import 'package:paghiram_loan/controller/orders_controller.dart';

class HomeViewController extends GetxController {
  var selectedIndex = 2.obs;

  final loanController = Get.find<LoanTabController>();
  final noteController = Get.find<NotesTabController>();
  final orderController = Get.find<OrdersController>();

  void changeSelectIndex(int currentIndex) async {
    selectedIndex.value = currentIndex;
    if (currentIndex == 0) {
      noteController.notes.value = await noteController.getNotes();
    }

    if (currentIndex == 2) {
      loanController.fetchData();
    }

    if (currentIndex == 1) {
      orderController.fetchOrderList();
    }
  }
}
