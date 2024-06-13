import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/e_wallet_model.g.dart';

@JsonSerializable()
class EWalletModel {
  @JSONField(name: "is_default")
  late String isDefault;
  @JSONField(name: "wa_id")
  late String waId;
  late String id;
  @JSONField(name: "account_number")
  late String accountNumber;
  late String title;

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

  EWalletModel();

  factory EWalletModel.fromJson(Map<String, dynamic> json) => $EWalletModelFromJson(json);

  Map<String, dynamic> toJson() => $EWalletModelToJson(this);

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