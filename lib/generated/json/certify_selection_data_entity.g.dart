import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/certify_selection_data_entity.dart';

CertifySelectionDataEntity $CertifySelectionDataEntityFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataEntity certifySelectionDataEntity = CertifySelectionDataEntity();
  final List<CertifySelectionDataEschool>? eschool = (json['eschool'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataEschool>(e) as CertifySelectionDataEschool).toList();
  if (eschool != null) {
    certifySelectionDataEntity.eschool = eschool;
  }
  final List<CertifySelectionDataMerryState>? merryState = (json['merry_state'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataMerryState>(e) as CertifySelectionDataMerryState).toList();
  if (merryState != null) {
    certifySelectionDataEntity.merryState = merryState;
  }
  final List<CertifySelectionDataKidNumber>? kidNumber = (json['kid_number'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataKidNumber>(e) as CertifySelectionDataKidNumber).toList();
  if (kidNumber != null) {
    certifySelectionDataEntity.kidNumber = kidNumber;
  }
  final List<CertifySelectionDataLivTime>? livTime = (json['liv_time'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataLivTime>(e) as CertifySelectionDataLivTime).toList();
  if (livTime != null) {
    certifySelectionDataEntity.livTime = livTime;
  }
  final List<CertifySelectionDataMyWork>? myWork = (json['my_work'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataMyWork>(e) as CertifySelectionDataMyWork).toList();
  if (myWork != null) {
    certifySelectionDataEntity.myWork = myWork;
  }
  final List<CertifySelectionDataUserWork>? userWork = (json['user_work'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataUserWork>(e) as CertifySelectionDataUserWork).toList();
  if (userWork != null) {
    certifySelectionDataEntity.userWork = userWork;
  }
  final List<CertifySelectionDataMySalary>? mySalary = (json['my_salary'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataMySalary>(e) as CertifySelectionDataMySalary).toList();
  if (mySalary != null) {
    certifySelectionDataEntity.mySalary = mySalary;
  }
  final List<CertifySelectionDataUserReligion>? userReligion = (json['user_religion'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataUserReligion>(e) as CertifySelectionDataUserReligion).toList();
  if (userReligion != null) {
    certifySelectionDataEntity.userReligion = userReligion;
  }
  final List<CertifySelectionDataBranch>? branch = (json['branch'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataBranch>(e) as CertifySelectionDataBranch).toList();
  if (branch != null) {
    certifySelectionDataEntity.branch = branch;
  }
  final List<CertifySelectionDataLvlTime>? lvlTime = (json['lvl_time'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataLvlTime>(e) as CertifySelectionDataLvlTime).toList();
  if (lvlTime != null) {
    certifySelectionDataEntity.lvlTime = lvlTime;
  }
  final List<CertifySelectionDataFr>? fr = (json['fr'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataFr>(e) as CertifySelectionDataFr).toList();
  if (fr != null) {
    certifySelectionDataEntity.fr = fr;
  }
  final List<CertifySelectionDataCtype>? ctype = (json['ctype'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataCtype>(e) as CertifySelectionDataCtype).toList();
  if (ctype != null) {
    certifySelectionDataEntity.ctype = ctype;
  }
  final List<CertifySelectionDataLoanPur>? loanPur = (json['loan_pur'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataLoanPur>(e) as CertifySelectionDataLoanPur).toList();
  if (loanPur != null) {
    certifySelectionDataEntity.loanPur = loanPur;
  }
  final List<CertifySelectionDataUbll>? ubll = (json['ubll'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataUbll>(e) as CertifySelectionDataUbll).toList();
  if (ubll != null) {
    certifySelectionDataEntity.ubll = ubll;
  }
  final List<CertifySelectionDataIto>? ito = (json['ito'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CertifySelectionDataIto>(e) as CertifySelectionDataIto).toList();
  if (ito != null) {
    certifySelectionDataEntity.ito = ito;
  }
  final CertifySelectionDataRelist? relist = jsonConvert.convert<CertifySelectionDataRelist>(json['relist']);
  if (relist != null) {
    certifySelectionDataEntity.relist = relist;
  }
  return certifySelectionDataEntity;
}

Map<String, dynamic> $CertifySelectionDataEntityToJson(CertifySelectionDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['eschool'] = entity.eschool.map((v) => v.toJson()).toList();
  data['merry_state'] = entity.merryState.map((v) => v.toJson()).toList();
  data['kid_number'] = entity.kidNumber.map((v) => v.toJson()).toList();
  data['liv_time'] = entity.livTime.map((v) => v.toJson()).toList();
  data['my_work'] = entity.myWork.map((v) => v.toJson()).toList();
  data['user_work'] = entity.userWork.map((v) => v.toJson()).toList();
  data['my_salary'] = entity.mySalary.map((v) => v.toJson()).toList();
  data['user_religion'] = entity.userReligion.map((v) => v.toJson()).toList();
  data['branch'] = entity.branch.map((v) => v.toJson()).toList();
  data['lvl_time'] = entity.lvlTime.map((v) => v.toJson()).toList();
  data['fr'] = entity.fr.map((v) => v.toJson()).toList();
  data['ctype'] = entity.ctype.map((v) => v.toJson()).toList();
  data['loan_pur'] = entity.loanPur.map((v) => v.toJson()).toList();
  data['ubll'] = entity.ubll.map((v) => v.toJson()).toList();
  data['ito'] = entity.ito.map((v) => v.toJson()).toList();
  data['relist'] = entity.relist.toJson();
  return data;
}

extension CertifySelectionDataEntityExtension on CertifySelectionDataEntity {
  CertifySelectionDataEntity copyWith({
    List<CertifySelectionDataEschool>? eschool,
    List<CertifySelectionDataMerryState>? merryState,
    List<CertifySelectionDataKidNumber>? kidNumber,
    List<CertifySelectionDataLivTime>? livTime,
    List<CertifySelectionDataMyWork>? myWork,
    List<CertifySelectionDataUserWork>? userWork,
    List<CertifySelectionDataMySalary>? mySalary,
    List<CertifySelectionDataUserReligion>? userReligion,
    List<CertifySelectionDataBranch>? branch,
    List<CertifySelectionDataLvlTime>? lvlTime,
    List<CertifySelectionDataFr>? fr,
    List<CertifySelectionDataCtype>? ctype,
    List<CertifySelectionDataLoanPur>? loanPur,
    List<CertifySelectionDataUbll>? ubll,
    List<CertifySelectionDataIto>? ito,
    CertifySelectionDataRelist? relist,
  }) {
    return CertifySelectionDataEntity()
      ..eschool = eschool ?? this.eschool
      ..merryState = merryState ?? this.merryState
      ..kidNumber = kidNumber ?? this.kidNumber
      ..livTime = livTime ?? this.livTime
      ..myWork = myWork ?? this.myWork
      ..userWork = userWork ?? this.userWork
      ..mySalary = mySalary ?? this.mySalary
      ..userReligion = userReligion ?? this.userReligion
      ..branch = branch ?? this.branch
      ..lvlTime = lvlTime ?? this.lvlTime
      ..fr = fr ?? this.fr
      ..ctype = ctype ?? this.ctype
      ..loanPur = loanPur ?? this.loanPur
      ..ubll = ubll ?? this.ubll
      ..ito = ito ?? this.ito
      ..relist = relist ?? this.relist;
  }
}

CertifySelectionDataEschool $CertifySelectionDataEschoolFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataEschool certifySelectionDataEschool = CertifySelectionDataEschool();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataEschool.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataEschool.title = title;
  }
  return certifySelectionDataEschool;
}

Map<String, dynamic> $CertifySelectionDataEschoolToJson(CertifySelectionDataEschool entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataEschoolExtension on CertifySelectionDataEschool {
  CertifySelectionDataEschool copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataEschool()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataMerryState $CertifySelectionDataMerryStateFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataMerryState certifySelectionDataMerryState = CertifySelectionDataMerryState();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataMerryState.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataMerryState.title = title;
  }
  return certifySelectionDataMerryState;
}

Map<String, dynamic> $CertifySelectionDataMerryStateToJson(CertifySelectionDataMerryState entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataMerryStateExtension on CertifySelectionDataMerryState {
  CertifySelectionDataMerryState copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataMerryState()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataKidNumber $CertifySelectionDataKidNumberFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataKidNumber certifySelectionDataKidNumber = CertifySelectionDataKidNumber();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataKidNumber.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataKidNumber.title = title;
  }
  return certifySelectionDataKidNumber;
}

Map<String, dynamic> $CertifySelectionDataKidNumberToJson(CertifySelectionDataKidNumber entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataKidNumberExtension on CertifySelectionDataKidNumber {
  CertifySelectionDataKidNumber copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataKidNumber()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataLivTime $CertifySelectionDataLivTimeFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataLivTime certifySelectionDataLivTime = CertifySelectionDataLivTime();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataLivTime.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataLivTime.title = title;
  }
  return certifySelectionDataLivTime;
}

Map<String, dynamic> $CertifySelectionDataLivTimeToJson(CertifySelectionDataLivTime entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataLivTimeExtension on CertifySelectionDataLivTime {
  CertifySelectionDataLivTime copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataLivTime()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataMyWork $CertifySelectionDataMyWorkFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataMyWork certifySelectionDataMyWork = CertifySelectionDataMyWork();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataMyWork.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataMyWork.title = title;
  }
  return certifySelectionDataMyWork;
}

Map<String, dynamic> $CertifySelectionDataMyWorkToJson(CertifySelectionDataMyWork entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataMyWorkExtension on CertifySelectionDataMyWork {
  CertifySelectionDataMyWork copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataMyWork()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataUserWork $CertifySelectionDataUserWorkFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataUserWork certifySelectionDataUserWork = CertifySelectionDataUserWork();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataUserWork.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataUserWork.title = title;
  }
  return certifySelectionDataUserWork;
}

Map<String, dynamic> $CertifySelectionDataUserWorkToJson(CertifySelectionDataUserWork entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataUserWorkExtension on CertifySelectionDataUserWork {
  CertifySelectionDataUserWork copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataUserWork()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataMySalary $CertifySelectionDataMySalaryFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataMySalary certifySelectionDataMySalary = CertifySelectionDataMySalary();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataMySalary.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataMySalary.title = title;
  }
  return certifySelectionDataMySalary;
}

Map<String, dynamic> $CertifySelectionDataMySalaryToJson(CertifySelectionDataMySalary entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataMySalaryExtension on CertifySelectionDataMySalary {
  CertifySelectionDataMySalary copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataMySalary()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataUserReligion $CertifySelectionDataUserReligionFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataUserReligion certifySelectionDataUserReligion = CertifySelectionDataUserReligion();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataUserReligion.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataUserReligion.title = title;
  }
  return certifySelectionDataUserReligion;
}

Map<String, dynamic> $CertifySelectionDataUserReligionToJson(CertifySelectionDataUserReligion entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataUserReligionExtension on CertifySelectionDataUserReligion {
  CertifySelectionDataUserReligion copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataUserReligion()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataBranch $CertifySelectionDataBranchFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataBranch certifySelectionDataBranch = CertifySelectionDataBranch();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataBranch.id = id;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    certifySelectionDataBranch.type = type;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataBranch.title = title;
  }
  return certifySelectionDataBranch;
}

Map<String, dynamic> $CertifySelectionDataBranchToJson(CertifySelectionDataBranch entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['type'] = entity.type;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataBranchExtension on CertifySelectionDataBranch {
  CertifySelectionDataBranch copyWith({
    String? id,
    String? type,
    String? title,
  }) {
    return CertifySelectionDataBranch()
      ..id = id ?? this.id
      ..type = type ?? this.type
      ..title = title ?? this.title;
  }
}

CertifySelectionDataLvlTime $CertifySelectionDataLvlTimeFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataLvlTime certifySelectionDataLvlTime = CertifySelectionDataLvlTime();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataLvlTime.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataLvlTime.title = title;
  }
  return certifySelectionDataLvlTime;
}

Map<String, dynamic> $CertifySelectionDataLvlTimeToJson(CertifySelectionDataLvlTime entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataLvlTimeExtension on CertifySelectionDataLvlTime {
  CertifySelectionDataLvlTime copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataLvlTime()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataFr $CertifySelectionDataFrFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataFr certifySelectionDataFr = CertifySelectionDataFr();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataFr.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataFr.title = title;
  }
  return certifySelectionDataFr;
}

Map<String, dynamic> $CertifySelectionDataFrToJson(CertifySelectionDataFr entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataFrExtension on CertifySelectionDataFr {
  CertifySelectionDataFr copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataFr()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataCtype $CertifySelectionDataCtypeFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataCtype certifySelectionDataCtype = CertifySelectionDataCtype();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataCtype.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataCtype.title = title;
  }
  return certifySelectionDataCtype;
}

Map<String, dynamic> $CertifySelectionDataCtypeToJson(CertifySelectionDataCtype entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataCtypeExtension on CertifySelectionDataCtype {
  CertifySelectionDataCtype copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataCtype()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataLoanPur $CertifySelectionDataLoanPurFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataLoanPur certifySelectionDataLoanPur = CertifySelectionDataLoanPur();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataLoanPur.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataLoanPur.title = title;
  }
  return certifySelectionDataLoanPur;
}

Map<String, dynamic> $CertifySelectionDataLoanPurToJson(CertifySelectionDataLoanPur entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataLoanPurExtension on CertifySelectionDataLoanPur {
  CertifySelectionDataLoanPur copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataLoanPur()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataUbll $CertifySelectionDataUbllFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataUbll certifySelectionDataUbll = CertifySelectionDataUbll();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataUbll.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataUbll.title = title;
  }
  return certifySelectionDataUbll;
}

Map<String, dynamic> $CertifySelectionDataUbllToJson(CertifySelectionDataUbll entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataUbllExtension on CertifySelectionDataUbll {
  CertifySelectionDataUbll copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataUbll()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataIto $CertifySelectionDataItoFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataIto certifySelectionDataIto = CertifySelectionDataIto();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    certifySelectionDataIto.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    certifySelectionDataIto.title = title;
  }
  return certifySelectionDataIto;
}

Map<String, dynamic> $CertifySelectionDataItoToJson(CertifySelectionDataIto entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  return data;
}

extension CertifySelectionDataItoExtension on CertifySelectionDataIto {
  CertifySelectionDataIto copyWith({
    String? id,
    String? title,
  }) {
    return CertifySelectionDataIto()
      ..id = id ?? this.id
      ..title = title ?? this.title;
  }
}

CertifySelectionDataRelist $CertifySelectionDataRelistFromJson(Map<String, dynamic> json) {
  final CertifySelectionDataRelist certifySelectionDataRelist = CertifySelectionDataRelist();
  final List<String>? t1 = (json['t1'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (t1 != null) {
    certifySelectionDataRelist.t1 = t1;
  }
  final List<String>? t2 = (json['t2'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (t2 != null) {
    certifySelectionDataRelist.t2 = t2;
  }
  final List<String>? t3 = (json['t3'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (t3 != null) {
    certifySelectionDataRelist.t3 = t3;
  }
  return certifySelectionDataRelist;
}

Map<String, dynamic> $CertifySelectionDataRelistToJson(CertifySelectionDataRelist entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['t1'] = entity.t1;
  data['t2'] = entity.t2;
  data['t3'] = entity.t3;
  return data;
}

extension CertifySelectionDataRelistExtension on CertifySelectionDataRelist {
  CertifySelectionDataRelist copyWith({
    List<String>? t1,
    List<String>? t2,
    List<String>? t3,
  }) {
    return CertifySelectionDataRelist()
      ..t1 = t1 ?? this.t1
      ..t2 = t2 ?? this.t2
      ..t3 = t3 ?? this.t3;
  }
}