import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/ocr_recgnized_entity.dart';

OcrRecgnizedEntity $OcrRecgnizedEntityFromJson(Map<String, dynamic> json) {
  final OcrRecgnizedEntity ocrRecgnizedEntity = OcrRecgnizedEntity();
  final String? lastName = jsonConvert.convert<String>(json['last_name']);
  if (lastName != null) {
    ocrRecgnizedEntity.lastName = lastName;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    ocrRecgnizedEntity.firstName = firstName;
  }
  final String? middleName = jsonConvert.convert<String>(json['middle_name']);
  if (middleName != null) {
    ocrRecgnizedEntity.middleName = middleName;
  }
  final String? idCard = jsonConvert.convert<String>(json['id_card']);
  if (idCard != null) {
    ocrRecgnizedEntity.idCard = idCard;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    ocrRecgnizedEntity.gender = gender;
  }
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    ocrRecgnizedEntity.birthday = birthday;
  }
  return ocrRecgnizedEntity;
}

Map<String, dynamic> $OcrRecgnizedEntityToJson(OcrRecgnizedEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['last_name'] = entity.lastName;
  data['first_name'] = entity.firstName;
  data['middle_name'] = entity.middleName;
  data['id_card'] = entity.idCard;
  data['gender'] = entity.gender;
  data['birthday'] = entity.birthday;
  return data;
}

extension OcrRecgnizedEntityExtension on OcrRecgnizedEntity {
  OcrRecgnizedEntity copyWith({
    String? lastName,
    String? firstName,
    String? middleName,
    String? idCard,
    String? gender,
    String? birthday,
  }) {
    return OcrRecgnizedEntity()
      ..lastName = lastName ?? this.lastName
      ..firstName = firstName ?? this.firstName
      ..middleName = middleName ?? this.middleName
      ..idCard = idCard ?? this.idCard
      ..gender = gender ?? this.gender
      ..birthday = birthday ?? this.birthday;
  }
}