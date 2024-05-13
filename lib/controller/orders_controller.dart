import 'package:get/get.dart';
import 'package:paghiram_loan/router/application_routes.dart';

class OrdersController extends GetxController {
  var isOrderTypePending = true.obs;
  var pendingOrders = [].obs;
  var historyOrders = [].obs;

  void pendingItemOnTap() => isOrderTypePending.value = true;

  void historyItemOnTap() => isOrderTypePending.value = false;

  void go2contactCustomerService() => Get.toNamed(ApplicationRoutes.webView, arguments: {
        'title': 'Help Center',
        'url': 'https://api.paghiram.top/Api/Help/index',
      });

  void go2loan() => Get.offAllNamed(ApplicationRoutes.home);
}