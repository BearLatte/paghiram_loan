import 'package:intl/intl.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/borrow_detail_model.g.dart';

@JsonSerializable()
class BorrowDetailModel {
  @JSONField(name: "min_days")
  String minDays = '';
  @JSONField(name: "max_days")
  String maxDays = '';
  int time = 0;
  @JSONField(name: "max_price")
  int maxPrice = 0;
  @JSONField(name: "user_data")
  late List<BorrowDetailModelUserData> userData;

  BorrowDetailModel();

  factory BorrowDetailModel.fromJson(Map<String, dynamic> json) => $BorrowDetailModelFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  String get maxPriceFormat {
    var format = NumberFormat('0,000');
    return 'PHP ${format.format(maxPrice)}';
  }
}

@JsonSerializable()
class BorrowDetailModelUserData {
  @JSONField(name: "term_id")
  late String termId;
  late String days;
  @JSONField(name: "show_days")
  late int showDays;
  late BorrowDetailModelUserDataInfo info;

  BorrowDetailModelUserData();

  factory BorrowDetailModelUserData.fromJson(Map<String, dynamic> json) => $BorrowDetailModelUserDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailModelUserDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailModelUserDataInfo {
  @JSONField(name: "pro_id")
  late String proId;
  @JSONField(name: "pro_type")
  late String proType;
  @JSONField(name: "instalment_num")
  late int instalmentNum;
  late String min;
  late String max;
  late String money;
  late List<BorrowDetailModelUserDataInfoData> data;

  BorrowDetailModelUserDataInfo();

  factory BorrowDetailModelUserDataInfo.fromJson(Map<String, dynamic> json) => $BorrowDetailModelUserDataInfoFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailModelUserDataInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailModelUserDataInfoData {
  late String rid;
  late String amount;
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

  BorrowDetailModelUserDataInfoData();

  factory BorrowDetailModelUserDataInfoData.fromJson(Map<String, dynamic> json) => $BorrowDetailModelUserDataInfoDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailModelUserDataInfoDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
