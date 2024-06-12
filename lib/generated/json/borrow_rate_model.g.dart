import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/borrow_rate_model.dart';
import 'package:intl/intl.dart';


BorrowRateModel $BorrowRateModelFromJson(Map<String, dynamic> json) {
  final BorrowRateModel borrowRateModel = BorrowRateModel();
  final String? minDays = jsonConvert.convert<String>(json['min_days']);
  if (minDays != null) {
    borrowRateModel.minDays = minDays;
  }
  final String? maxDays = jsonConvert.convert<String>(json['max_days']);
  if (maxDays != null) {
    borrowRateModel.maxDays = maxDays;
  }
  final int? time = jsonConvert.convert<int>(json['time']);
  if (time != null) {
    borrowRateModel.time = time;
  }
  final String? maxPrice = jsonConvert.convert<String>(json['max_price']);
  if (maxPrice != null) {
    borrowRateModel.maxPrice = maxPrice;
  }
  final List<BorrowRateModelUserData>? userData = (json['user_data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BorrowRateModelUserData>(e) as BorrowRateModelUserData).toList();
  if (userData != null) {
    borrowRateModel.userData = userData;
  }
  return borrowRateModel;
}

Map<String, dynamic> $BorrowRateModelToJson(BorrowRateModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['min_days'] = entity.minDays;
  data['max_days'] = entity.maxDays;
  data['time'] = entity.time;
  data['max_price'] = entity.maxPrice;
  data['user_data'] = entity.userData.map((v) => v.toJson()).toList();
  return data;
}

extension BorrowRateModelExtension on BorrowRateModel {
  BorrowRateModel copyWith({
    String? minDays,
    String? maxDays,
    int? time,
    String? maxPrice,
    List<BorrowRateModelUserData>? userData,
  }) {
    return BorrowRateModel()
      ..minDays = minDays ?? this.minDays
      ..maxDays = maxDays ?? this.maxDays
      ..time = time ?? this.time
      ..maxPrice = maxPrice ?? this.maxPrice
      ..userData = userData ?? this.userData;
  }
}

BorrowRateModelUserData $BorrowRateModelUserDataFromJson(Map<String, dynamic> json) {
  final BorrowRateModelUserData borrowRateModelUserData = BorrowRateModelUserData();
  final String? termId = jsonConvert.convert<String>(json['term_id']);
  if (termId != null) {
    borrowRateModelUserData.termId = termId;
  }
  final String? days = jsonConvert.convert<String>(json['days']);
  if (days != null) {
    borrowRateModelUserData.days = days;
  }
  final int? showDays = jsonConvert.convert<int>(json['show_days']);
  if (showDays != null) {
    borrowRateModelUserData.showDays = showDays;
  }
  final BorrowRateModelUserDataInfo? info = jsonConvert.convert<BorrowRateModelUserDataInfo>(json['info']);
  if (info != null) {
    borrowRateModelUserData.info = info;
  }
  return borrowRateModelUserData;
}

Map<String, dynamic> $BorrowRateModelUserDataToJson(BorrowRateModelUserData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['term_id'] = entity.termId;
  data['days'] = entity.days;
  data['show_days'] = entity.showDays;
  data['info'] = entity.info.toJson();
  return data;
}

extension BorrowRateModelUserDataExtension on BorrowRateModelUserData {
  BorrowRateModelUserData copyWith({
    String? termId,
    String? days,
    int? showDays,
    BorrowRateModelUserDataInfo? info,
  }) {
    return BorrowRateModelUserData()
      ..termId = termId ?? this.termId
      ..days = days ?? this.days
      ..showDays = showDays ?? this.showDays
      ..info = info ?? this.info;
  }
}

BorrowRateModelUserDataInfo $BorrowRateModelUserDataInfoFromJson(Map<String, dynamic> json) {
  final BorrowRateModelUserDataInfo borrowRateModelUserDataInfo = BorrowRateModelUserDataInfo();
  final String? proId = jsonConvert.convert<String>(json['pro_id']);
  if (proId != null) {
    borrowRateModelUserDataInfo.proId = proId;
  }
  final String? proType = jsonConvert.convert<String>(json['pro_type']);
  if (proType != null) {
    borrowRateModelUserDataInfo.proType = proType;
  }
  final int? instalmentNum = jsonConvert.convert<int>(json['instalment_num']);
  if (instalmentNum != null) {
    borrowRateModelUserDataInfo.instalmentNum = instalmentNum;
  }
  final String? min = jsonConvert.convert<String>(json['min']);
  if (min != null) {
    borrowRateModelUserDataInfo.min = min;
  }
  final String? max = jsonConvert.convert<String>(json['max']);
  if (max != null) {
    borrowRateModelUserDataInfo.max = max;
  }
  final int? money = jsonConvert.convert<int>(json['money']);
  if (money != null) {
    borrowRateModelUserDataInfo.money = money;
  }
  final List<BorrowRateModelUserDataInfoData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BorrowRateModelUserDataInfoData>(e) as BorrowRateModelUserDataInfoData).toList();
  if (data != null) {
    borrowRateModelUserDataInfo.data = data;
  }
  return borrowRateModelUserDataInfo;
}

Map<String, dynamic> $BorrowRateModelUserDataInfoToJson(BorrowRateModelUserDataInfo entity) {
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

extension BorrowRateModelUserDataInfoExtension on BorrowRateModelUserDataInfo {
  BorrowRateModelUserDataInfo copyWith({
    String? proId,
    String? proType,
    int? instalmentNum,
    String? min,
    String? max,
    int? money,
    List<BorrowRateModelUserDataInfoData>? data,
  }) {
    return BorrowRateModelUserDataInfo()
      ..proId = proId ?? this.proId
      ..proType = proType ?? this.proType
      ..instalmentNum = instalmentNum ?? this.instalmentNum
      ..min = min ?? this.min
      ..max = max ?? this.max
      ..money = money ?? this.money
      ..data = data ?? this.data;
  }
}

BorrowRateModelUserDataInfoData $BorrowRateModelUserDataInfoDataFromJson(Map<String, dynamic> json) {
  final BorrowRateModelUserDataInfoData borrowRateModelUserDataInfoData = BorrowRateModelUserDataInfoData();
  final String? rid = jsonConvert.convert<String>(json['rid']);
  if (rid != null) {
    borrowRateModelUserDataInfoData.rid = rid;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    borrowRateModelUserDataInfoData.amount = amount;
  }
  final int? serviceFee = jsonConvert.convert<int>(json['service_fee']);
  if (serviceFee != null) {
    borrowRateModelUserDataInfoData.serviceFee = serviceFee;
  }
  final int? creditPrice = jsonConvert.convert<int>(json['credit_price']);
  if (creditPrice != null) {
    borrowRateModelUserDataInfoData.creditPrice = creditPrice;
  }
  final int? managePrice = jsonConvert.convert<int>(json['manage_price']);
  if (managePrice != null) {
    borrowRateModelUserDataInfoData.managePrice = managePrice;
  }
  final int? interest = jsonConvert.convert<int>(json['interest']);
  if (interest != null) {
    borrowRateModelUserDataInfoData.interest = interest;
  }
  final int? techPrice = jsonConvert.convert<int>(json['tech_price']);
  if (techPrice != null) {
    borrowRateModelUserDataInfoData.techPrice = techPrice;
  }
  final int? realPrice = jsonConvert.convert<int>(json['real_price']);
  if (realPrice != null) {
    borrowRateModelUserDataInfoData.realPrice = realPrice;
  }
  final int? repayPrice = jsonConvert.convert<int>(json['repay_price']);
  if (repayPrice != null) {
    borrowRateModelUserDataInfoData.repayPrice = repayPrice;
  }
  return borrowRateModelUserDataInfoData;
}

Map<String, dynamic> $BorrowRateModelUserDataInfoDataToJson(BorrowRateModelUserDataInfoData entity) {
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

extension BorrowRateModelUserDataInfoDataExtension on BorrowRateModelUserDataInfoData {
  BorrowRateModelUserDataInfoData copyWith({
    String? rid,
    int? amount,
    int? serviceFee,
    int? creditPrice,
    int? managePrice,
    int? interest,
    int? techPrice,
    int? realPrice,
    int? repayPrice,
  }) {
    return BorrowRateModelUserDataInfoData()
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