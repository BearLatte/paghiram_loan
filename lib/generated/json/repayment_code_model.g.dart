import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/repayment_code_model.dart';

RepaymentCodeModel $RepaymentCodeModelFromJson(Map<String, dynamic> json) {
  final RepaymentCodeModel repaymentCodeModel = RepaymentCodeModel();
  final String? contractNumber = jsonConvert.convert<String>(json['contract_number']);
  if (contractNumber != null) {
    repaymentCodeModel.contractNumber = contractNumber;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    repaymentCodeModel.amount = amount;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    repaymentCodeModel.mobile = mobile;
  }
  final String? goid = jsonConvert.convert<String>(json['goid']);
  if (goid != null) {
    repaymentCodeModel.goid = goid;
  }
  final String? accountName = jsonConvert.convert<String>(json['account_name']);
  if (accountName != null) {
    repaymentCodeModel.accountName = accountName;
  }
  return repaymentCodeModel;
}

Map<String, dynamic> $RepaymentCodeModelToJson(RepaymentCodeModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['contract_number'] = entity.contractNumber;
  data['amount'] = entity.amount;
  data['mobile'] = entity.mobile;
  data['goid'] = entity.goid;
  data['account_name'] = entity.accountName;
  return data;
}

extension RepaymentCodeModelExtension on RepaymentCodeModel {
  RepaymentCodeModel copyWith({
    String? contractNumber,
    int? amount,
    String? mobile,
    String? goid,
    String? accountName,
  }) {
    return RepaymentCodeModel()
      ..contractNumber = contractNumber ?? this.contractNumber
      ..amount = amount ?? this.amount
      ..mobile = mobile ?? this.mobile
      ..goid = goid ?? this.goid
      ..accountName = accountName ?? this.accountName;
  }
}