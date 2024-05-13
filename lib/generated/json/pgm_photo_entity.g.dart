import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/pgm_photo_entity.dart';

PgmPhotoEntity $PgmPhotoEntityFromJson(Map<String, dynamic> json) {
  final PgmPhotoEntity pgmPhotoEntity = PgmPhotoEntity();
  final String? pgmPhoto = jsonConvert.convert<String>(json['pgm_photo']);
  if (pgmPhoto != null) {
    pgmPhotoEntity.pgmPhoto = pgmPhoto;
  }
  final dynamic liveId = json['live_id'];
  if (liveId != null) {
    pgmPhotoEntity.liveId = liveId;
  }
  return pgmPhotoEntity;
}

Map<String, dynamic> $PgmPhotoEntityToJson(PgmPhotoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['pgm_photo'] = entity.pgmPhoto;
  data['live_id'] = entity.liveId;
  return data;
}

extension PgmPhotoEntityExtension on PgmPhotoEntity {
  PgmPhotoEntity copyWith({
    String? pgmPhoto,
    dynamic liveId,
  }) {
    return PgmPhotoEntity()
      ..pgmPhoto = pgmPhoto ?? this.pgmPhoto
      ..liveId = liveId ?? this.liveId;
  }
}