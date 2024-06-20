import 'package:get/get.dart';

class SkyPayMethodController extends GetxController {
  var repaymentAmount = '占位金额'.obs;
  var selectedItem = 0.obs;


  @override
  void onInit() {
    super.onInit();
    repaymentAmount.value = Get.arguments;
  }

  void methodItemClicked(int index) => selectedItem.value = index;
}