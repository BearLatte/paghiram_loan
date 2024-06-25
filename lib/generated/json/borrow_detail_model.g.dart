import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/borrow_detail_model.dart';

BorrowDetailModel $BorrowDetailModelFromJson(Map<String, dynamic> json) {
  final BorrowDetailModel borrowDetailModel = BorrowDetailModel();
  final int? loanAmount = jsonConvert.convert<int>(json['loan_amount']);
  if (loanAmount != null) {
    borrowDetailModel.loanAmount = loanAmount;
  }
  final int? loanTerm = jsonConvert.convert<int>(json['loan_term']);
  if (loanTerm != null) {
    borrowDetailModel.loanTerm = loanTerm;
  }
  final int? issuedAmount = jsonConvert.convert<int>(json['issued_amount']);
  if (issuedAmount != null) {
    borrowDetailModel.issuedAmount = issuedAmount;
  }
  final int? serviceFee = jsonConvert.convert<int>(json['service_fee']);
  if (serviceFee != null) {
    borrowDetailModel.serviceFee = serviceFee;
  }
  final int? creditPrice = jsonConvert.convert<int>(json['credit_price']);
  if (creditPrice != null) {
    borrowDetailModel.creditPrice = creditPrice;
  }
  final int? managePrice = jsonConvert.convert<int>(json['manage_price']);
  if (managePrice != null) {
    borrowDetailModel.managePrice = managePrice;
  }
  final int? techPrice = jsonConvert.convert<int>(json['tech_price']);
  if (techPrice != null) {
    borrowDetailModel.techPrice = techPrice;
  }
  final List<BorrowDetailModelRepayData>? repayData = (json['repay_data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BorrowDetailModelRepayData>(e) as BorrowDetailModelRepayData).toList();
  if (repayData != null) {
    borrowDetailModel.repayData = repayData;
  }
  return borrowDetailModel;
}

Map<String, dynamic> $BorrowDetailModelToJson(BorrowDetailModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['loan_amount'] = entity.loanAmount;
  data['loan_term'] = entity.loanTerm;
  data['issued_amount'] = entity.issuedAmount;
  data['service_fee'] = entity.serviceFee;
  data['credit_price'] = entity.creditPrice;
  data['manage_price'] = entity.managePrice;
  data['tech_price'] = entity.techPrice;
  data['repay_data'] = entity.repayData.map((v) => v.toJson()).toList();
  return data;
}

extension BorrowDetailModelExtension on BorrowDetailModel {
  BorrowDetailModel copyWith({
    int? loanAmount,
    int? loanTerm,
    int? issuedAmount,
    int? serviceFee,
    int? creditPrice,
    int? managePrice,
    int? techPrice,
    List<BorrowDetailModelRepayData>? repayData,
  }) {
    return BorrowDetailModel()
      ..loanAmount = loanAmount ?? this.loanAmount
      ..loanTerm = loanTerm ?? this.loanTerm
      ..issuedAmount = issuedAmount ?? this.issuedAmount
      ..serviceFee = serviceFee ?? this.serviceFee
      ..creditPrice = creditPrice ?? this.creditPrice
      ..managePrice = managePrice ?? this.managePrice
      ..techPrice = techPrice ?? this.techPrice
      ..repayData = repayData ?? this.repayData;
  }
}

BorrowDetailModelRepayData $BorrowDetailModelRepayDataFromJson(Map<String, dynamic> json) {
  final BorrowDetailModelRepayData borrowDetailModelRepayData = BorrowDetailModelRepayData();
  final String? backTime = jsonConvert.convert<String>(json['back_time']);
  if (backTime != null) {
    borrowDetailModelRepayData.backTime = backTime;
  }
  final int? principal = jsonConvert.convert<int>(json['principal']);
  if (principal != null) {
    borrowDetailModelRepayData.principal = principal;
  }
  final int? repayPrice = jsonConvert.convert<int>(json['repay_price']);
  if (repayPrice != null) {
    borrowDetailModelRepayData.repayPrice = repayPrice;
  }
  final int? interest = jsonConvert.convert<int>(json['interest']);
  if (interest != null) {
    borrowDetailModelRepayData.interest = interest;
  }
  return borrowDetailModelRepayData;
}

Map<String, dynamic> $BorrowDetailModelRepayDataToJson(BorrowDetailModelRepayData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['back_time'] = entity.backTime;
  data['principal'] = entity.principal;
  data['repay_price'] = entity.repayPrice;
  data['interest'] = entity.interest;
  return data;
}

extension BorrowDetailModelRepayDataExtension on BorrowDetailModelRepayData {
  BorrowDetailModelRepayData copyWith({
    String? backTime,
    int? principal,
    int? repayPrice,
    int? interest,
  }) {
    return BorrowDetailModelRepayData()
      ..backTime = backTime ?? this.backTime
      ..principal = principal ?? this.principal
      ..repayPrice = repayPrice ?? this.repayPrice
      ..interest = interest ?? this.interest;
  }
}