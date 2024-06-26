import 'package:get/get.dart';
import 'package:paghiram_loan/controller/borrow/add_bank_card_controller.dart';
import 'package:paghiram_loan/controller/borrow/add_e_wallet_controller.dart';
import 'package:paghiram_loan/controller/add_note_controller.dart';
import 'package:paghiram_loan/controller/repayment/bar_code_view_controller.dart';
import 'package:paghiram_loan/controller/borrow/borrow_detail_controller.dart';
import 'package:paghiram_loan/controller/certification/card_ocr_controller.dart';
import 'package:paghiram_loan/controller/certification/certification_index_controller.dart';
import 'package:paghiram_loan/controller/change_password_controller.dart';
import 'package:paghiram_loan/controller/certification/city_select_controller.dart';
import 'package:paghiram_loan/controller/certification/contact_controller.dart';
import 'package:paghiram_loan/controller/delete_account_controller.dart';
import 'package:paghiram_loan/controller/device_check_dialog_controller.dart';
import 'package:paghiram_loan/controller/certification/district_select_controller.dart';
import 'package:paghiram_loan/controller/feedback_controller.dart';
import 'package:paghiram_loan/controller/feedback_type_select_controller.dart';
import 'package:paghiram_loan/controller/home_view_controller.dart';
import 'package:paghiram_loan/controller/certification/liveness_instructions_controller.dart';
import 'package:paghiram_loan/controller/loan_tab_controller.dart';
import 'package:paghiram_loan/controller/login_controller.dart';
import 'package:paghiram_loan/controller/notes_tab_controller.dart';
import 'package:paghiram_loan/controller/certification/basic_info_controller.dart';
import 'package:paghiram_loan/controller/orders_controller.dart';
import 'package:paghiram_loan/controller/repayment/pay_cools_method_controller.dart';
import 'package:paghiram_loan/controller/certification/personal_info_controller.dart';
import 'package:paghiram_loan/controller/certification/province_select_controller.dart';
import 'package:paghiram_loan/controller/repayment/repayment_index_controller.dart';
import 'package:paghiram_loan/controller/repayment/sky_pay_method_controller.dart';
import 'package:paghiram_loan/controller/settings_controller.dart';
import 'package:paghiram_loan/controller/web_view_controller.dart';
import 'package:paghiram_loan/controller/borrow/withdraw_confirm_controller.dart';
import 'package:paghiram_loan/view/certifications/card_ocr_view.dart';
import 'package:paghiram_loan/view/certifications/city_select_view.dart';
import 'package:paghiram_loan/view/certifications/contact_view.dart';
import 'package:paghiram_loan/view/certifications/district_select_view.dart';
import 'package:paghiram_loan/view/certifications/index.dart';
import 'package:paghiram_loan/view/certifications/basic_info_view.dart';
import 'package:paghiram_loan/view/certifications/liveness_instructions_view.dart';
import 'package:paghiram_loan/view/certifications/personal_info_view.dart';
import 'package:paghiram_loan/view/certifications/province_select_view.dart';
import 'package:paghiram_loan/view/feedback/feedback_image_enlarge_view.dart';
import 'package:paghiram_loan/view/feedback/feedback_type_select_view.dart';
import 'package:paghiram_loan/view/feedback/feedback_view.dart';
import 'package:paghiram_loan/view/home_view.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/view/loan/borrow/add_bank_card.dart';
import 'package:paghiram_loan/view/loan/borrow/add_e_wallet.dart';
import 'package:paghiram_loan/view/loan/borrow/detail.dart';
import 'package:paghiram_loan/view/loan/borrow/device_check_dialog.dart';
import 'package:paghiram_loan/view/loan/borrow/index.dart';
import 'package:paghiram_loan/view/loan/borrow/withdraw_confirm_view.dart';
import 'package:paghiram_loan/view/loan/borrow/withdraw_method.dart';
import 'package:paghiram_loan/view/loan/borrow/withdraw_success_view.dart';
import 'package:paghiram_loan/view/loan/repayment/bar_code_view.dart';
import 'package:paghiram_loan/view/loan/repayment/index.dart';
import 'package:paghiram_loan/view/loan/repayment/repayment_instruction_view.dart';
import 'package:paghiram_loan/view/loan/repayment/sky_pay_method_view.dart';
import 'package:paghiram_loan/view/loan/repayment/pay_cools_method_view.dart';
import 'package:paghiram_loan/view/login/change_password_view.dart';
import 'package:paghiram_loan/view/login/login_view.dart';
import 'package:paghiram_loan/view/notes/add_node_view.dart';
import 'package:paghiram_loan/view/profile/about_us_view.dart';
import 'package:paghiram_loan/view/profile/delete_account_view.dart';
import 'package:paghiram_loan/view/profile/web_view.dart';
import 'package:paghiram_loan/view/profile/settings_view.dart';

