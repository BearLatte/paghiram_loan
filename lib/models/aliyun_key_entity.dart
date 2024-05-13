import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/aliyun_key_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/aliyun_key_entity.g.dart';

@JsonSerializable()
class AliyunKeyEntity {
	@JSONField(name: "AccessKeyId")
	late String accessKeyId;
	@JSONField(name: "AccessKeySecret")
	late String accessKeySecret;
	@JSONField(name: "Expiration")
	late String expiration;
	@JSONField(name: "SecurityToken")
	late String securityToken;
	@JSONField(name: "StatusCode")
	late int statusCode;

	AliyunKeyEntity();

	factory AliyunKeyEntity.fromJson(Map<String, dynamic> json) => $AliyunKeyEntityFromJson(json);

	Map<String, dynamic> toJson() => $AliyunKeyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}