import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/order_model.dart';

OrderModel $OrderModelFromJson(Map<String, dynamic> json) {
  final OrderModel orderModel = OrderModel();
  final String? packName = jsonConvert.convert<String>(json['pack_name']);
  if (packName != null) {
    orderModel.packName = packName;
  }
  final String? packImg = jsonConvert.convert<String>(json['pack_img']);
  if (packImg != null) {
    orderModel.packImg = packImg;
  }
  final String? pid = jsonConvert.convert<String>(json['pid']);
  if (pid != null) {
    orderModel.pid = pid;
  }
  final String? backTime = jsonConvert.convert<String>(json['back_time']);
  if (backTime != null) {
    orderModel.backTime = backTime;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    orderModel.status = status;
  }
  final int? price = jsonConvert.convert<int>(json['price']);
  if (price != null) {
    orderModel.price = price;
  }
  return orderModel;
}

Map<String, dynamic> $OrderModelToJson(OrderModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pack_name'] = entity.packName;
  data['pack_img'] = entity.packImg;
  data['pid'] = entity.pid;
  data['back_time'] = entity.backTime;
  data['status'] = entity.status;
  data['price'] = entity.price;
  return data;
}

extension OrderModelExtension on OrderModel {
  OrderModel copyWith({
    String? packName,
    String? packImg,
    String? pid,
    String? backTime,
    int? status,
    int? price,
  }) {
    return OrderModel()
      ..packName = packName ?? this.packName
      ..packImg = packImg ?? this.packImg
      ..pid = pid ?? this.pid
      ..backTime = backTime ?? this.backTime
      ..status = status ?? this.status
      ..price = price ?? this.price;
  }
}