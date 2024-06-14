import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/bank_card_model.dart';

BankCardModel $BankCardModelFromJson(Map<String, dynamic> json) {
  final BankCardModel bankCardModel = BankCardModel();
  final String? isDefault = jsonConvert.convert<String>(json['is_default']);
  if (isDefault != null) {
    bankCardModel.isDefault = isDefault;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    bankCardModel.name = name;
  }
  final String? bankNumber = jsonConvert.convert<String>(json['bank_number']);
  if (bankNumber != null) {
    bankCardModel.bankNumber = bankNumber;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    bankCardModel.id = id;
  }
  return bankCardModel;
}

Map<String, dynamic> $BankCardModelToJson(BankCardModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['is_default'] = entity.isDefault;
  data['name'] = entity.name;
  data['bank_number'] = entity.bankNumber;
  data['id'] = entity.id;
  return data;
}

extension BankCardModelExtension on BankCardModel {
  BankCardModel copyWith({
    String? isDefault,
    String? name,
    String? bankNumber,
    String? id,
  }) {
    return BankCardModel()
      ..isDefault = isDefault ?? this.isDefault
      ..name = name ?? this.name
      ..bankNumber = bankNumber ?? this.bankNumber
      ..id = id ?? this.id;
  }
}