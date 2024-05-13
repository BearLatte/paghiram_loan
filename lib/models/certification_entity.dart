import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/certification_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/certification_entity.g.dart';

@JsonSerializable()
class CertificationEntity {
	String? branch;
	@JSONField(name: "client_salary")
	String? clientSalary;
	@JSONField(name: "company_name")
	String? companyName;
	String? email;
	String? eschool;
	@JSONField(name: "fbk_name")
	String? fbkName;
	@JSONField(name: "gx_one")
	String? gxOne;
	@JSONField(name: "gx_phone")
	String? gxPhone;
	@JSONField(name: "gx_name")
	String? gxName;
	@JSONField(name: "gx_two")
	String? gxTwo;
	@JSONField(name: "gx_phone_two")
	String? gxPhoneTwo;
	@JSONField(name: "gx_name_two")
	String? gxNameTwo;
	@JSONField(name: "gx_three")
	String? gxThree;
	@JSONField(name: "gx_phone_three")
	String? gxPhoneThree;
	@JSONField(name: "gx_name_three")
	String? gxNameThree;
	@JSONField(name: "gx_four")
	String? gxFour;
	@JSONField(name: "gx_phone_four")
	String? gxPhoneFour;
	@JSONField(name: "gx_name_four")
	String? gxNameFour;
	@JSONField(name: "gx_five")
	String? gxFive;
	@JSONField(name: "gx_phone_five")
	String? gxPhoneFive;
	@JSONField(name: "gx_name_five")
	String? gxNameFive;
	String? hbl;
	@JSONField(name: "kid_number")
	String? kidNumber;
	@JSONField(name: "lv_addr")
	String? lvAddr;
	@JSONField(name: "lv_city")
	String? lvCity;
	@JSONField(name: "lv_pro")
	String? lvPro;
	@JSONField(name: "lv_stre")
	String? lvStre;
	@JSONField(name: "merry_state")
	String? merryState;
	@JSONField(name: "pay_date_one")
	String? payDateOne;
	@JSONField(name: "pay_date_two")
	String? payDateTwo;
	@JSONField(name: "second_mobile")
	String? secondMobile;
	@JSONField(name: "usage_type")
	String? usageType;
	String? whatsapp;
	@JSONField(name: "wk_addr")
	String? wkAddr;
	@JSONField(name: "wk_pro")
	String? wkPro;
	@JSONField(name: "wk_city")
	String? wkCity;
	@JSONField(name: "wk_district")
	String? wkDistrict;
	@JSONField(name: "work_time_long")
	String? workTimeLong;
	String? industryType;

	CertificationEntity();

	factory CertificationEntity.fromJson(Map<String, dynamic> json) => $CertificationEntityFromJson(json);

	Map<String, dynamic> toJson() => $CertificationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}