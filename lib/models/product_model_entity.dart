import 'package:intl/intl.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/product_model_entity.g.dart';
import 'dart:convert';

import 'package:paghiram_loan/view/loan/product_status_item.dart';
export 'package:paghiram_loan/generated/json/product_model_entity.g.dart';

@JsonSerializable()
class ProductModelEntity {
  late String id;
  @JSONField(name: "product_name")
  late String productName;
  @JSONField(name: "app_names")
  late String appNames;
  @JSONField(name: "min_money")
  late int minMoney;
  @JSONField(name: "max_money")
  late int maxMoney;
  late double interest;
  late String flag;
  @JSONField(name: "loan_time")
  late String loanTime;
  @JSONField(name: "loan_term")
  late String loanTerm;
  @JSONField(name: "logo_img")
  late String logoImg;
  @JSONField(name: "is_loan")
  late int isLoan;
  @JSONField(name: "overdue_days")
  late int overdueDays;
  @JSONField(name: "count_down")
  int? countDown;
  @JSONField(name: "back_time")
  int? backTime;
  int? money;
  int? status;

  ProductStatus get productState {
    switch (status) {
      case 2:
        return ProductStatus.pending;
      case 3:
        return ProductStatus.canBorrow;
      case 4:
        return ProductStatus.rollback;
      case 5:
        return ProductStatus.repayment;
      case 6:
        return ProductStatus.machineReview;
      case 7:
        return ProductStatus.offlineWithdraw;
      case 8:
        return ProductStatus.reject;
      case 9:
        return ProductStatus.paying;
      case 10:
        return ProductStatus.payFailed;
      default:
        return ProductStatus.normal;
    }
  }

  String get minMoneyFormat {
    var format = NumberFormat('0,000');
    return format.format(minMoney);
  }

  String get maxMoneyFormat {
    var format = NumberFormat('0,000');
    return format.format(maxMoney);
  }

  String get rate {
    return interest.toStringAsFixed(2);
  }

  ProductModelEntity();

  factory ProductModelEntity.fromJson(Map<String, dynamic> json) => $ProductModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
