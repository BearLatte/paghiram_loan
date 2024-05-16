import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:intl/intl.dart';

import 'package:paghiram_loan/view/loan/product_status_item.dart';


ProductModelEntity $ProductModelEntityFromJson(Map<String, dynamic> json) {
  final ProductModelEntity productModelEntity = ProductModelEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productModelEntity.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    productModelEntity.productName = productName;
  }
  final String? appNames = jsonConvert.convert<String>(json['app_names']);
  if (appNames != null) {
    productModelEntity.appNames = appNames;
  }
  final int? minMoney = jsonConvert.convert<int>(json['min_money']);
  if (minMoney != null) {
    productModelEntity.minMoney = minMoney;
  }
  final int? maxMoney = jsonConvert.convert<int>(json['max_money']);
  if (maxMoney != null) {
    productModelEntity.maxMoney = maxMoney;
  }
  final double? interest = jsonConvert.convert<double>(json['interest']);
  if (interest != null) {
    productModelEntity.interest = interest;
  }
  final String? flag = jsonConvert.convert<String>(json['flag']);
  if (flag != null) {
    productModelEntity.flag = flag;
  }
  final String? loanTime = jsonConvert.convert<String>(json['loan_time']);
  if (loanTime != null) {
    productModelEntity.loanTime = loanTime;
  }
  final String? loanTerm = jsonConvert.convert<String>(json['loan_term']);
  if (loanTerm != null) {
    productModelEntity.loanTerm = loanTerm;
  }
  final String? logoImg = jsonConvert.convert<String>(json['logo_img']);
  if (logoImg != null) {
    productModelEntity.logoImg = logoImg;
  }
  final int? isLoan = jsonConvert.convert<int>(json['is_loan']);
  if (isLoan != null) {
    productModelEntity.isLoan = isLoan;
  }
  final int? overdueDays = jsonConvert.convert<int>(json['overdue_days']);
  if (overdueDays != null) {
    productModelEntity.overdueDays = overdueDays;
  }
  final int? countDown = jsonConvert.convert<int>(json['count_down']);
  if (countDown != null) {
    productModelEntity.countDown = countDown;
  }
  final int? backTime = jsonConvert.convert<int>(json['back_time']);
  if (backTime != null) {
    productModelEntity.backTime = backTime;
  }
  final int? money = jsonConvert.convert<int>(json['money']);
  if (money != null) {
    productModelEntity.money = money;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productModelEntity.status = status;
  }
  return productModelEntity;
}

Map<String, dynamic> $ProductModelEntityToJson(ProductModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_name'] = entity.productName;
  data['app_names'] = entity.appNames;
  data['min_money'] = entity.minMoney;
  data['max_money'] = entity.maxMoney;
  data['interest'] = entity.interest;
  data['flag'] = entity.flag;
  data['loan_time'] = entity.loanTime;
  data['loan_term'] = entity.loanTerm;
  data['logo_img'] = entity.logoImg;
  data['is_loan'] = entity.isLoan;
  data['overdue_days'] = entity.overdueDays;
  data['count_down'] = entity.countDown;
  data['back_time'] = entity.backTime;
  data['money'] = entity.money;
  data['status'] = entity.status;
  return data;
}

extension ProductModelEntityExtension on ProductModelEntity {
  ProductModelEntity copyWith({
    String? id,
    String? productName,
    String? appNames,
    int? minMoney,
    int? maxMoney,
    double? interest,
    String? flag,
    String? loanTime,
    String? loanTerm,
    String? logoImg,
    int? isLoan,
    int? overdueDays,
    int? countDown,
    int? backTime,
    int? money,
    int? status,
  }) {
    return ProductModelEntity()
      ..id = id ?? this.id
      ..productName = productName ?? this.productName
      ..appNames = appNames ?? this.appNames
      ..minMoney = minMoney ?? this.minMoney
      ..maxMoney = maxMoney ?? this.maxMoney
      ..interest = interest ?? this.interest
      ..flag = flag ?? this.flag
      ..loanTime = loanTime ?? this.loanTime
      ..loanTerm = loanTerm ?? this.loanTerm
      ..logoImg = logoImg ?? this.logoImg
      ..isLoan = isLoan ?? this.isLoan
      ..overdueDays = overdueDays ?? this.overdueDays
      ..countDown = countDown ?? this.countDown
      ..backTime = backTime ?? this.backTime
      ..money = money ?? this.money
      ..status = status ?? this.status;
  }
}