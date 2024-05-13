import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/id_card_type_entity.dart';

IdCardTypeEntity $IdCardTypeEntityFromJson(Map<String, dynamic> json) {
  final IdCardTypeEntity idCardTypeEntity = IdCardTypeEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    idCardTypeEntity.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    idCardTypeEntity.title = title;
  }
  return idCardTypeEntity;
}

Map<String, dynamic> $IdCardTypeEntityToJson(IdCardTypeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension IdCardTypeEntityExtension on IdCardTypeEntity {
  IdCardTypeEntity copyWith({
    String? id,
    String? title,
  }) {
    return IdCardTypeEntity()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}