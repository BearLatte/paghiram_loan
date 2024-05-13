import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/models/certification_entity.dart';

CertificationEntity $CertificationEntityFromJson(Map<String, dynamic> json) {
  final CertificationEntity certificationEntity = CertificationEntity();
  final String? branch = jsonConvert.convert<String>(json['branch']);
  if (branch != null) {
    certificationEntity.branch = branch;
  }
  final String? clientSalary = jsonConvert.convert<String>(json['client_salary']);
  if (clientSalary != null) {
    certificationEntity.clientSalary = clientSalary;
  }
  final String? companyName = jsonConvert.convert<String>(json['company_name']);
  if (companyName != null) {
    certificationEntity.companyName = companyName;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    certificationEntity.email = email;
  }
  final String? eschool = jsonConvert.convert<String>(json['eschool']);
  if (eschool != null) {
    certificationEntity.eschool = eschool;
  }
  final String? fbkName = jsonConvert.convert<String>(json['fbk_name']);
  if (fbkName != null) {
    certificationEntity.fbkName = fbkName;
  }
  final String? gxOne = jsonConvert.convert<String>(json['gx_one']);
  if (gxOne != null) {
    certificationEntity.gxOne = gxOne;
  }
  final String? gxPhone = jsonConvert.convert<String>(json['gx_phone']);
  if (gxPhone != null) {
    certificationEntity.gxPhone = gxPhone;
  }
  final String? gxName = jsonConvert.convert<String>(json['gx_name']);
  if (gxName != null) {
    certificationEntity.gxName = gxName;
  }
  final String? gxTwo = jsonConvert.convert<String>(json['gx_two']);
  if (gxTwo != null) {
    certificationEntity.gxTwo = gxTwo;
  }
  final String? gxPhoneTwo = jsonConvert.convert<String>(json['gx_phone_two']);
  if (gxPhoneTwo != null) {
    certificationEntity.gxPhoneTwo = gxPhoneTwo;
  }
  final String? gxNameTwo = jsonConvert.convert<String>(json['gx_name_two']);
  if (gxNameTwo != null) {
    certificationEntity.gxNameTwo = gxNameTwo;
  }
  final String? gxThree = jsonConvert.convert<String>(json['gx_three']);
  if (gxThree != null) {
    certificationEntity.gxThree = gxThree;
  }
  final String? gxPhoneThree = jsonConvert.convert<String>(json['gx_phone_three']);
  if (gxPhoneThree != null) {
    certificationEntity.gxPhoneThree = gxPhoneThree;
  }
  final String? gxNameThree = jsonConvert.convert<String>(json['gx_name_three']);
  if (gxNameThree != null) {
    certificationEntity.gxNameThree = gxNameThree;
  }
  final String? gxFour = jsonConvert.convert<String>(json['gx_four']);
  if (gxFour != null) {
    certificationEntity.gxFour = gxFour;
  }
  final String? gxPhoneFour = jsonConvert.convert<String>(json['gx_phone_four']);
  if (gxPhoneFour != null) {
    certificationEntity.gxPhoneFour = gxPhoneFour;
  }
  final String? gxNameFour = jsonConvert.convert<String>(json['gx_name_four']);
  if (gxNameFour != null) {
    certificationEntity.gxNameFour = gxNameFour;
  }
  final String? gxFive = jsonConvert.convert<String>(json['gx_five']);
  if (gxFive != null) {
    certificationEntity.gxFive = gxFive;
  }
  final String? gxPhoneFive = jsonConvert.convert<String>(json['gx_phone_five']);
  if (gxPhoneFive != null) {
    certificationEntity.gxPhoneFive = gxPhoneFive;
  }
  final String? gxNameFive = jsonConvert.convert<String>(json['gx_name_five']);
  if (gxNameFive != null) {
    certificationEntity.gxNameFive = gxNameFive;
  }
  final String? hbl = jsonConvert.convert<String>(json['hbl']);
  if (hbl != null) {
    certificationEntity.hbl = hbl;
  }
  final String? kidNumber = jsonConvert.convert<String>(json['kid_number']);
  if (kidNumber != null) {
    certificationEntity.kidNumber = kidNumber;
  }
  final String? lvAddr = jsonConvert.convert<String>(json['lv_addr']);
  if (lvAddr != null) {
    certificationEntity.lvAddr = lvAddr;
  }
  final String? lvCity = jsonConvert.convert<String>(json['lv_city']);
  if (lvCity != null) {
    certificationEntity.lvCity = lvCity;
  }
  final String? lvPro = jsonConvert.convert<String>(json['lv_pro']);
  if (lvPro != null) {
    certificationEntity.lvPro = lvPro;
  }
  final String? lvStre = jsonConvert.convert<String>(json['lv_stre']);
  if (lvStre != null) {
    certificationEntity.lvStre = lvStre;
  }
  final String? merryState = jsonConvert.convert<String>(json['merry_state']);
  if (merryState != null) {
    certificationEntity.merryState = merryState;
  }
  final String? payDateOne = jsonConvert.convert<String>(json['pay_date_one']);
  if (payDateOne != null) {
    certificationEntity.payDateOne = payDateOne;
  }
  final String? payDateTwo = jsonConvert.convert<String>(json['pay_date_two']);
  if (payDateTwo != null) {
    certificationEntity.payDateTwo = payDateTwo;
  }
  final String? secondMobile = jsonConvert.convert<String>(json['second_mobile']);
  if (secondMobile != null) {
    certificationEntity.secondMobile = secondMobile;
  }
  final String? usageType = jsonConvert.convert<String>(json['usage_type']);
  if (usageType != null) {
    certificationEntity.usageType = usageType;
  }
  final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
  if (whatsapp != null) {
    certificationEntity.whatsapp = whatsapp;
  }
  final String? wkAddr = jsonConvert.convert<String>(json['wk_addr']);
  if (wkAddr != null) {
    certificationEntity.wkAddr = wkAddr;
  }
  final String? wkPro = jsonConvert.convert<String>(json['wk_pro']);
  if (wkPro != null) {
    certificationEntity.wkPro = wkPro;
  }
  final String? wkCity = jsonConvert.convert<String>(json['wk_city']);
  if (wkCity != null) {
    certificationEntity.wkCity = wkCity;
  }
  final String? wkDistrict = jsonConvert.convert<String>(json['wk_district']);
  if (wkDistrict != null) {
    certificationEntity.wkDistrict = wkDistrict;
  }
  final String? workTimeLong = jsonConvert.convert<String>(json['work_time_long']);
  if (workTimeLong != null) {
    certificationEntity.workTimeLong = workTimeLong;
  }
  final String? industryType = jsonConvert.convert<String>(json['industryType']);
  if (industryType != null) {
    certificationEntity.industryType = industryType;
  }
  return certificationEntity;
}

