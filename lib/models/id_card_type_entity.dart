import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/id_card_type_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/id_card_type_entity.g.dart';

@JsonSerializable()
class IdCardTypeEntity {
	late String id;
	late String title;

	IdCardTypeEntity();

	factory IdCardTypeEntity.fromJson(Map<String, dynamic> json) => $IdCardTypeEntityFromJson(json);

	Map<String, dynamic> toJson() => $IdCardTypeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}