import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/withdraw_method_model.dart';

WithdrawMethodModel $WithdrawMethodModelFromJson(Map<String, dynamic> json) {
  final WithdrawMethodModel withdrawMethodModel = WithdrawMethodModel();
  final String? isDefault = jsonConvert.convert<String>(json['is_default']);
  if (isDefault != null) {
    withdrawMethodModel.isDefault = isDefault;
  }
  final String? waId = jsonConvert.convert<String>(json['wa_id']);
  if (waId != null) {
    withdrawMethodModel.waId = waId;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    withdrawMethodModel.id = id;
  }
  final String? accountNumber = jsonConvert.convert<String>(json['account_number']);
  if (accountNumber != null) {
    withdrawMethodModel.accountNumber = accountNumber;
  }
  final String? bankNumber = jsonConvert.convert<String>(json['bank_number']);
  if (bankNumber != null) {
    withdrawMethodModel.bankNumber = bankNumber;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    withdrawMethodModel.title = title;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    withdrawMethodModel.name = name;
  }
  return withdrawMethodModel;
}

Map<String, dynamic> $WithdrawMethodModelToJson(WithdrawMethodModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['is_default'] = entity.isDefault;
  data['wa_id'] = entity.waId;
  data['id'] = entity.id;
  data['account_number'] = entity.accountNumber;
  data['bank_number'] = entity.bankNumber;
  data['title'] = entity.title;
  data['name'] = entity.name;
  return data;
}

extension WithdrawMethodModelExtension on WithdrawMethodModel {
  WithdrawMethodModel copyWith({
    String? isDefault,
    String? waId,
    String? id,
    String? accountNumber,
    String? bankNumber,
    String? title,
    String? name,
  }) {
    return WithdrawMethodModel()
      ..isDefault = isDefault ?? this.isDefault
      ..waId = waId ?? this.waId
      ..id = id ?? this.id
      ..accountNumber = accountNumber ?? this.accountNumber
      ..bankNumber = bankNumber ?? this.bankNumber
      ..title = title ?? this.title
      ..name = name ?? this.name;
  }
}

EWalletCategory $EWalletCategoryFromJson(Map<String, dynamic> json) {
  final EWalletCategory eWalletCategory = EWalletCategory();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    eWalletCategory.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    eWalletCategory.title = title;
  }
  return eWalletCategory;
}

Map<String, dynamic> $EWalletCategoryToJson(EWalletCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension EWalletCategoryExtension on EWalletCategory {
  EWalletCategory copyWith({
    String? id,
    String? title,
  }) {
    return EWalletCategory()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

BankCardCategory $BankCardCategoryFromJson(Map<String, dynamic> json) {
  final BankCardCategory bankCardCategory = BankCardCategory();
  final String? bankid = jsonConvert.convert<String>(json['bankid']);
  if (bankid != null) {
    bankCardCategory.bankid = bankid;
  }
  final String? bankname = jsonConvert.convert<String>(json['bankname']);
  if (bankname != null) {
    bankCardCategory.bankname = bankname;
  }
  final String? longname = jsonConvert.convert<String>(json['longname']);
  if (longname != null) {
    bankCardCategory.longname = longname;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    bankCardCategory.status = status;
  }
  return bankCardCategory;
}

Map<String, dynamic> $BankCardCategoryToJson(BankCardCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['bankid'] = entity.bankid;
  data['bankname'] = entity.bankname;
  data['longname'] = entity.longname;
  data['status'] = entity.status;
  return data;
}

extension BankCardCategoryExtension on BankCardCategory {
  BankCardCategory copyWith({
    String? bankid,
    String? bankname,
    String? longname,
    String? status,
  }) {
    return BankCardCategory()
      ..bankid = bankid ?? this.bankid
      ..bankname = bankname ?? this.bankname
      ..longname = longname ?? this.longname
      ..status = status ?? this.status;
  }
}

CardBindingData $CardBindingDataFromJson(Map<String, dynamic> json) {
  final CardBindingData cardBindingData = CardBindingData();
  final String? nameOne = jsonConvert.convert<String>(json['name_one']);
  if (nameOne != null) {
    cardBindingData.nameOne = nameOne;
  }
  final String? nameTwo = jsonConvert.convert<String>(json['name_two']);
  if (nameTwo != null) {
    cardBindingData.nameTwo = nameTwo;
  }
  final String? nameThree = jsonConvert.convert<String>(json['name_three']);
  if (nameThree != null) {
    cardBindingData.nameThree = nameThree;
  }
  return cardBindingData;
}

Map<String, dynamic> $CardBindingDataToJson(CardBindingData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name_one'] = entity.nameOne;
  data['name_two'] = entity.nameTwo;
  data['name_three'] = entity.nameThree;
  return data;
}

extension CardBindingDataExtension on CardBindingData {
  CardBindingData copyWith({
    String? nameOne,
    String? nameTwo,
    String? nameThree,
  }) {
    return CardBindingData()
      ..nameOne = nameOne ?? this.nameOne
      ..nameTwo = nameTwo ?? this.nameTwo
      ..nameThree = nameThree ?? this.nameThree;
  }
}