import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

class CityModel {
	final String prefix;
	final String name;
	final Map<String, dynamic> cities;

	const CityModel({required this.prefix, required this.name, required this.cities});
}