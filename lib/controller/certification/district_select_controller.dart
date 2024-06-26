import 'package:get/get.dart';
import 'package:paghiram_loan/controller/certification/basic_info_controller.dart';
import 'package:paghiram_loan/controller/certification/personal_info_controller.dart';
import 'package:paghiram_loan/models/city_model.dart';
import 'package:paghiram_loan/router/application_routes.dart';

class DistrictSelectController extends GetxController {
  var selectedProvince = ''.obs;
  var selectedCity = ''.obs;
  var districts = [].obs;
  late String type;

  @override
  void onReady() {
    super.onReady();
    _configArguments();
  }

  void _configArguments() {
    selectedProvince.value = Get.arguments['selectedProvince'];
    selectedCity.value = Get.arguments['selectedCity'];
    Map<String, dynamic> data = Get.arguments['districts'];
    type = Get.arguments['type'];
    var tempDistricts = [];
    data.forEach((key, value) {
      tempDistricts.add(CityModel(prefix: key.substring(0, 1), name: key, cities: value));
    });
    tempDistricts.sort((a, b) => a.prefix.compareTo(b.prefix));
    districts.value = tempDistricts;
  }

  void selectedDistrict(CityModel city) {
    if (type == 'basic') {
      final controller = Get.find<BasicInfoController>();
      controller.companyProvince.value = selectedProvince.value;
      controller.companyCity.value = selectedCity.value;
      controller.companyDistrict.value = city.name;
      Get.until((route) => route.settings.name == ApplicationRoutes.basicInfo);
    } else {
      final controller = Get.find<PersonalInfoController>();
      controller.residenceProvince.value = selectedProvince.value;
      controller.residenceCity.value = selectedCity.value;
      controller.residenceDistrict.value = city.name;
      Get.until((route) => route.settings.name == ApplicationRoutes.personalInfo);
    }
  }
}
