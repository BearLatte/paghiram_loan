import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/certification/district_select_controller.dart';
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/view/certifications/city_selection_item.dart';

class DistrictSelectView extends StatelessWidget {
  DistrictSelectView({super.key});

  final controller = Get.find<DistrictSelectController>();

  @override
  Widget build(BuildContext context) {
    CityModel? _lastDistrict;
    return CommonView(
        title: 'Select address',
        child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              CitySelectionItem.generateItem(controller.selectedProvince.value),
              CitySelectionItem.generateItem(controller.selectedCity.value),
              CitySelectionItem.generateItem('Select Barangay', textColor: '#FF757F8C'),
              Expanded(
                  child: SingleChildScrollView(
                      child: SafeArea(
                          child: Column(children: [
                ...List.generate(controller.districts.value.length, (index) {
                  CityModel district = controller.districts.value[index];
                  if (district.prefix == _lastDistrict?.prefix) {
                    return CitySelectionItem.generateItem(district.name, onPressed: () => controller.selectedDistrict(district));
                  } else {
                    _lastDistrict = district;
                    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      CitySelectionItem.generateSectionBar(district.prefix),
                      CitySelectionItem.generateItem(district.name, onPressed: () => controller.selectedDistrict(district))
                    ]);
                  }
                })
              ]))))
            ])));
  }
}