Map<String, dynamic> $CertificationEntityToJson(CertificationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['branch'] = entity.branch;
  data['client_salary'] = entity.clientSalary;
  data['company_name'] = entity.companyName;
  data['email'] = entity.email;
  data['eschool'] = entity.eschool;
  data['fbk_name'] = entity.fbkName;
  data['gx_one'] = entity.gxOne;
  data['gx_phone'] = entity.gxPhone;
  data['gx_name'] = entity.gxName;
  data['gx_two'] = entity.gxTwo;
  data['gx_phone_two'] = entity.gxPhoneTwo;
  data['gx_name_two'] = entity.gxNameTwo;
  data['gx_three'] = entity.gxThree;
  data['gx_phone_three'] = entity.gxPhoneThree;
  data['gx_name_three'] = entity.gxNameThree;
  data['gx_four'] = entity.gxFour;
  data['gx_phone_four'] = entity.gxPhoneFour;
  data['gx_name_four'] = entity.gxNameFour;
  data['gx_five'] = entity.gxFive;
  data['gx_phone_five'] = entity.gxPhoneFive;
  data['gx_name_five'] = entity.gxNameFive;
  data['hbl'] = entity.hbl;
  data['kid_number'] = entity.kidNumber;
  data['lv_addr'] = entity.lvAddr;
  data['lv_city'] = entity.lvCity;
  data['lv_pro'] = entity.lvPro;
  data['lv_stre'] = entity.lvStre;
  data['merry_state'] = entity.merryState;
  data['pay_date_one'] = entity.payDateOne;
  data['pay_date_two'] = entity.payDateTwo;
  data['second_mobile'] = entity.secondMobile;
  data['usage_type'] = entity.usageType;
  data['whatsapp'] = entity.whatsapp;
  data['wk_addr'] = entity.wkAddr;
  data['wk_pro'] = entity.wkPro;
  data['wk_city'] = entity.wkCity;
  data['wk_district'] = entity.wkDistrict;
  data['work_time_long'] = entity.workTimeLong;
  data['industryType'] = entity.industryType;
  return data;
}

