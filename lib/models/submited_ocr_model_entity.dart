import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/submited_ocr_model_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/submited_ocr_model_entity.g.dart';

@JsonSerializable()
class SubmitedOcrModelEntity {
	late String birthday;
	late String gender;
	@JSONField(name: "id_number")
	late String idNumber;
	late String type;
	dynamic other;
	@JSONField(name: "first_name")
	late String firstName;
	@JSONField(name: "middle_name")
	late String middleName;
	@JSONField(name: "last_name")
	late String lastName;

	SubmitedOcrModelEntity();

	factory SubmitedOcrModelEntity.fromJson(Map<String, dynamic> json) => $SubmitedOcrModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $SubmitedOcrModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}