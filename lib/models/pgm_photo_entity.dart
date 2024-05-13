import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/pgm_photo_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/pgm_photo_entity.g.dart';

@JsonSerializable()
class PgmPhotoEntity {
	@JSONField(name: "pgm_photo")
	late String pgmPhoto;
	@JSONField(name: "live_id")
	dynamic liveId;

	PgmPhotoEntity();

	factory PgmPhotoEntity.fromJson(Map<String, dynamic> json) => $PgmPhotoEntityFromJson(json);

	Map<String, dynamic> toJson() => $PgmPhotoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}