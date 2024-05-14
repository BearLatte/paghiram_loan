// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:paghiram_loan/models/aliyun_key_entity.dart';
import 'package:paghiram_loan/models/auth_state_entity.dart';
import 'package:paghiram_loan/models/certification_entity.dart';
import 'package:paghiram_loan/models/certify_selection_data_entity.dart';
import 'package:paghiram_loan/models/contact_entity.dart';
import 'package:paghiram_loan/models/id_card_type_entity.dart';
import 'package:paghiram_loan/models/marquee_entity.dart';
import 'package:paghiram_loan/models/ocr_recgnized_entity.dart';
import 'package:paghiram_loan/models/pgm_photo_entity.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:paghiram_loan/models/submited_ocr_model_entity.dart';

JsonConvert jsonConvert = JsonConvert();

typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);
typedef ConvertExceptionHandler = void Function(Object error, StackTrace stackTrace);
extension MapSafeExt<K, V> on Map<K, V> {
  T? getOrNull<T>(K? key) {
    if (!containsKey(key) || key == null) {
      return null;
    } else {
      return this[key] as T?;
    }
  }
}

class JsonConvert {
  static ConvertExceptionHandler? onError;
  JsonConvertClassCollection convertFuncMap = JsonConvertClassCollection();

  /// When you are in the development, to generate a new model class, hot-reload doesn't find new generation model class, you can build on MaterialApp method called jsonConvert. ReassembleConvertFuncMap (); This method only works in a development environment
  /// https://flutter.cn/docs/development/tools/hot-reload
  /// class MyApp extends StatelessWidget {
  ///    const MyApp({Key? key})
  ///        : super(key: key);
  ///
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      jsonConvert.reassembleConvertFuncMap();
  ///      return MaterialApp();
  ///    }
  /// }
  void reassembleConvertFuncMap() {
    bool isReleaseMode = const bool.fromEnvironment('dart.vm.product');
    if (!isReleaseMode) {
      convertFuncMap = JsonConvertClassCollection();
    }
  }

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e, enumConvert: enumConvert)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => _asT<T>(e, enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(value as Map<String, dynamic>) as T;
      } else {
        throw UnimplementedError('$type unimplemented,you can try running the app again');
      }
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<AliyunKeyEntity>[] is M) {
      return data.map<AliyunKeyEntity>((Map<String, dynamic> e) => AliyunKeyEntity.fromJson(e)).toList() as M;
    }
    if (<AuthStateEntity>[] is M) {
      return data.map<AuthStateEntity>((Map<String, dynamic> e) => AuthStateEntity.fromJson(e)).toList() as M;
    }
    if (<CertificationEntity>[] is M) {
      return data.map<CertificationEntity>((Map<String, dynamic> e) => CertificationEntity.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataEntity>[] is M) {
      return data.map<CertifySelectionDataEntity>((Map<String, dynamic> e) => CertifySelectionDataEntity.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataEschool>[] is M) {
      return data.map<CertifySelectionDataEschool>((Map<String, dynamic> e) => CertifySelectionDataEschool.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataMerryState>[] is M) {
      return data.map<CertifySelectionDataMerryState>((Map<String, dynamic> e) => CertifySelectionDataMerryState.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataKidNumber>[] is M) {
      return data.map<CertifySelectionDataKidNumber>((Map<String, dynamic> e) => CertifySelectionDataKidNumber.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataLivTime>[] is M) {
      return data.map<CertifySelectionDataLivTime>((Map<String, dynamic> e) => CertifySelectionDataLivTime.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataMyWork>[] is M) {
      return data.map<CertifySelectionDataMyWork>((Map<String, dynamic> e) => CertifySelectionDataMyWork.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataUserWork>[] is M) {
      return data.map<CertifySelectionDataUserWork>((Map<String, dynamic> e) => CertifySelectionDataUserWork.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataMySalary>[] is M) {
      return data.map<CertifySelectionDataMySalary>((Map<String, dynamic> e) => CertifySelectionDataMySalary.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataUserReligion>[] is M) {
      return data.map<CertifySelectionDataUserReligion>((Map<String, dynamic> e) => CertifySelectionDataUserReligion.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataBranch>[] is M) {
      return data.map<CertifySelectionDataBranch>((Map<String, dynamic> e) => CertifySelectionDataBranch.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataLvlTime>[] is M) {
      return data.map<CertifySelectionDataLvlTime>((Map<String, dynamic> e) => CertifySelectionDataLvlTime.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataFr>[] is M) {
      return data.map<CertifySelectionDataFr>((Map<String, dynamic> e) => CertifySelectionDataFr.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataCtype>[] is M) {
      return data.map<CertifySelectionDataCtype>((Map<String, dynamic> e) => CertifySelectionDataCtype.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataLoanPur>[] is M) {
      return data.map<CertifySelectionDataLoanPur>((Map<String, dynamic> e) => CertifySelectionDataLoanPur.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataUbll>[] is M) {
      return data.map<CertifySelectionDataUbll>((Map<String, dynamic> e) => CertifySelectionDataUbll.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataIto>[] is M) {
      return data.map<CertifySelectionDataIto>((Map<String, dynamic> e) => CertifySelectionDataIto.fromJson(e)).toList() as M;
    }
    if (<CertifySelectionDataRelist>[] is M) {
      return data.map<CertifySelectionDataRelist>((Map<String, dynamic> e) => CertifySelectionDataRelist.fromJson(e)).toList() as M;
    }
    if (<ContactEntity>[] is M) {
      return data.map<ContactEntity>((Map<String, dynamic> e) => ContactEntity.fromJson(e)).toList() as M;
    }
    if (<IdCardTypeEntity>[] is M) {
      return data.map<IdCardTypeEntity>((Map<String, dynamic> e) => IdCardTypeEntity.fromJson(e)).toList() as M;
    }
    if (<MarqueeEntity>[] is M) {
      return data.map<MarqueeEntity>((Map<String, dynamic> e) => MarqueeEntity.fromJson(e)).toList() as M;
    }
    if (<OcrRecgnizedEntity>[] is M) {
      return data.map<OcrRecgnizedEntity>((Map<String, dynamic> e) => OcrRecgnizedEntity.fromJson(e)).toList() as M;
    }
    if (<PgmPhotoEntity>[] is M) {
      return data.map<PgmPhotoEntity>((Map<String, dynamic> e) => PgmPhotoEntity.fromJson(e)).toList() as M;
    }
    if (<ProductModelEntity>[] is M) {
      return data.map<ProductModelEntity>((Map<String, dynamic> e) => ProductModelEntity.fromJson(e)).toList() as M;
    }
    if (<SubmitedOcrModelEntity>[] is M) {
      return data.map<SubmitedOcrModelEntity>((Map<String, dynamic> e) => SubmitedOcrModelEntity.fromJson(e)).toList() as M;
    }

    debugPrint("$M not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is M) {
      return json;
    }
    if (json is List) {
      return _getListChildType<M>(json.map((dynamic e) => e as Map<String, dynamic>).toList());
    } else {
      return jsonConvert.convert<M>(json);
    }
  }
}

class JsonConvertClassCollection {
  Map<String, JsonConvertFunction> convertFuncMap = {
    (AliyunKeyEntity).toString(): AliyunKeyEntity.fromJson,
    (AuthStateEntity).toString(): AuthStateEntity.fromJson,
    (CertificationEntity).toString(): CertificationEntity.fromJson,
    (CertifySelectionDataEntity).toString(): CertifySelectionDataEntity.fromJson,
    (CertifySelectionDataEschool).toString(): CertifySelectionDataEschool.fromJson,
    (CertifySelectionDataMerryState).toString(): CertifySelectionDataMerryState.fromJson,
    (CertifySelectionDataKidNumber).toString(): CertifySelectionDataKidNumber.fromJson,
    (CertifySelectionDataLivTime).toString(): CertifySelectionDataLivTime.fromJson,
    (CertifySelectionDataMyWork).toString(): CertifySelectionDataMyWork.fromJson,
    (CertifySelectionDataUserWork).toString(): CertifySelectionDataUserWork.fromJson,
    (CertifySelectionDataMySalary).toString(): CertifySelectionDataMySalary.fromJson,
    (CertifySelectionDataUserReligion).toString(): CertifySelectionDataUserReligion.fromJson,
    (CertifySelectionDataBranch).toString(): CertifySelectionDataBranch.fromJson,
    (CertifySelectionDataLvlTime).toString(): CertifySelectionDataLvlTime.fromJson,
    (CertifySelectionDataFr).toString(): CertifySelectionDataFr.fromJson,
    (CertifySelectionDataCtype).toString(): CertifySelectionDataCtype.fromJson,
    (CertifySelectionDataLoanPur).toString(): CertifySelectionDataLoanPur.fromJson,
    (CertifySelectionDataUbll).toString(): CertifySelectionDataUbll.fromJson,
    (CertifySelectionDataIto).toString(): CertifySelectionDataIto.fromJson,
    (CertifySelectionDataRelist).toString(): CertifySelectionDataRelist.fromJson,
    (ContactEntity).toString(): ContactEntity.fromJson,
    (IdCardTypeEntity).toString(): IdCardTypeEntity.fromJson,
    (MarqueeEntity).toString(): MarqueeEntity.fromJson,
    (OcrRecgnizedEntity).toString(): OcrRecgnizedEntity.fromJson,
    (PgmPhotoEntity).toString(): PgmPhotoEntity.fromJson,
    (ProductModelEntity).toString(): ProductModelEntity.fromJson,
    (SubmitedOcrModelEntity).toString(): SubmitedOcrModelEntity.fromJson,
  };

  bool containsKey(String type) {
    return convertFuncMap.containsKey(type);
  }

  JsonConvertFunction? operator [](String key) {
    return convertFuncMap[key];
  }
}