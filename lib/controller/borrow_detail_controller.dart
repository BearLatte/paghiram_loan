import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BorrowDetailController extends GetxController {
  var loanAgreementChecked = false.obs;

  void checkLoanAgreementStatus() => loanAgreementChecked.value = !loanAgreementChecked.value;

  void withdrawAction() {}
  void go2readLoanAgreement() {
    debugPrint('DEBUG: 去查看贷款协议');
  }
}