import '../controller/borrow/borrow_index_controller.dart';
import '../controller/borrow/withdraw_method_controller.dart';
import '../controller/borrow/withdraw_success_controller.dart';
import '../controller/repayment/repayment_instruction_controller.dart';

class ApplicationPages {
  static const initial = ApplicationRoutes.home;
  static final routes = [
    GetPage(
      name: ApplicationRoutes.home,
      page: () => HomeView(),
      transition: Transition.noTransition,
      bindings: [
        BindingsBuilder(() => Get.lazyPut(() => HomeViewController())),
        BindingsBuilder(() => Get.lazyPut(() => LoanTabController())),
        BindingsBuilder(() => Get.lazyPut(() => NotesTabController())),
        BindingsBuilder(() => Get.lazyPut(() => OrdersController())),
      ],
    ),
    GetPage(
      name: ApplicationRoutes.settings,
      page: () => SettingsView(),
      transition: Transition.cupertino,
      binding: BindingsBuilder(() => Get.lazyPut(() => SettingsController())),
    ),
    GetPage(name: ApplicationRoutes.aboutUs, page: () => const AboutUsView(), transition: Transition.cupertino),
    GetPage(
        name: ApplicationRoutes.webView,
        page: () => WebView(),
        transition: Transition.cupertinoDialog,
        binding: BindingsBuilder(() => Get.lazyPut(() => InternalWebViewController()))),
    GetPage(name: ApplicationRoutes.addNote, page: () => AddNodeView(), transition: Transition.cupertino, binding: BindingsBuilder(() => Get.lazyPut(() => AddNoteController()))),
    GetPage(
        name: ApplicationRoutes.login,
        popGesture: false,
        page: () => LoginView(),
        transition: Transition.downToUp,
        binding: BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
    GetPage(
        name: ApplicationRoutes.changePwd,
        page: () => ChangePasswordView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => ChangePasswordController()))),
    GetPage(
        name: ApplicationRoutes.certificationIndex,
        page: () => CertificationIndexView(),
        transition: Transition.downToUp,
        popGesture: false,
        binding: BindingsBuilder(() => Get.lazyPut(() => CertificationIndexController()))),
    GetPage(
        name: ApplicationRoutes.basicInfo, page: () => BasicInfoView(), transition: Transition.cupertino, binding: BindingsBuilder(() => Get.lazyPut(() => BasicInfoController()))),
    GetPage(
        name: ApplicationRoutes.provinceListPage,
        page: () => ProvinceSelectView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => ProvinceSelectController()))),
    GetPage(
        name: ApplicationRoutes.cityListPage,
        page: () => CitySelectView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => CitySelectController()))),
    GetPage(
        name: ApplicationRoutes.districtListPage,
        page: () => DistrictSelectView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => DistrictSelectController()))),
    GetPage(
        name: ApplicationRoutes.personalInfo,
        page: () => PersonalInfoView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => PersonalInfoController()))),
    GetPage(name: ApplicationRoutes.contact, page: () => ContactView(), transition: Transition.cupertino, binding: BindingsBuilder(() => Get.lazyPut(() => ContactController()))),
    GetPage(name: ApplicationRoutes.cardOCR, page: () => CardOcrView(), transition: Transition.cupertino, binding: BindingsBuilder(() => Get.lazyPut(() => CardOcrController()))),
    GetPage(
        name: ApplicationRoutes.livenessInstructions,
        page: () => LivenessInstructionsView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => LivenessInstructionsControll()))),
    GetPage(name: ApplicationRoutes.feedback, page: () => FeedbackView(), transition: Transition.downToUp, binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackController()))),
    GetPage(
        name: ApplicationRoutes.deleteAccount,
        page: () => DeleteAccountView(),
        transition: Transition.cupertino,
        binding: BindingsBuilder(() => Get.lazyPut(() => DeleteAccountController()))),
    GetPage(
        name: ApplicationRoutes.feedbackTypePicker,
        page: () => FeedbackTypeSelectView(),
        opaque: false,
        popGesture: false,
        transition: Transition.downToUp,
        binding: BindingsBuilder(() => Get.lazyPut(() => FeedbackTypeSelectController()))),
    GetPage(
      name: ApplicationRoutes.feedbackImageEnlarge,
      page: () => FeedbackImageEnlargeView(),
      opaque: false,
      popGesture: false,
      transition: Transition.size,
    ),
    GetPage(
      name: ApplicationRoutes.borrowIndex,
      page: () => BorrowIndex(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() => Get.lazyPut(() => BorrowIndexController())),
    ),
    GetPage(
      name: ApplicationRoutes.borrowDetail,
      page: () => BorrowDetailView(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() => Get.lazyPut(() => BorrowDetailController())),
    ),
    GetPage(
      name: ApplicationRoutes.withdrawMethod,
      page: () => WithdrawMethod(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => WithdrawMethodController())),
    ),
    GetPage(
      name: ApplicationRoutes.addEWallet,
      page: () => AddEWallet(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => AddEWalletController())),
    ),
    GetPage(
      name: ApplicationRoutes.addBankCard,
      page: () => AddBankCard(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => AddBankCardController())),
    ),
    GetPage(
      name: ApplicationRoutes.withdrawConfirm,
      page: () => WithdrawConfirmView(),
      transition: Transition.fadeIn,
      opaque: false,
      popGesture: false,
      binding: BindingsBuilder(() => Get.lazyPut(() => WithdrawConfirmController())),
    ),
    GetPage(
      name: ApplicationRoutes.withdrawDeviceCheck,
      page: () => DeviceCheckDialog(),
      transition: Transition.fadeIn,
      opaque: false,
      popGesture: false,
      binding: BindingsBuilder(() => Get.lazyPut(() => DeviceCheckDialogController())),
    ),
    GetPage(
      name: ApplicationRoutes.withdrawSuccess,
      page: () => WithdrawSuccessView(),
      transition: Transition.native,
      popGesture: false,
      binding: BindingsBuilder(() => Get.lazyPut(() => WithdrawSuccessController())),
    ),
    GetPage(
      name: ApplicationRoutes.repaymentIndex,
      page: () => RepaymentIndex(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => RepaymentIndexController())),
    ),
    GetPage(
      name: ApplicationRoutes.repaymentMethodSkyPay,
      page: () => SkyPayMethodView(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => SkyPayMethodController())),
    ),
    GetPage(
      name: ApplicationRoutes.repaymentMethodPayCools,
      page: () => PayCoolsMethodView(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => PayCoolsMethodController())),
    ),
    GetPage(
      name: ApplicationRoutes.skyPayBarCode,
      page: () => BarCodeView(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => BarCodeViewController())),
    ),
    GetPage(
      name: ApplicationRoutes.repaymentInstructionView,
      page: () => RepaymentInstructionView(),
      transition: Transition.native,
      binding: BindingsBuilder(() => Get.lazyPut(() => RepaymentInstructionController())),
    ),
  ];
}
