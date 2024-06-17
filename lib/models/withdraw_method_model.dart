import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/withdraw_method_model.g.dart';

@JsonSerializable()
class WithdrawMethodModel {
  @JSONField(name: "is_default")
  late String isDefault;
  @JSONField(name: "wa_id")
  late String waId;
  late String id;
  @JSONField(name: "account_number")
  late String accountNumber;
  @JSONField(name: "bank_number")
  late String bankNumber;
  late String title;
  late String name;

  String get icon {
    if (title == 'GCash') {
      return 'asset/icons/gcash_icon.png';
    } else if (title == 'Paymaya') {
      return 'asset/icons/paymaya_icon.png';
    } else {
      return 'asset/icons/grab_pay_icon.png';
    }
  }

  String get formattedAccountNumber {
    String prefix = accountNumber.substring(0, 4);
    String suffix = accountNumber.substring(accountNumber.length - 3);
    return '$prefix****$suffix';
  }

  String get formattedNoPrefixNumber {
    return '$title ****${accountNumber.substring(accountNumber.length - 4)}';
  }

  String get formattedBankNumber {
    return '****${bankNumber.substring(bankNumber.length - 4)}';
  }

  WithdrawMethodModel();

  factory WithdrawMethodModel.fromJson(Map<String, dynamic> json) => $WithdrawMethodModelFromJson(json);

  Map<String, dynamic> toJson() => $WithdrawMethodModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class EWalletCategory {
  late String id;
  late String title;

  EWalletCategory();

  factory EWalletCategory.fromJson(Map<String, dynamic> json) => $EWalletCategoryFromJson(json);

  Map<String, dynamic> toJson() => $EWalletCategoryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BankCardCategory {
  late String bankid;
  late String bankname;
  late String longname;
  late String status;

  BankCardCategory();

  factory BankCardCategory.fromJson(Map<String, dynamic> json) => $BankCardCategoryFromJson(json);

  Map<String, dynamic> toJson() => $BankCardCategoryToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CardBindingData {
  @JSONField(name: 'name_one')
  late String nameOne;
  @JSONField(name: 'name_two')
  late String nameTwo;
  @JSONField(name: 'name_three')
  late String nameThree;

  CardBindingData();

  factory CardBindingData.fromJson(Map<String, dynamic> json) => $CardBindingDataFromJson(json);

  Map<String, dynamic> toJson() => $CardBindingDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
