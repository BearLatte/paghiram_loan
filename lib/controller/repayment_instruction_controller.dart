import 'package:get/get.dart';


class RepaymentInstructionController extends GetxController {
  var imgPath = ''.obs;
  var title = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    title.value = Get.arguments['title'];
    imgPath.value = Get.arguments['imgPath'];
  }
}
