import 'package:intl/intl.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/borrow_rate_model.g.dart';

@JsonSerializable()
class BorrowRateModel {
  @JSONField(name: "min_days")
  late String minDays;
  @JSONField(name: "max_days")
  late String maxDays;
  late int time;
  @JSONField(name: "max_price")
  late String maxPrice;
  @JSONField(name: "user_data")
  late List<BorrowRateModelUserData> userData;

  String get maxPriceFormat {
    return NumberFormat('0,000').format(int.parse(maxPrice));
  }

  BorrowRateModel();

  factory BorrowRateModel.fromJson(Map<String, dynamic> json) => $BorrowRateModelFromJson(json);

  Map<String, dynamic> toJson() => $BorrowRateModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowRateModelUserData {
  @JSONField(name: "term_id")
  late String termId;
  late String days;
  @JSONField(name: "show_days")
  late int showDays;
  late BorrowRateModelUserDataInfo info;

  BorrowRateModelUserData();

  factory BorrowRateModelUserData.fromJson(Map<String, dynamic> json) => $BorrowRateModelUserDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowRateModelUserDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowRateModelUserDataInfo {
  @JSONField(name: "pro_id")
  late String proId;
  @JSONField(name: "pro_type")
  late String proType;
  @JSONField(name: "instalment_num")
  late int instalmentNum;
  late String min;
  late String max;
  late int money;
  late List<BorrowRateModelUserDataInfoData> data;

  BorrowRateModelUserDataInfo();

  factory BorrowRateModelUserDataInfo.fromJson(Map<String, dynamic> json) => $BorrowRateModelUserDataInfoFromJson(json);

  Map<String, dynamic> toJson() => $BorrowRateModelUserDataInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowRateModelUserDataInfoData {
  late String rid;
  late int amount;
  @JSONField(name: "service_fee")
  late int serviceFee;
  @JSONField(name: "credit_price")
  late int creditPrice;
  @JSONField(name: "manage_price")
  late int managePrice;
  late int interest;
  @JSONField(name: "tech_price")
  late int techPrice;
  @JSONField(name: "real_price")
  late int realPrice;
  @JSONField(name: "repay_price")
  late int repayPrice;

  BorrowRateModelUserDataInfoData();

  factory BorrowRateModelUserDataInfoData.fromJson(Map<String, dynamic> json) => $BorrowRateModelUserDataInfoDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowRateModelUserDataInfoDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
