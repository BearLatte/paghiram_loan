import 'package:paghiram_loan/generated/json/base/json_field.dart';
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

  RepaymentDetailModel();

  factory RepaymentDetailModel.fromJson(Map<String, dynamic> json) => $RepaymentDetailModelFromJson(json);

  Map<String, dynamic> toJson() => $RepaymentDetailModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
