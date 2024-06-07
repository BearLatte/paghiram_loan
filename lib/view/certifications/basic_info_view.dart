import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/basic_info_controller.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/view/certifications/certify_input_item.dart';
import 'package:paghiram_loan/view/certifications/certify_selection_item.dart';
import 'package:paghiram_loan/view/certifications/section_header.dart';
import 'package:paghiram_loan/widget/hide_keyboard_wraper.dart';

import '../../util/hex_color.dart';

class BasicInfoView extends StatelessWidget {
  BasicInfoView({super.key});

  final controller = Get.find<BasicInfoController>();

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWrapper(
        child: CommonView(
            title: 'Basic Information',
            isShowConnectCustomers: true,
            navLeadingAction: controller.backAction,
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SectionHeader('Basic Information'),
                            CertifySelectionItem(
                              'Loan Purpose',
                              key: GlobalObjectKey(1),
                              onTap: controller.go2selectUsageOfLoan,
                              selectedContent: controller.usage.value,
                              isEmpty: controller.isPurposeEmpty.value,
                            ),
                            CertifySelectionItem(
                              key: GlobalObjectKey(2),
                              'Educational Background',
                              selectedContent: controller.edu.value,
                              onTap: controller.go2selectEduBackground,
                              isEmpty: controller.isEduEmpty.value,
                            ),
                            SectionHeader('Work Information'),
                            CertifySelectionItem(
                              key: GlobalObjectKey(3),
                              'Industry Classification',
                              selectedContent: controller.industry.value,
                              onTap: controller.go2selectIndustry,
                              isEmpty: controller.isIndustryEmpty.value,
                            ),
                            if (controller.isShowWorkDetail.value)
                              CertifyInputItem(

                                'Company Name',
                                key: GlobalObjectKey(4),
                                isEmpty: controller.isNameEmpty.value,
                                inputController: controller.companyNameInputController,
                                inputNode: controller.nameNode,
                                onEditingCompleted: controller.companyNameEditingCompleted,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifySelectionItem(
                                'Work Experience',
                                key: GlobalObjectKey(5),
                                selectedContent: controller.experience.value,
                                onTap: controller.go2selectExperience,
                                isEmpty: controller.isExperienceEmpty.value,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifySelectionItem(
                                'Payday 1',
                                key: GlobalObjectKey(6),
                                selectedContent: controller.payday1.value,
                                onTap: controller.go2selectPaydayOne,
                                isEmpty: controller.isPayday1Empty.value,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifySelectionItem(
                                'Payday 2',
                                key: GlobalObjectKey(7),
                                selectedContent: controller.payday2.value,
                                onTap: controller.go2selectPaydayTwo,
                                isEmpty: controller.isPayday2Empty.value,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifySelectionItem(
                                'Monthly Income',
                                key: GlobalObjectKey(8),
                                selectedContent: controller.salary.value,
                                onTap: controller.go2selectIncome,
                                isEmpty: controller.isSalaryEmpty.value,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifySelectionItem(
                                'Company Address',
                                key: GlobalObjectKey(9),
                                selectedContent: '${controller.companyProvince.value} ${controller.companyCity.value} ${controller.companyDistrict.value}',
                                onTap: controller.go2selectAddressInfo,
                                isEmpty: controller.isCompanyAddressEmpty.value,
                              ),
                            if (controller.isShowWorkDetail.value)
                              CertifyInputItem(
                                'Complete Address',
                                key: GlobalObjectKey(10),
                                isEmpty: controller.isDetailAddressEmpty.value,
                                inputController: controller.addressInputController,
                                inputNode: controller.addressNode,
                                onEditingCompleted: controller.detailAddressEditingCompleted,
                              ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 34),
                                child: Container(
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: controller.submitBasicInfo,
                                    child: Text('Continue'),
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Constant.themeColor, textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
