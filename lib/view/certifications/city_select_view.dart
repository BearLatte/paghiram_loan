import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/controller/city_select_controller.dart';
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/view/certifications/city_selection_item.dart';

class CitySelectView extends StatelessWidget {
  CitySelectView({super.key});

  final controller = Get.find<CitySelectController>();

  @override
  Widget build(BuildContext context) {
    CityModel? _lastCity;
    return CommonView(
        title: 'Select address',
        child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              CitySelectionItem.generateItem(controller.selectedProvince.value),
              CitySelectionItem.generateItem('Select City', textColor: '#FF757F8C'),
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                      child: Column(
                    children: [
                      ...List.generate(controller.cities.value.length, (index) {
                        var city = controller.cities.value[index];
                        if (city.prefix == _lastCity?.prefix) {
                          return CitySelectionItem.generateItem(city.name, onPressed: () => controller.go2selectDistrict(city));
                        } else {
                          _lastCity = city;
                          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            CitySelectionItem.generateSectionBar(city.prefix),
                            CitySelectionItem.generateItem(city.name, onPressed: () => controller.go2selectDistrict(city)),
                          ]);
                        }
                      })
                    ],
                  )),
                ),
              )
            ])));
  }
}
