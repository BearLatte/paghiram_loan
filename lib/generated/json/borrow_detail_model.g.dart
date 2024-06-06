import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';
import 'package:intl/intl.dart';


BorrowDetailModel $BorrowDetailModelFromJson(Map<String, dynamic> json) {
  final BorrowDetailModel borrowDetailModel = BorrowDetailModel();
  final String? minDays = jsonConvert.convert<String>(json['min_days']);
  if (minDays != null) {
    borrowDetailModel.minDays = minDays;
  }
  final String? maxDays = jsonConvert.convert<String>(json['max_days']);
  if (maxDays != null) {
    borrowDetailModel.maxDays = maxDays;
  }
  final int? time = jsonConvert.convert<int>(json['time']);
  if (time != null) {
    borrowDetailModel.time = time;
  }
  final int? maxPrice = jsonConvert.convert<int>(json['max_price']);
  if (maxPrice != null) {
    borrowDetailModel.maxPrice = maxPrice;
  }
  final List<BorrowDetailModelUserData>? userData = (json['user_data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BorrowDetailModelUserData>(e) as BorrowDetailModelUserData).toList();
  if (userData != null) {
    borrowDetailModel.userData = userData;
  }
  return borrowDetailModel;
}

Map<String, dynamic> $BorrowDetailModelToJson(BorrowDetailModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min_days'] = entity.minDays;
  data['max_days'] = entity.maxDays;
  data['time'] = entity.time;
  data['max_price'] = entity.maxPrice;
  data['user_data'] = entity.userData.map((v) => v.toJson()).toList();
  return data;
}

extension BorrowDetailModelExtension on BorrowDetailModel {
  BorrowDetailModel copyWith({
    String? minDays,
    String? maxDays,
    int? time,
    int? maxPrice,
    List<BorrowDetailModelUserData>? userData,
  }) {
    return BorrowDetailModel()
      ..minDays = minDays ?? this.minDays
      ..maxDays = maxDays ?? this.maxDays
      ..time = time ?? this.time
      ..maxPrice = maxPrice ?? this.maxPrice
      ..userData = userData ?? this.userData;
  }
}

BorrowDetailModelUserData $BorrowDetailModelUserDataFromJson(Map<String, dynamic> json) {
  final BorrowDetailModelUserData borrowDetailModelUserData = BorrowDetailModelUserData();
  final String? termId = jsonConvert.convert<String>(json['term_id']);
  if (termId != null) {
    borrowDetailModelUserData.termId = termId;
  }
  final String? days = jsonConvert.convert<String>(json['days']);
  if (days != null) {
    borrowDetailModelUserData.days = days;
  }
  final int? showDays = jsonConvert.convert<int>(json['show_days']);
  if (showDays != null) {
    borrowDetailModelUserData.showDays = showDays;
  }
  final BorrowDetailModelUserDataInfo? info = jsonConvert.convert<BorrowDetailModelUserDataInfo>(json['info']);
  if (info != null) {
    borrowDetailModelUserData.info = info;
  }
  return borrowDetailModelUserData;
}

Map<String, dynamic> $BorrowDetailModelUserDataToJson(BorrowDetailModelUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['term_id'] = entity.termId;
  data['days'] = entity.days;
  data['show_days'] = entity.showDays;
  data['info'] = entity.info.toJson();
  return data;
}

extension BorrowDetailModelUserDataExtension on BorrowDetailModelUserData {
  BorrowDetailModelUserData copyWith({
    String? termId,
    String? days,
    int? showDays,
    BorrowDetailModelUserDataInfo? info,
  }) {
    return BorrowDetailModelUserData()
      ..termId = termId ?? this.termId
      ..days = days ?? this.days
      ..showDays = showDays ?? this.showDays
      ..info = info ?? this.info;
  }
}

BorrowDetailModelUserDataInfo $BorrowDetailModelUserDataInfoFromJson(Map<String, dynamic> json) {
  final BorrowDetailModelUserDataInfo borrowDetailModelUserDataInfo = BorrowDetailModelUserDataInfo();
  final String? proId = jsonConvert.convert<String>(json['pro_id']);
  if (proId != null) {
    borrowDetailModelUserDataInfo.proId = proId;
  }
  final String? proType = jsonConvert.convert<String>(json['pro_type']);
  if (proType != null) {
    borrowDetailModelUserDataInfo.proType = proType;
  }
  final int? instalmentNum = jsonConvert.convert<int>(json['instalment_num']);
  if (instalmentNum != null) {
    borrowDetailModelUserDataInfo.instalmentNum = instalmentNum;
  }
  final String? min = jsonConvert.convert<String>(json['min']);
  if (min != null) {
    borrowDetailModelUserDataInfo.min = min;
  }
  final String? max = jsonConvert.convert<String>(json['max']);
  if (max != null) {
    borrowDetailModelUserDataInfo.max = max;
  }
  final String? money = jsonConvert.convert<String>(json['money']);
  if (money != null) {
    borrowDetailModelUserDataInfo.money = money;
  }
  final List<BorrowDetailModelUserDataInfoData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BorrowDetailModelUserDataInfoData>(e) as BorrowDetailModelUserDataInfoData).toList();
  if (data != null) {
    borrowDetailModelUserDataInfo.data = data;
  }
  return borrowDetailModelUserDataInfo;
}

Map<String, dynamic> $BorrowDetailModelUserDataInfoToJson(BorrowDetailModelUserDataInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pro_id'] = entity.proId;
  data['pro_type'] = entity.proType;
  data['instalment_num'] = entity.instalmentNum;
  data['min'] = entity.min;
  data['max'] = entity.max;
  data['money'] = entity.money;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

extension BorrowDetailModelUserDataInfoExtension on BorrowDetailModelUserDataInfo {
  BorrowDetailModelUserDataInfo copyWith({
    String? proId,
    String? proType,
    int? instalmentNum,
    String? min,
    String? max,
    String? money,
    List<BorrowDetailModelUserDataInfoData>? data,
  }) {
    return BorrowDetailModelUserDataInfo()
      ..proId = proId ?? this.proId
      ..proType = proType ?? this.proType
      ..instalmentNum = instalmentNum ?? this.instalmentNum
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..money = money ?? this.money
      ..data = data ?? this.data;
  }
}

BorrowDetailModelUserDataInfoData $BorrowDetailModelUserDataInfoDataFromJson(Map<String, dynamic> json) {
  final BorrowDetailModelUserDataInfoData borrowDetailModelUserDataInfoData = BorrowDetailModelUserDataInfoData();
  final String? rid = jsonConvert.convert<String>(json['rid']);
  if (rid != null) {
    borrowDetailModelUserDataInfoData.rid = rid;
  }
  final String? amount = jsonConvert.convert<String>(json['amount']);
  if (amount != null) {
    borrowDetailModelUserDataInfoData.amount = amount;
  }
  final int? serviceFee = jsonConvert.convert<int>(json['service_fee']);
  if (serviceFee != null) {
    borrowDetailModelUserDataInfoData.serviceFee = serviceFee;
  }
  final int? creditPrice = jsonConvert.convert<int>(json['credit_price']);
  if (creditPrice != null) {
    borrowDetailModelUserDataInfoData.creditPrice = creditPrice;
  }
  final int? managePrice = jsonConvert.convert<int>(json['manage_price']);
  if (managePrice != null) {
    borrowDetailModelUserDataInfoData.managePrice = managePrice;
  }
  final int? interest = jsonConvert.convert<int>(json['interest']);
  if (interest != null) {
    borrowDetailModelUserDataInfoData.interest = interest;
  }
  final int? techPrice = jsonConvert.convert<int>(json['tech_price']);
  if (techPrice != null) {
    borrowDetailModelUserDataInfoData.techPrice = techPrice;
  }
  final int? realPrice = jsonConvert.convert<int>(json['real_price']);
  if (realPrice != null) {
    borrowDetailModelUserDataInfoData.realPrice = realPrice;
  }
  final int? repayPrice = jsonConvert.convert<int>(json['repay_price']);
  if (repayPrice != null) {
    borrowDetailModelUserDataInfoData.repayPrice = repayPrice;
  }
  return borrowDetailModelUserDataInfoData;
}

Map<String, dynamic> $BorrowDetailModelUserDataInfoDataToJson(BorrowDetailModelUserDataInfoData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['rid'] = entity.rid;
  data['amount'] = entity.amount;
  data['service_fee'] = entity.serviceFee;
  data['credit_price'] = entity.creditPrice;
  data['manage_price'] = entity.managePrice;
  data['interest'] = entity.interest;
  data['tech_price'] = entity.techPrice;
  data['real_price'] = entity.realPrice;
  data['repay_price'] = entity.repayPrice;
  return data;
}

extension BorrowDetailModelUserDataInfoDataExtension on BorrowDetailModelUserDataInfoData {
  BorrowDetailModelUserDataInfoData copyWith({
    String? rid,
    String? amount,
    int? serviceFee,
    int? creditPrice,
    int? managePrice,
    int? interest,
    int? techPrice,
    int? realPrice,
    int? repayPrice,
  }) {
    return BorrowDetailModelUserDataInfoData()
      ..rid = rid ?? this.rid
      ..amount = amount ?? this.amount
      ..serviceFee = serviceFee ?? this.serviceFee
      ..creditPrice = creditPrice ?? this.creditPrice
      ..managePrice = managePrice ?? this.managePrice
      ..interest = interest ?? this.interest
      ..techPrice = techPrice ?? this.techPrice
      ..realPrice = realPrice ?? this.realPrice
      ..repayPrice = repayPrice ?? this.repayPrice;
  }
}