extension CertificationEntityExtension on CertificationEntity {
  CertificationEntity copyWith({
    String? branch,
    String? clientSalary,
    String? companyName,
    String? email,
    String? eschool,
    String? fbkName,
    String? gxOne,
    String? gxPhone,
    String? gxName,
    String? gxTwo,
    String? gxPhoneTwo,
    String? gxNameTwo,
    String? gxThree,
    String? gxPhoneThree,
    String? gxNameThree,
    String? gxFour,
    String? gxPhoneFour,
    String? gxNameFour,
    String? gxFive,
    String? gxPhoneFive,
    String? gxNameFive,
    String? hbl,
    String? kidNumber,
    String? lvAddr,
    String? lvCity,
    String? lvPro,
    String? lvStre,
    String? merryState,
    String? payDateOne,
    String? payDateTwo,
    String? secondMobile,
    String? usageType,
    String? whatsapp,
    String? wkAddr,
    String? wkPro,
    String? wkCity,
    String? wkDistrict,
    String? workTimeLong,
    String? industryType,
  }) {
    return CertificationEntity()
      ..branch = branch ?? this.branch
      ..clientSalary = clientSalary ?? this.clientSalary
      ..companyName = companyName ?? this.companyName
      ..email = email ?? this.email
      ..eschool = eschool ?? this.eschool
      ..fbkName = fbkName ?? this.fbkName
      ..gxOne = gxOne ?? this.gxOne
      ..gxPhone = gxPhone ?? this.gxPhone
      ..gxName = gxName ?? this.gxName
      ..gxTwo = gxTwo ?? this.gxTwo
      ..gxPhoneTwo = gxPhoneTwo ?? this.gxPhoneTwo
      ..gxNameTwo = gxNameTwo ?? this.gxNameTwo
      ..gxThree = gxThree ?? this.gxThree
      ..gxPhoneThree = gxPhoneThree ?? this.gxPhoneThree
      ..gxNameThree = gxNameThree ?? this.gxNameThree
      ..gxFour = gxFour ?? this.gxFour
      ..gxPhoneFour = gxPhoneFour ?? this.gxPhoneFour
      ..gxNameFour = gxNameFour ?? this.gxNameFour
      ..gxFive = gxFive ?? this.gxFive
      ..gxPhoneFive = gxPhoneFive ?? this.gxPhoneFive
      ..gxNameFive = gxNameFive ?? this.gxNameFive
      ..hbl = hbl ?? this.hbl
      ..kidNumber = kidNumber ?? this.kidNumber
      ..lvAddr = lvAddr ?? this.lvAddr
      ..lvCity = lvCity ?? this.lvCity
      ..lvPro = lvPro ?? this.lvPro
      ..lvStre = lvStre ?? this.lvStre
      ..merryState = merryState ?? this.merryState
      ..payDateOne = payDateOne ?? this.payDateOne
      ..payDateTwo = payDateTwo ?? this.payDateTwo
      ..secondMobile = secondMobile ?? this.secondMobile
      ..usageType = usageType ?? this.usageType
      ..whatsapp = whatsapp ?? this.whatsapp
      ..wkAddr = wkAddr ?? this.wkAddr
      ..wkPro = wkPro ?? this.wkPro
      ..wkCity = wkCity ?? this.wkCity
      ..wkDistrict = wkDistrict ?? this.wkDistrict
      ..workTimeLong = workTimeLong ?? this.workTimeLong
      ..industryType = industryType ?? this.industryType;
  }
}