import 'package:get/get.dart';

class SkyPayMethodController extends GetxController {
  var repaymentAmount = '占位金额'.obs;
  var selectedItem = 0.obs;


  @override
  void onInit() {
    super.onInit();
    print('DEBUG: 当前还款类型为 SkyPay, 当前还款金额为: ${Get.arguments}');
  }

  void methodItemClicked(int index) => selectedItem.value = index;
}