import 'package:get/get.dart';
import 'package:paghiram_loan/models/order_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

class OrdersController extends GetxController {
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderList();
  }

  void fetchOrderList() async {
    if (Global.isLogin) {
      List<OrderModel>? list = await NetworkService.getOrderList();
      if (list == null) {
        orders.value = [];
        return;
      }
      orders.value = list;
    } else {
      orders.value = [];
    }
  }

  void repaymentAction(String productId) {
    Get.toNamed(ApplicationRoutes.repaymentIndex, arguments: productId)?.then((value) => fetchOrderList());
  }

  void go2loan() => Get.offAllNamed(ApplicationRoutes.home);
}
