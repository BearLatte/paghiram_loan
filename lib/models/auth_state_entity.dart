import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/auth_state_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/auth_state_entity.g.dart';

@JsonSerializable()
class AuthStateEntity {
	@JSONField(name: "face_state")
	late int faceState;
	@JSONField(name: "identity_state")
	late int identityState;

	AuthStateEntity();

	factory AuthStateEntity.fromJson(Map<String, dynamic> json) => $AuthStateEntityFromJson(json);

	Map<String, dynamic> toJson() => $AuthStateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}