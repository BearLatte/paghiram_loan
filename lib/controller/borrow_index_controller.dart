import 'package:get/get.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:paghiram_loan/util/global.dart';

class BorrowIndexController extends GetxController {
  // product_id
  late String productId;

  // late BorrowDetailModel borrowModel;
  late BorrowDetailModel borrowModel;

  //
  late BorrowDetailModelUserData currentUserData;

  // can borrow max amount


  // can borrow min amount

  var currentBorrowAmount = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    productId = Get.arguments['product_id'];
  }

  Future<void> fetchProductRate() async {
    BorrowDetailModel? detailModel = await NetworkService.fetchProductRate(productId);
    if (detailModel == null) return;
    borrowModel = detailModel;
    currentBorrowAmount.value = Global.formatCurrency(detailModel.maxPrice);
  }


  void termSelectAction(int index) {
    if(index != 0) {
      CommonSnackBar.showSnackBar("Repay on time for a longer loan term.")
    }
  }
}
