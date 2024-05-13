import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/contact_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/contact_entity.g.dart';

@JsonSerializable()
class ContactEntity {
	late String name;
	late String phone;
	late String relation;

	ContactEntity();

	factory ContactEntity.fromJson(Map<String, dynamic> json) => $ContactEntityFromJson(json);

	Map<String, dynamic> toJson() => $ContactEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}