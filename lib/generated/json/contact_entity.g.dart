import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/contact_entity.dart';

ContactEntity $ContactEntityFromJson(Map<String, dynamic> json) {
  final ContactEntity contactEntity = ContactEntity();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    contactEntity.name = name;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    contactEntity.phone = phone;
  }
  final String? relation = jsonConvert.convert<String>(json['relation']);
  if (relation != null) {
    contactEntity.relation = relation;
  }
  return contactEntity;
}

Map<String, dynamic> $ContactEntityToJson(ContactEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  data['relation'] = entity.relation;
  return data;
}

extension ContactEntityExtension on ContactEntity {
  ContactEntity copyWith({
    String? name,
    String? phone,
    String? relation,
  }) {
    return ContactEntity()
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..relation = relation ?? this.relation;
  }
}