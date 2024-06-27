import 'dart:collection';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/base_response.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/view/loan/product_status_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/services.dart' show rootBundle;

class LoanTabController extends GetxController {
  var products = <ProductModelEntity>[].obs;
  var marquees = <String>[].obs;

  late RefreshController refreshController;

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController(initialRefreshStatus: RefreshStatus.refreshing);
    fetchData();
    _loadMarqueeList();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  void fetchData() async {
    BaseResponse? response = await NetworkService.fetchHomeData();
    if (response?.status == 0) {
      Global.clearLoginInfo();
    }

    products.value = response?.data ?? [];
    Global.prefs?.setString(Constant.SERVICE_PHONE_NUMBER_ONE, response?.serviceOne ?? '');
    Global.prefs?.setString(Constant.SERVICE_PHONE_NUMBER_TWO, response?.serviceTwo ?? '');
    refreshController.refreshCompleted();
  }

  void _loadMarqueeList() async {
    // fetch Marquee content data
    String marqueeStr = await rootBundle.loadString('asset/data/marquee.json');
    var json = jsonDecode(marqueeStr);
    List<String> tempMarquees = [];
    json.forEach((element) {
      tempMarquees.add(element['text'].trim());
    });
    marquees.value = tempMarquees;
  }

  void menuClick(String type) {
    switch (type) {
      case 'instructions':
        Get.toNamed(ApplicationRoutes.webView, arguments: {
          'title': 'Loan instructions',
          'url': 'https://api.paghiram.top/Api/Help/loanDescription',
          'isShowBottomBar': '0',
        })?.then((value) => fetchData());
      case 'rate':
        Get.toNamed(ApplicationRoutes.webView, arguments: {
          'title': 'Rate description',
          'url': 'https://api.paghiram.top/Api/Help/service_description_ios',
          'isShowBottomBar': '0',
        })?.then((value) => fetchData());
      case 'help':
        Get.toNamed(ApplicationRoutes.webView, arguments: {
          'title': 'Help Center',
          'url': 'https://api.paghiram.top/Api/Help/index',
          'isShowBottomBar': '0',
        })?.then((value) => fetchData());
    }
  }

  void productButtonClickedCallBack(ProductModelEntity product) async {
    switch (product.productState) {
      case ProductStatus.unverified:
        go2Certification('product', product.id);
        return;
      case ProductStatus.normal:
        Get.toNamed(ApplicationRoutes.login)?.then((value) => fetchData());
        return;
      case ProductStatus.rollback:
        Get.toNamed(ApplicationRoutes.cardOCR, arguments: {'type': 1, 'productId': product.id});
        return;
      case ProductStatus.reject:
        go2Feedback();
        return;
      case ProductStatus.canBorrow:
      case ProductStatus.payFailed:
        Get.toNamed(ApplicationRoutes.borrowIndex, arguments: {'product_id': product.id})?.then((value) => fetchData());
        return;
      case ProductStatus.repayment:
        await Global.channel.invokeMapMethod('changeSecureScreenStatus', {'isSecureScreen': true});
        Get.toNamed(ApplicationRoutes.repaymentIndex, arguments: product.id)?.then((value) async {
          await Global.channel.invokeMapMethod('changeSecureScreenStatus', {'isSecureScreen': false});
          fetchData();
        });
        return;
      case ProductStatus.reloan:
        NetworkService.submitCertificationInfo(product.id, () {
          fetchData();
        });
      default:
        go2Certification('product', product.id);
        return;
    }
  }

  void go2Certification(String? type, String? itemId) {
    Get.back();

    if (!Global.isLogin) {
      Get.toNamed(ApplicationRoutes.login)?.then((value) => fetchData());
      return;
    }
    Get.toNamed(ApplicationRoutes.certificationIndex, arguments: {'type': type ?? 'settings', 'itemId': itemId})?.then((value) => fetchData());
  }

  void go2Feedback() {
    Get.back();
    if (!Global.isLogin) {
      Get.toNamed(ApplicationRoutes.login)?.then((value) => fetchData());
    } else {
      Get.toNamed(ApplicationRoutes.feedback)?.then((value) {
        fetchData();
        if (value != null) {
          CommonSnackBar.showSnackBar('Feedback submitted successfully.', type: SnackType.success);
        }
      });
    }
  }

  void go2Settings() {
    Get.back();
    if (!Global.isLogin) {
      Get.toNamed(ApplicationRoutes.login)?.then((value) => fetchData());
    } else {
      Get.toNamed(ApplicationRoutes.settings)?.then((value) => fetchData());
    }
  }

  void go2Policy() {
    Get.back();
    Get.toNamed(ApplicationRoutes.webView, arguments: {
      'title': 'Privacy Policy',
      'url': 'https://api.paghiram.top/Api/Help/register_ios',
      'isShowBottomBar': '0',
    })?.then((value) => fetchData());
  }

  void go2CustomerCenter() {
    Get.back();
    Get.toNamed(ApplicationRoutes.webView, arguments: {
      'title': 'Help Center',
      'url': 'https://api.paghiram.top/Api/Help/index',
      'isShowBottomBar': '0',
    })?.then((value) => fetchData());
  }
}
