import 'package:get/get.dart';
import 'package:paghiram_loan/models/order_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';

class OrdersController extends GetxController {
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchOrderList();
  }

  void _fetchOrderList() async {
    List<OrderModel>? list = await NetworkService.getOrderList();
    if (list == null) return;
    orders.value = list;
  }

  void repaymentAction(String productId) {
    Get.toNamed(ApplicationRoutes.repaymentIndex, arguments: productId)?.then((value) => _fetchOrderList());
  }

  void go2loan() => Get.offAllNamed(ApplicationRoutes.home);
}
