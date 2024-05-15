import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';

class ProvinceSelectController extends GetxController {
  var province = [].obs;
  late String type;
  @override
  void onReady() async {
    super.onReady();
    _loadData();
    type = Get.arguments;
  }

  void _loadData() async {
    String data = await rootBundle.loadString('asset/data/company_address.json');
    Map<String, dynamic> json = jsonDecode(data);
    var tempProvince = [];
    json.forEach((key, cities) {
      tempProvince.add(CityModel(prefix: key.substring(0, 1), name: key, cities: cities));
    });

    tempProvince.sort((a, b) => a.prefix.compareTo(b.prefix));
    province.value = tempProvince;
  }

  void selectedItem(CityModel item) {
    Get.toNamed(ApplicationRoutes.cityListPage, arguments: {'selectedProvince': item.name, 'cities': item.cities, 'type': type});
  }
}
