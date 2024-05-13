import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/auth_state_entity.dart';

AuthStateEntity $AuthStateEntityFromJson(Map<String, dynamic> json) {
  final AuthStateEntity authStateEntity = AuthStateEntity();
  final int? faceState = jsonConvert.convert<int>(json['face_state']);
  if (faceState != null) {
    authStateEntity.faceState = faceState;
  }
  final int? identityState = jsonConvert.convert<int>(json['identity_state']);
  if (identityState != null) {
    authStateEntity.identityState = identityState;
  }
  return authStateEntity;
}

Map<String, dynamic> $AuthStateEntityToJson(AuthStateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['face_state'] = entity.faceState;
  data['identity_state'] = entity.identityState;
  return data;
}

extension AuthStateEntityExtension on AuthStateEntity {
  AuthStateEntity copyWith({
    int? faceState,
    int? identityState,
  }) {
    return AuthStateEntity()
      ..faceState = faceState ?? this.faceState
      ..identityState = identityState ?? this.identityState;
  }
}