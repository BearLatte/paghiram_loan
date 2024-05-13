import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/aliyun_key_entity.dart';

AliyunKeyEntity $AliyunKeyEntityFromJson(Map<String, dynamic> json) {
  final AliyunKeyEntity aliyunKeyEntity = AliyunKeyEntity();
  final String? accessKeyId = jsonConvert.convert<String>(json['AccessKeyId']);
  if (accessKeyId != null) {
    aliyunKeyEntity.accessKeyId = accessKeyId;
  }
  final String? accessKeySecret = jsonConvert.convert<String>(json['AccessKeySecret']);
  if (accessKeySecret != null) {
    aliyunKeyEntity.accessKeySecret = accessKeySecret;
  }
  final String? expiration = jsonConvert.convert<String>(json['Expiration']);
  if (expiration != null) {
    aliyunKeyEntity.expiration = expiration;
  }
  final String? securityToken = jsonConvert.convert<String>(json['SecurityToken']);
  if (securityToken != null) {
    aliyunKeyEntity.securityToken = securityToken;
  }
  final int? statusCode = jsonConvert.convert<int>(json['StatusCode']);
  if (statusCode != null) {
    aliyunKeyEntity.statusCode = statusCode;
  }
  return aliyunKeyEntity;
}

Map<String, dynamic> $AliyunKeyEntityToJson(AliyunKeyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['AccessKeyId'] = entity.accessKeyId;
  data['AccessKeySecret'] = entity.accessKeySecret;
  data['Expiration'] = entity.expiration;
  data['SecurityToken'] = entity.securityToken;
  data['StatusCode'] = entity.statusCode;
  return data;
}

extension AliyunKeyEntityExtension on AliyunKeyEntity {
  AliyunKeyEntity copyWith({
    String? accessKeyId,
    String? accessKeySecret,
    String? expiration,
    String? securityToken,
    int? statusCode,
  }) {
    return AliyunKeyEntity()
      ..accessKeyId = accessKeyId ?? this.accessKeyId
      ..accessKeySecret = accessKeySecret ?? this.accessKeySecret
      ..expiration = expiration ?? this.expiration
      ..securityToken = securityToken ?? this.securityToken
      ..statusCode = statusCode ?? this.statusCode;
  }
}