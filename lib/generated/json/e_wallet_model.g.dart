import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/e_wallet_model.dart';

EWalletModel $EWalletModelFromJson(Map<String, dynamic> json) {
  final EWalletModel eWalletModel = EWalletModel();
  final String? isDefault = jsonConvert.convert<String>(json['is_default']);
  if (isDefault != null) {
    eWalletModel.isDefault = isDefault;
  }
  final String? waId = jsonConvert.convert<String>(json['wa_id']);
  if (waId != null) {
    eWalletModel.waId = waId;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    eWalletModel.id = id;
  }
  final String? accountNumber = jsonConvert.convert<String>(json['account_number']);
  if (accountNumber != null) {
    eWalletModel.accountNumber = accountNumber;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    eWalletModel.title = title;
  }
  return eWalletModel;
}

Map<String, dynamic> $EWalletModelToJson(EWalletModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['is_default'] = entity.isDefault;
  data['wa_id'] = entity.waId;
  data['id'] = entity.id;
  data['account_number'] = entity.accountNumber;
  data['title'] = entity.title;
  return data;
}

extension EWalletModelExtension on EWalletModel {
  EWalletModel copyWith({
    String? isDefault,
    String? waId,
    String? id,
    String? accountNumber,
    String? title,
  }) {
    return EWalletModel()
      ..isDefault = isDefault ?? this.isDefault
      ..waId = waId ?? this.waId
      ..id = id ?? this.id
      ..accountNumber = accountNumber ?? this.accountNumber
      ..title = title ?? this.title;
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