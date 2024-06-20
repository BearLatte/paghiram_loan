import 'package:get/get.dart';
import 'package:paghiram_loan/models/repayment_method_model.dart';

class PayCoolsMethodController extends GetxController {
  var repaymentAmount = ''.obs;
  var methodList = <RepaymentMethodModel>[
    RepaymentMethodModel(img: 'asset/icons/qr_icon.png', title: 'OR Code', isChecked: false, isRecommended: false, titleColor: '#FFFEB099'),
    RepaymentMethodModel(img: 'asset/icons/gcash_icon.png', title: 'GCash', isChecked: true, isRecommended: true),
    RepaymentMethodModel(img: 'asset/icons/paymaya_icon.png', title: 'PayMaya', isChecked: false, isRecommended: false),
    RepaymentMethodModel(img: 'asset/icons/711_icon.png', title: '7-11', isChecked: false, isRecommended: false),
    RepaymentMethodModel(img: 'asset/icons/mlhuillier_icon.png', title: 'M Lhuillier', isChecked: false, isRecommended: false),
    RepaymentMethodModel(img: 'asset/icons/rd_icon.png', title: 'RD', isChecked: false, isRecommended: false),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    repaymentAmount.value = Get.arguments;
  }

  void itemSelected(RepaymentMethodModel item) {
    methodList.forEach((method) {
      if(method == item) {
        method.isChecked = true;
      } else {
        method.isChecked = false;
      }
    });

    methodList.refresh();
  }
}
