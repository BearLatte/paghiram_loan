import 'package:get/get.dart';
import 'package:paghiram_loan/models/repayment_method_model.dart';
import 'package:paghiram_loan/router/application_pages.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/service/index.dart';

class PayCoolsMethodController extends GetxController {
  var repaymentAmount = ''.obs;
  var methodList = <RepaymentMethodModel>[
    RepaymentMethodModel(
      id: 0,
      img: 'asset/icons/qr_icon.png',
      title: 'QR Code',
      isChecked: false,
      isRecommended: false,
      titleColor: '#FFFEB099',
    ),
    RepaymentMethodModel(
      id: 1,
      img: 'asset/icons/gcash_icon.png',
      title: 'GCash',
      isChecked: true,
      isRecommended: true,
    ),
    RepaymentMethodModel(
      id: 2,
      img: 'asset/icons/paymaya_icon.png',
      title: 'PayMaya',
      isChecked: false,
      isRecommended: false,
    ),
    RepaymentMethodModel(
      id: 3,
      img: 'asset/icons/711_icon.png',
      title: '7-11',
      isChecked: false,
      isRecommended: false,
    ),
    RepaymentMethodModel(
      id: 4,
      img: 'asset/icons/mlhuillier_icon.png',
      title: 'M Lhuillier',
      isChecked: false,
      isRecommended: false,
    ),
    RepaymentMethodModel(
      id: 5,
      img: 'asset/icons/rd_icon.png',
      title: 'RD',
      isChecked: false,
      isRecommended: false,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    repaymentAmount.value = Get.arguments['repaymentAmount'];
    _apdId = Get.arguments['gid'];
    _repaymentType = Get.arguments['type'];
  }

  void itemSelected(RepaymentMethodModel item) async {
    methodList.forEach((method) {
      if (method == item) {
        method.isChecked = true;
      } else {
        method.isChecked = false;
      }
    });

    methodList.refresh();

    late String channelId;
    switch (item.id) {
      case 0:
        String? url = await NetworkService.generateQRCode(apdId: _apdId, type: _repaymentType);
        if (url == null) return;
        Get.toNamed(ApplicationRoutes.webView, arguments: {'title': item.title, 'url': url});
        return;
      case 1:
        channelId = 'PAYMAYA_STATIC_VA';
      case 2:
        channelId = 'GCASH_STATIC_VA';
      case 3:
        channelId = '7ELEVEN_STATIC_VA';
      case 4:
        channelId = 'MLH_STATIC_VA';
      case 5:
        channelId = 'RDP_STATIC_VA';
    }

    String? url = await NetworkService.generatePayCoolsChannelUrl(apdId: _apdId, type: _repaymentType, channelCode: channelId);
    if (url == null) return;
    Get.toNamed(ApplicationRoutes.webView, arguments: {'title': item.title, 'url': url});
  }

  late String _apdId;
  late String _repaymentType;
}
