import 'package:intl/intl.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/util/global.dart';
import 'dart:convert';

import '../generated/json/repayment_detail_model.g.dart';

@JsonSerializable()
class RepaymentDetailModel {
  @JSONField(name: "payment_id")
  late int paymentId;
  late String oid;
  @JSONField(name: "ad_id")
  late String adId;
  @JSONField(name: "repay_time")
  late int repayTime;
  @JSONField(name: "use_days")
  late String useDays;
  late String money;
  @JSONField(name: "final_amount")
  late int finalAmount;
  @JSONField(name: "current_amount")
  late int currentAmount;
  @JSONField(name: "repaid_amount")
  late int repaidAmount;
  @JSONField(name: "ins_amount")
  dynamic insAmount;
  late int interest;
  @JSONField(name: "all_interest")
  late int allInterest;
  @JSONField(name: "overtime_day")
  late int overtimeDay;
  @JSONField(name: "overtime_price")
  late int overtimePrice;
  @JSONField(name: "is_ins_repay")
  late int isInsRepay;
  @JSONField(name: "is_instalment")
  late int isInstalment;
  @JSONField(name: "is_normal_instalment")
  late int isNormalInstalment;
  @JSONField(name: "pay_data")
  RepaymentDetailModelPayData? payData;

  String get formattedBackTime {
    return DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(repayTime * 1000));
  }

  RepaymentDetailModel();

  factory RepaymentDetailModel.fromJson(Map<String, dynamic> json) => $RepaymentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentDetailModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class RepaymentDetailModelPayData {
  @JSONField(name: "back_time")
  late int backTime;
  late String id;
  late String interest;
  late String money;
  late String principal;
  bool canClick = false;
  bool isChecked = false;

  bool get isOvertime {
    double nowTimestamp = DateTime.now().millisecondsSinceEpoch / 1000;
    return nowTimestamp - backTime > 0;
  }

  int get overtimeDays {
    double nowTimestamp = DateTime.now().millisecondsSinceEpoch / 1000;
    double overtime = (nowTimestamp - backTime).toDouble() / (24 * 60 * 60);
    return overtime.ceil();
  }

  String get formattedBackTime {
    return DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(backTime * 1000));
  }

  String get formattedMoney {
    return 'PHP ${Global.formatCurrency(int.parse(money))}';
  }

  RepaymentDetailModelPayData();

  factory RepaymentDetailModelPayData.fromJson(Map<String, dynamic> json) => $RepaymentDetailModelPayDataFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentDetailModelPayDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
