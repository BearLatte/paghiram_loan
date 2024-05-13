import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/marquee_entity.dart';

MarqueeEntity $MarqueeEntityFromJson(Map<String, dynamic> json) {
  final MarqueeEntity marqueeEntity = MarqueeEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    marqueeEntity.id = id;
  }
  final String? text = jsonConvert.convert<String>(json['text']);
  if (text != null) {
    marqueeEntity.text = text;
  }
  return marqueeEntity;
}

Map<String, dynamic> $MarqueeEntityToJson(MarqueeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['text'] = entity.text;
  return data;
}

extension MarqueeEntityExtension on MarqueeEntity {
  MarqueeEntity copyWith({
    String? id,
    String? text,
  }) {
    return MarqueeEntity()
      ..id = id ?? this.id
      ..text = text ?? this.text;
  }
}