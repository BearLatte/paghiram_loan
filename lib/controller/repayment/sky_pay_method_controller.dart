import 'package:get/get.dart';
import 'package:paghiram_loan/models/repayment_method_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';

class SkyPayMethodController extends GetxController {
  var repaymentAmount = ''.obs;
  var selectedItem = 0.obs;
  var methodsList = <List<RepaymentMethodModel>>[
    [
      RepaymentMethodModel(img: 'asset/icons/gcash_icon.png', title: 'GCash', isChecked: false, isRecommended: true),
      RepaymentMethodModel(img: 'asset/icons/paymaya_icon.png', title: 'PayMaya', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/shopee_icon.png', title: 'ShopeePay', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/bpi_icon.png', title: 'BPI QuickPay', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/lazada_wallet_icon.png', title: 'Lazada', isChecked: false, isRecommended: false),
    ],
    [
      RepaymentMethodModel(img: 'asset/icons/711_icon.png', title: '7-11', isChecked: false, isRecommended: false, needsShowBarCode: true),
      RepaymentMethodModel(img: 'asset/icons/mlhuillier_icon.png', title: 'MLhuillier', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/cebuana_icon.png', title: 'Cebuana Lhuillier', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/palawan_icon.png', title: 'Palawan EXPRESS', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/rd_icon.png', title: 'RD Pawnshop', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/true_money_icon.png', title: 'True Money', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/lbc_icon.png', title: 'LBC Express', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/ussc_icon.png', title: 'USSC', isChecked: false, isRecommended: false),
    ],
    [
      RepaymentMethodModel(img: 'asset/icons/union_bank_icon.png', title: 'Union Bank', isChecked: false, isRecommended: false),
      RepaymentMethodModel(img: 'asset/icons/bdo_icon.png', title: 'BDO', isChecked: false, isRecommended: false),
    ]
  ].obs;

  @override
  void onInit() {
    super.onInit();
    repaymentAmount.value = Get.arguments['repaymentAmount'];
  }

  void methodItemClicked(int index) => selectedItem.value = index;

  void selectedMethod(RepaymentMethodModel item) {
    Get.toNamed(ApplicationRoutes.skyPayBarCode, arguments: {
      'title': selectedItem == 2 ? 'Bank' : item.title,
      'isShowBarCode': item.needsShowBarCode,
      'type': Get.arguments['type'],
      'gid': Get.arguments['gid'],
      'productId': Get.arguments['productId'],
    });
  }
}
