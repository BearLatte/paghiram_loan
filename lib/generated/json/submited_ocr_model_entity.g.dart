import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/submited_ocr_model_entity.dart';

SubmitedOcrModelEntity $SubmitedOcrModelEntityFromJson(Map<String, dynamic> json) {
  final SubmitedOcrModelEntity submitedOcrModelEntity = SubmitedOcrModelEntity();
  final String? birthday = jsonConvert.convert<String>(json['birthday']);
  if (birthday != null) {
    submitedOcrModelEntity.birthday = birthday;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    submitedOcrModelEntity.gender = gender;
  }
  final String? idNumber = jsonConvert.convert<String>(json['id_number']);
  if (idNumber != null) {
    submitedOcrModelEntity.idNumber = idNumber;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    submitedOcrModelEntity.type = type;
  }
  final dynamic other = json['other'];
  if (other != null) {
    submitedOcrModelEntity.other = other;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    submitedOcrModelEntity.firstName = firstName;
  }
  final String? middleName = jsonConvert.convert<String>(json['middle_name']);
  if (middleName != null) {
    submitedOcrModelEntity.middleName = middleName;
  }
  final String? lastName = jsonConvert.convert<String>(json['last_name']);
  if (lastName != null) {
    submitedOcrModelEntity.lastName = lastName;
  }
  return submitedOcrModelEntity;
}

Map<String, dynamic> $SubmitedOcrModelEntityToJson(SubmitedOcrModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['birthday'] = entity.birthday;
  data['gender'] = entity.gender;
  data['id_number'] = entity.idNumber;
  data['type'] = entity.type;
  data['other'] = entity.other;
  data['first_name'] = entity.firstName;
  data['middle_name'] = entity.middleName;
  data['last_name'] = entity.lastName;
  return data;
}

extension SubmitedOcrModelEntityExtension on SubmitedOcrModelEntity {
  SubmitedOcrModelEntity copyWith({
    String? birthday,
    String? gender,
    String? idNumber,
    String? type,
    dynamic other,
    String? firstName,
    String? middleName,
    String? lastName,
  }) {
    return SubmitedOcrModelEntity()
      ..birthday = birthday ?? this.birthday
      ..gender = gender ?? this.gender
      ..idNumber = idNumber ?? this.idNumber
      ..type = type ?? this.type
      ..other = other ?? this.other
      ..firstName = firstName ?? this.firstName
      ..middleName = middleName ?? this.middleName
      ..lastName = lastName ?? this.lastName;
  }
}