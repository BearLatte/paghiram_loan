import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:paghiram_loan/router/application_routes.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/controller/loan_tab_controller.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/loan/product_status_item.dart';
import 'package:paghiram_loan/widget/marquee_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoanTab extends StatelessWidget {
  LoanTab({super.key});

  final controller = Get.find<LoanTabController>();

  final _banners = ['asset/images/banner01.png', 'asset/images/banner02.png', 'asset/images/banner03.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.themeColor,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton.icon(
              onPressed: null,
              icon: const CommonImage(src: 'asset/icons/logo.png'),
              label: const Text('Paghiram Loan Vip', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(padding: EdgeInsets.zero)),
          IconButton(onPressed: () => _showProfileView(), icon: const CommonImage(src: 'asset/icons/avatar.png'), padding: EdgeInsets.zero)
        ]),
      ),
      body: Container(
          color: HexColor('#FFFAFAFA'),
          child: Column(children: [
            Container(
              color: Constant.themeColor,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 48,
                    decoration: BoxDecoration(color: HexColor('#1FFFFFFF'), borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Obx(
                      () => Row(
                        children: [
                          const CommonImage(src: 'asset/icons/inform.png'),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          if (!controller.marquees.isEmpty) Expanded(child: _buildMarqueeWidget(controller.marquees))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SmartRefresher(
                controller: controller.refreshController,
                onRefresh: controller.fetchData,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() => Column(
                        children: [
                          Container(
                              height: 120,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.hardEdge,
                              child: Swiper(
                                autoplay: true,
                                itemCount: 3,
                                pagination: SwiperPagination(margin: const EdgeInsets.all(0.0), builder: SwiperCustomPagination(builder: _generateIndicator)),
                                itemBuilder: (buildContext, index) => CommonImage(src: _banners[index], fit: BoxFit.cover),
                              )),
                          ...List.generate(
                            controller.products.length,
                            (index) => ProductStatusItem.generateProductItem(
                              controller.products[index],
                              buttonClickedCallback: () => controller.productButtonClickedCallBack(controller.products[index]),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                              _getVerticalLayoutButton(
                                  icon: 'asset/icons/menu_instructions_icon.png', title: 'Loan\ninstructions', onTapCallBack: () => controller.menuClick('instructions')),
                              _getVerticalLayoutButton(icon: 'asset/icons/menu_rate_icon.png', title: 'Rate\ndescription', onTapCallBack: () => controller.menuClick('rate')),
                              _getVerticalLayoutButton(icon: 'asset/icons/menu_help_icon.png', title: 'Help\nCenter', onTapCallBack: () => controller.menuClick('help')),
                            ]),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 34),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              CommonImage(src: 'asset/icons/sec_icon.png'),
                              Expanded(
                                child: Text(
                                  'CASHMOTO LENDING INC.\nCOMPANY REGISTRATION NO. CS201606749\nCERTIFICATE OF AUTHORITY NO. 1829',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: HexColor('#FF757F8C'),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      )),
                ),
              ),
            )
          ])),
    );
  }

  void _showProfileView() async {
    String? phone = 'Login/Register';

    if (Global.isLogin) {
      phone = Global.prefs?.getString(Constant.PHONE_NUMBER_FLAG)!.replaceRange(3, 7, '****');
    }

    await Get.bottomSheet(
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      Container(
        height: 480,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          gradient: LinearGradient(colors: [HexColor('#FFEBF8F9'), HexColor('#FFFFFFFF')], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: phone == 'Login/Register'
                  ? () {
                      Get.back();
                      Get.toNamed(ApplicationRoutes.login);
                    }
                  : null,
              child: Row(
                children: [
                  const CommonImage(src: 'asset/icons/avatar.png', width: 66, height: 66, fit: BoxFit.cover),
                  const SizedBox(width: 16),
                  Text(phone!, style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600))
                ],
              ),
            ),
            const SizedBox(height: 40),
            Wrap(runSpacing: 24, spacing: 10, alignment: WrapAlignment.spaceBetween, children: [
              // _profileMenuItem(icon: 'asset/icons/profile_certification_icon.png', title: 'Certification', onTap: () => controller.go2Certification(null)),
              _profileMenuItem(icon: 'asset/icons/profile_feedback_icon.png', title: 'Feedback', onTap: controller.go2Feedback),
              _profileMenuItem(icon: 'asset/icons/profile_settings_icon.png', title: 'Settings', onTap: controller.go2Settings),
              _profileMenuItem(icon: 'asset/icons/profile_policy_icon.png', title: 'Privacy Policy', onTap: controller.go2Policy)
            ]),
            Container(
                height: 68,
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: ElevatedButton(
                    onPressed: controller.go2CustomerCenter,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(HexColor('#FFEBF8F9')),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16))),
                    child: Row(children: [
                      const CommonImage(src: 'asset/icons/customer_service_icon.png'),
                      const SizedBox(width: 12),
                      Text('Customer Service', style: TextStyle(color: HexColor('#FF102729'), fontSize: 16)),
                      const Spacer(),
                      const CommonImage(src: 'asset/icons/profile_arrow_right.png')
                    ]))),
            SizedBox(
                width: 80,
                height: 32,
                child: ElevatedButton(
                    onPressed: Get.back,
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(HexColor('#FFEBF8F9')), elevation: MaterialStateProperty.all(0)),
                    child: const CommonImage(src: 'asset/icons/profile_double_arrow_icon.png')))
          ],
        ),
      ),
    );
  }

  Widget _profileMenuItem({required String icon, required String title, void Function()? onTap}) {
    return SizedBox(
      width: 105,
      child: InkWell(
          onTap: onTap,
          child: Column(children: [
            CommonImage(src: icon),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontSize: 15, color: HexColor('#FF3B414B'))),
          ])),
    );
  }

  Widget _generateIndicator(BuildContext context, SwiperPluginConfig config) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(height: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            config.itemCount,
            (index) => Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: config.activeIndex == index ? Colors.white : HexColor('#80FFFFFF')))),
      ),
    );
  }

  Widget _getVerticalLayoutButton({required String icon, required String title, void Function()? onTapCallBack}) {
    return InkWell(
      onTap: onTapCallBack,
      child: SizedBox(
        width: 90,
        child: Column(children: [
          CommonImage(src: icon),
          const SizedBox(height: 16),
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
        ]),
      ),
    );
  }

  MarqueeWidget _buildMarqueeWidget(List<String> loopList) {
    return MarqueeWidget(
        count: loopList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(child: Container(alignment: Alignment.centerLeft, child: Text(loopList[index], style: const TextStyle(fontSize: 14, color: Colors.white))));
        });
  }
}
