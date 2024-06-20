import 'package:get/get.dart';
import 'package:paghiram_loan/util/global.dart';

class PayCoolsMethodController extends GetxController {
  var repaymentAmount = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // repaymentAmount.value = 'PHP ${Global.formatCurrency(Get.arguments)}';
    print('DEBUG: 当前还款类型为 PayCools 当前还款金额为: ${Get.arguments}');
  }
}