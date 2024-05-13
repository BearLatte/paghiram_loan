import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/marquee_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/marquee_entity.g.dart';

@JsonSerializable()
class MarqueeEntity {
	late String id;
	late String text;

	MarqueeEntity();

	factory MarqueeEntity.fromJson(Map<String, dynamic> json) => $MarqueeEntityFromJson(json);

	Map<String, dynamic> toJson() => $MarqueeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}