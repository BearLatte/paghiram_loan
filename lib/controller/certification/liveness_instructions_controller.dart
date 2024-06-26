import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/service/index.dart';
import 'package:liveness_plugin/liveness_plugin.dart';

class LivenessInstructionsControll extends GetxController implements  LivenessDetectionCallback {
  void go2doLiveness() async {
    String token = await NetworkService.fetchLivenessToken();
    LivenessPlugin.initSDKOfLicense(Market.Philippines);
    var result = await LivenessPlugin.setLicenseAndCheck(token);
    if(result != 'SUCCESS') return CommonSnackBar.showSnackBar('The liveness license is not valid');
    LivenessPlugin.startLivenessDetection(this);
  }

  @override
  void onGetDetectionResult(bool isSuccess, Map? resultMap) {
    if(isSuccess) {
      Get.back(result: resultMap);
    } else {
      return;
    }
  }
}

