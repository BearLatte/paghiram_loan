import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/repayment_detail_model.dart';
import 'package:intl/intl.dart';

import 'package:paghiram_loan/util/global.dart';


RepaymentDetailModel $RepaymentDetailModelFromJson(Map<String, dynamic> json) {
  final RepaymentDetailModel repaymentDetailModel = RepaymentDetailModel();
  final int? paymentId = jsonConvert.convert<int>(json['payment_id']);
  if (paymentId != null) {
    repaymentDetailModel.paymentId = paymentId;
  }
  final String? oid = jsonConvert.convert<String>(json['oid']);
  if (oid != null) {
    repaymentDetailModel.oid = oid;
  }
  final String? adId = jsonConvert.convert<String>(json['ad_id']);
  if (adId != null) {
    repaymentDetailModel.adId = adId;
  }
  final int? repayTime = jsonConvert.convert<int>(json['repay_time']);
  if (repayTime != null) {
    repaymentDetailModel.repayTime = repayTime;
  }
  final String? useDays = jsonConvert.convert<String>(json['use_days']);
  if (useDays != null) {
    repaymentDetailModel.useDays = useDays;
  }
  final String? money = jsonConvert.convert<String>(json['money']);
  if (money != null) {
    repaymentDetailModel.money = money;
  }
  final int? finalAmount = jsonConvert.convert<int>(json['final_amount']);
  if (finalAmount != null) {
    repaymentDetailModel.finalAmount = finalAmount;
  }
  final int? currentAmount = jsonConvert.convert<int>(json['current_amount']);
  if (currentAmount != null) {
    repaymentDetailModel.currentAmount = currentAmount;
  }
  final int? repaidAmount = jsonConvert.convert<int>(json['repaid_amount']);
  if (repaidAmount != null) {
    repaymentDetailModel.repaidAmount = repaidAmount;
  }
  final dynamic insAmount = json['ins_amount'];
  if (insAmount != null) {
    repaymentDetailModel.insAmount = insAmount;
  }
  final int? interest = jsonConvert.convert<int>(json['interest']);
  if (interest != null) {
    repaymentDetailModel.interest = interest;
  }
  final int? allInterest = jsonConvert.convert<int>(json['all_interest']);
  if (allInterest != null) {
    repaymentDetailModel.allInterest = allInterest;
  }
  final int? overtimeDay = jsonConvert.convert<int>(json['overtime_day']);
  if (overtimeDay != null) {
    repaymentDetailModel.overtimeDay = overtimeDay;
  }
  final int? overtimePrice = jsonConvert.convert<int>(json['overtime_price']);
  if (overtimePrice != null) {
    repaymentDetailModel.overtimePrice = overtimePrice;
  }
  final int? isInsRepay = jsonConvert.convert<int>(json['is_ins_repay']);
  if (isInsRepay != null) {
    repaymentDetailModel.isInsRepay = isInsRepay;
  }
  final int? isInstalment = jsonConvert.convert<int>(json['is_instalment']);
  if (isInstalment != null) {
    repaymentDetailModel.isInstalment = isInstalment;
  }
  final int? isNormalInstalment = jsonConvert.convert<int>(json['is_normal_instalment']);
  if (isNormalInstalment != null) {
    repaymentDetailModel.isNormalInstalment = isNormalInstalment;
  }
  final RepaymentDetailModelPayData? payData = jsonConvert.convert<RepaymentDetailModelPayData>(json['pay_data']);
  if (payData != null) {
    repaymentDetailModel.payData = payData;
  }
  return repaymentDetailModel;
}

Map<String, dynamic> $RepaymentDetailModelToJson(RepaymentDetailModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['payment_id'] = entity.paymentId;
  data['oid'] = entity.oid;
  data['ad_id'] = entity.adId;
  data['repay_time'] = entity.repayTime;
  data['use_days'] = entity.useDays;
  data['money'] = entity.money;
  data['final_amount'] = entity.finalAmount;
  data['current_amount'] = entity.currentAmount;
  data['repaid_amount'] = entity.repaidAmount;
  data['ins_amount'] = entity.insAmount;
  data['interest'] = entity.interest;
  data['all_interest'] = entity.allInterest;
  data['overtime_day'] = entity.overtimeDay;
  data['overtime_price'] = entity.overtimePrice;
  data['is_ins_repay'] = entity.isInsRepay;
  data['is_instalment'] = entity.isInstalment;
  data['is_normal_instalment'] = entity.isNormalInstalment;
  data['pay_data'] = entity.payData?.toJson();
  return data;
}

