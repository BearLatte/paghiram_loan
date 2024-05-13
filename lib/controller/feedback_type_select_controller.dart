import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';

class FeedbackTypeSelectController extends GetxController {
  List<String> allTypes = ['Unprofessional collection', 'Repayment is not timely', 'Unable to repay automatically', 'Humiliation/threat', 'Other'];
  List<int> selectedIndexes = [];

  @override
  void onInit() {
    super.onInit();
    var preselectedProblems = Get.arguments;
    preselectedProblems.forEach((element) {
      selectedIndexes.add(allTypes.indexOf(element));
    });
  }

  void selectedTypeAction(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
    update();
  }

  void confirmAction() {
    if (selectedIndexes.isEmpty) return CommonSnackBar.showSnackBar('Please select at least one problem type before confirming');
    List<String> selectedProblems = [];
    selectedIndexes.forEach((element) {
      selectedProblems.add(allTypes[element]);
    });
    Get.back(result: selectedProblems);
  }
}
