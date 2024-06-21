import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/repayment_code_model.g.dart';

@JsonSerializable()
class RepaymentCodeModel {
  @JSONField(name: "contract_number")
  late String contractNumber;
  late int amount;
  late String mobile;
  late String goid;
  @JSONField(name: "account_name")
  late String accountName;

  RepaymentCodeModel();

  factory RepaymentCodeModel.fromJson(Map<String, dynamic> json) => $RepaymentCodeModelFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentCodeModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
