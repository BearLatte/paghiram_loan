import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/bank_card_model.g.dart';

@JsonSerializable()
class BankCardModel {
	@JSONField(name: "is_default")
	late String isDefault;
	late String name;
	@JSONField(name: "bank_number")
	late String bankNumber;
	late String id;
	
	String get formattedBankNumber {
		return '****${bankNumber.substring(bankNumber.length - 4)}';
	}

	BankCardModel();

	factory BankCardModel.fromJson(Map<String, dynamic> json) => $BankCardModelFromJson(json);

	Map<String, dynamic> toJson() => $BankCardModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}