import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/borrow_detail_model.g.dart';

@JsonSerializable()
class BorrowDetailModel {
	@JSONField(name: "loan_amount")
	late int loanAmount;
	@JSONField(name: "loan_term")
	late int loanTerm;
	@JSONField(name: "issued_amount")
	late int issuedAmount;
	@JSONField(name: "service_fee")
	late int serviceFee;
	@JSONField(name: "credit_price")
	late int creditPrice;
	@JSONField(name: "manage_price")
	late int managePrice;
	@JSONField(name: "tech_price")
	late int techPrice;
	@JSONField(name: "repay_data")
	late List<BorrowDetailModelRepayData> repayData;

	BorrowDetailModel();

	factory BorrowDetailModel.fromJson(Map<String, dynamic> json) => $BorrowDetailModelFromJson(json);

	Map<String, dynamic> toJson() => $BorrowDetailModelToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BorrowDetailModelRepayData {
	@JSONField(name: "back_time")
	late String backTime;
	late int principal;
	@JSONField(name: "repay_price")
	late int repayPrice;
	late int interest;

	BorrowDetailModelRepayData();

	factory BorrowDetailModelRepayData.fromJson(Map<String, dynamic> json) => $BorrowDetailModelRepayDataFromJson(json);

	Map<String, dynamic> toJson() => $BorrowDetailModelRepayDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}