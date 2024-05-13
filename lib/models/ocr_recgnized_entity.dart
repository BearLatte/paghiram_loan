import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/ocr_recgnized_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/ocr_recgnized_entity.g.dart';

@JsonSerializable()
class OcrRecgnizedEntity {
	@JSONField(name: "last_name")
	late String lastName;
	@JSONField(name: "first_name")
	late String firstName;
	@JSONField(name: "middle_name")
	late String middleName;
	@JSONField(name: "id_card")
	late String idCard;
	late String gender;
	late String birthday;

	String get idCardNumber {
		return idCard.replaceAllMapped(RegExp('[\\*\\-\\?\\^\`\\@\\~\\#\\%\\&\\+\\=]'), (match) => '');
	}

	String get replacedFirstName {
		return firstName.replaceAllMapped(RegExp('[\\*\\-\\?\\^\`\\@\\~\\#\\%\\&\\+\\=]'), (match) => '');
	}

	String get replacedLastName {
		return lastName.replaceAllMapped(RegExp('[\\*\\-\\?\\^\`\\@\\~\\#\\%\\&\\+\\=]'), (match) => '');
	}

	String get replacedMiddleName {
		return middleName.replaceAllMapped(RegExp('[\\*\\-\\?\\^\`\\@\\~\\#\\%\\&\\+\\=]'), (match) => '');
	}

	OcrRecgnizedEntity();

	factory OcrRecgnizedEntity.fromJson(Map<String, dynamic> json) => $OcrRecgnizedEntityFromJson(json);

	Map<String, dynamic> toJson() => $OcrRecgnizedEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}