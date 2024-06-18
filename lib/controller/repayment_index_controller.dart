import 'package:get/get.dart';
import 'package:paghiram_loan/models/repayment_detail_model.dart';
import 'package:paghiram_loan/service/index.dart';

class RepaymentIndexController extends GetxController {
  late RepaymentDetailModel detailModel;

  @override
  void onInit() async {
    super.onInit();
    _productId = Get.arguments;
    RepaymentDetailModel? model = await NetworkService.fetchRepaymentData(_productId);
    if (model == null) return;
    detailModel = model;
  }

  late String _productId;
}
