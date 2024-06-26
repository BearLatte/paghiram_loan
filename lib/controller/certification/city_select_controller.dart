import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';

class CitySelectController extends GetxController {
  var selectedProvince = ''.obs;
  var cities = [].obs;
  late String type;

  @override
  void onReady() {
    super.onReady();
    _configArguments();
  }

  void _configArguments() {
    Map<String, dynamic> arguments = Get.arguments;
    selectedProvince.value = arguments['selectedProvince'];
    Map<String, dynamic> data = arguments['cities'];
    type = arguments['type'];
    var tempCities = [];
    data.forEach((key, value) {
      tempCities.add(CityModel(prefix: key.substring(0, 1), name: key, cities: value));
    });
    tempCities.sort((a, b) => a.prefix.compareTo(b.prefix));
    cities.value = tempCities;
  }

  void go2selectDistrict(CityModel city) {
    Get.toNamed(ApplicationRoutes.districtListPage, arguments: {'selectedProvince': selectedProvince.value, 'selectedCity': city.name, 'districts': city.cities, 'type': type});
  }
}