extension RepaymentDetailModelExtension on RepaymentDetailModel {
  RepaymentDetailModel copyWith({
    int? paymentId,
    String? oid,
    String? adId,
    int? repayTime,
    String? useDays,
    String? money,
    int? finalAmount,
    int? currentAmount,
    int? repaidAmount,
    dynamic insAmount,
    int? interest,
    int? allInterest,
    int? overtimeDay,
    int? overtimePrice,
    int? isInsRepay,
    int? isInstalment,
    int? isNormalInstalment,
    RepaymentDetailModelPayData? payData,
  }) {
    return RepaymentDetailModel()
      ..paymentId = paymentId ?? this.paymentId
      ..oid = oid ?? this.oid
      ..adId = adId ?? this.adId
      ..repayTime = repayTime ?? this.repayTime
      ..useDays = useDays ?? this.useDays
      ..money = money ?? this.money
      ..finalAmount = finalAmount ?? this.finalAmount
      ..currentAmount = currentAmount ?? this.currentAmount
      ..repaidAmount = repaidAmount ?? this.repaidAmount
      ..insAmount = insAmount ?? this.insAmount
      ..interest = interest ?? this.interest
      ..allInterest = allInterest ?? this.allInterest
      ..overtimeDay = overtimeDay ?? this.overtimeDay
      ..overtimePrice = overtimePrice ?? this.overtimePrice
      ..isInsRepay = isInsRepay ?? this.isInsRepay
      ..isInstalment = isInstalment ?? this.isInstalment
      ..isNormalInstalment = isNormalInstalment ?? this.isNormalInstalment
      ..payData = payData ?? this.payData;
  }
}

RepaymentDetailModelPayData $RepaymentDetailModelPayDataFromJson(Map<String, dynamic> json) {
  final RepaymentDetailModelPayData repaymentDetailModelPayData = RepaymentDetailModelPayData();
  final int? backTime = jsonConvert.convert<int>(json['back_time']);
  if (backTime != null) {
    repaymentDetailModelPayData.backTime = backTime;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    repaymentDetailModelPayData.id = id;
  }
  final String? interest = jsonConvert.convert<String>(json['interest']);
  if (interest != null) {
    repaymentDetailModelPayData.interest = interest;
  }
  final String? money = jsonConvert.convert<String>(json['money']);
  if (money != null) {
    repaymentDetailModelPayData.money = money;
  }
  final String? principal = jsonConvert.convert<String>(json['principal']);
  if (principal != null) {
    repaymentDetailModelPayData.principal = principal;
  }
  final bool? canClick = jsonConvert.convert<bool>(json['canClick']);
  if (canClick != null) {
    repaymentDetailModelPayData.canClick = canClick;
  }
  final bool? isChecked = jsonConvert.convert<bool>(json['isChecked']);
  if (isChecked != null) {
    repaymentDetailModelPayData.isChecked = isChecked;
  }
  return repaymentDetailModelPayData;
}

Map<String, dynamic> $RepaymentDetailModelPayDataToJson(RepaymentDetailModelPayData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['back_time'] = entity.backTime;
  data['id'] = entity.id;
  data['interest'] = entity.interest;
  data['money'] = entity.money;
  data['principal'] = entity.principal;
  data['canClick'] = entity.canClick;
  data['isChecked'] = entity.isChecked;
  return data;
}

extension RepaymentDetailModelPayDataExtension on RepaymentDetailModelPayData {
  RepaymentDetailModelPayData copyWith({
    int? backTime,
    String? id,
    String? interest,
    String? money,
    String? principal,
    bool? canClick,
    bool? isChecked,
  }) {
    return RepaymentDetailModelPayData()
      ..backTime = backTime ?? this.backTime
      ..id = id ?? this.id
      ..interest = interest ?? this.interest
      ..money = money ?? this.money
      ..principal = principal ?? this.principal
      ..canClick = canClick ?? this.canClick
      ..isChecked = isChecked ?? this.isChecked;
  }
}