import 'package:intl/intl.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JSONField(name: "pack_name")
  late String packName;
  @JSONField(name: "pack_img")
  late String packImg;
  late String pid;
  @JSONField(name: "back_time")
  late String backTime;
  late int status;
  late int price;

  String get formattedBackTime {
    return DateFormat('MM/dd/yyyy').format(DateTime.parse(backTime));
  }

  String get overdueDays {
    return ((DateTime.now().millisecondsSinceEpoch - DateTime.parse(backTime).millisecondsSinceEpoch) / (60 * 60 * 24 * 1000)).ceil().toString();
  }

  OrderModel();

  factory OrderModel.fromJson(Map<String, dynamic> json) => $OrderModelFromJson(json);

  Map<String, dynamic> toJson() => $OrderModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
