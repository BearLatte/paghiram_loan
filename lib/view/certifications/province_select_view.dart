import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/province_select_controller.dart';
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/util/hex_color.dart';
import 'package:paghiram_loan/view/certifications/city_selection_item.dart';

class ProvinceSelectView extends StatelessWidget {
  ProvinceSelectView({super.key});

  final controller = Get.find<ProvinceSelectController>();

  @override
  Widget build(BuildContext context) {
    CityModel? _lastCity;
    return CommonView(
        title: 'Select address',
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CitySelectionItem.generateItem('Select Province', textColor: '#FF757F8C'),
          Expanded(
              child: SafeArea(
                  child: SingleChildScrollView(
                      child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            ...List.generate(controller.province.value.length, (index) {
                              CityModel city = controller.province.value[index];
                              if (city.prefix == _lastCity?.prefix) {
                                return CitySelectionItem.generateItem(city.name, onPressed: () => controller.selectedItem(city));
                              } else {
                                _lastCity = city;
                                return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                  CitySelectionItem.generateSectionBar(city.prefix),
                                  CitySelectionItem.generateItem(city.name, onPressed: () => controller.selectedItem(city))
                                ]);
                              }
                            })
                          ])))))
        ]));
  }
}
