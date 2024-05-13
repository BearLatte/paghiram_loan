import 'package:paghiram_loan/generated/json/base/json_field.dart';
import 'package:paghiram_loan/generated/json/certify_selection_data_entity.g.dart';
import 'dart:convert';
export 'package:paghiram_loan/generated/json/certify_selection_data_entity.g.dart';

@JsonSerializable()
class CertifySelectionDataEntity {
	late List<CertifySelectionDataEschool> eschool;
	@JSONField(name: "merry_state")
	late List<CertifySelectionDataMerryState> merryState;
	@JSONField(name: "kid_number")
	late List<CertifySelectionDataKidNumber> kidNumber;
	@JSONField(name: "liv_time")
	late List<CertifySelectionDataLivTime> livTime;
	@JSONField(name: "my_work")
	late List<CertifySelectionDataMyWork> myWork;
	@JSONField(name: "user_work")
	late List<CertifySelectionDataUserWork> userWork;
	@JSONField(name: "my_salary")
	late List<CertifySelectionDataMySalary> mySalary;
	@JSONField(name: "user_religion")
	late List<CertifySelectionDataUserReligion> userReligion;
	late List<CertifySelectionDataBranch> branch;
	@JSONField(name: "lvl_time")
	late List<CertifySelectionDataLvlTime> lvlTime;
	late List<CertifySelectionDataFr> fr;
	late List<CertifySelectionDataCtype> ctype;
	@JSONField(name: "loan_pur")
	late List<CertifySelectionDataLoanPur> loanPur;
	late List<CertifySelectionDataUbll> ubll;
	late List<CertifySelectionDataIto> ito;
	late CertifySelectionDataRelist relist;

	CertifySelectionDataEntity();

	factory CertifySelectionDataEntity.fromJson(Map<String, dynamic> json) => $CertifySelectionDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataEschool {
	late String id;
	late String title;

	CertifySelectionDataEschool();

	factory CertifySelectionDataEschool.fromJson(Map<String, dynamic> json) => $CertifySelectionDataEschoolFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataEschoolToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataMerryState {
	late String id;
	late String title;

	CertifySelectionDataMerryState();

	factory CertifySelectionDataMerryState.fromJson(Map<String, dynamic> json) => $CertifySelectionDataMerryStateFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataMerryStateToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataKidNumber {
	late String id;
	late String title;

	CertifySelectionDataKidNumber();

	factory CertifySelectionDataKidNumber.fromJson(Map<String, dynamic> json) => $CertifySelectionDataKidNumberFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataKidNumberToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataLivTime {
	late String id;
	late String title;

	CertifySelectionDataLivTime();

	factory CertifySelectionDataLivTime.fromJson(Map<String, dynamic> json) => $CertifySelectionDataLivTimeFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataLivTimeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataMyWork {
	late String id;
	late String title;

	CertifySelectionDataMyWork();

	factory CertifySelectionDataMyWork.fromJson(Map<String, dynamic> json) => $CertifySelectionDataMyWorkFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataMyWorkToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataUserWork {
	late String id;
	late String title;

	CertifySelectionDataUserWork();

	factory CertifySelectionDataUserWork.fromJson(Map<String, dynamic> json) => $CertifySelectionDataUserWorkFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataUserWorkToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataMySalary {
	late String id;
	late String title;

	CertifySelectionDataMySalary();

	factory CertifySelectionDataMySalary.fromJson(Map<String, dynamic> json) => $CertifySelectionDataMySalaryFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataMySalaryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataUserReligion {
	late String id;
	late String title;

	CertifySelectionDataUserReligion();

	factory CertifySelectionDataUserReligion.fromJson(Map<String, dynamic> json) => $CertifySelectionDataUserReligionFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataUserReligionToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataBranch {
	late String id;
	late String type;
	late String title;

	CertifySelectionDataBranch();

	factory CertifySelectionDataBranch.fromJson(Map<String, dynamic> json) => $CertifySelectionDataBranchFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataBranchToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataLvlTime {
	late String id;
	late String title;

	CertifySelectionDataLvlTime();

	factory CertifySelectionDataLvlTime.fromJson(Map<String, dynamic> json) => $CertifySelectionDataLvlTimeFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataLvlTimeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataFr {
	late String id;
	late String title;

	CertifySelectionDataFr();

	factory CertifySelectionDataFr.fromJson(Map<String, dynamic> json) => $CertifySelectionDataFrFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataFrToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataCtype {
	late String id;
	late String title;

	CertifySelectionDataCtype();

	factory CertifySelectionDataCtype.fromJson(Map<String, dynamic> json) => $CertifySelectionDataCtypeFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataCtypeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataLoanPur {
	late String id;
	late String title;

	CertifySelectionDataLoanPur();

	factory CertifySelectionDataLoanPur.fromJson(Map<String, dynamic> json) => $CertifySelectionDataLoanPurFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataLoanPurToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataUbll {
	late String id;
	late String title;

	CertifySelectionDataUbll();

	factory CertifySelectionDataUbll.fromJson(Map<String, dynamic> json) => $CertifySelectionDataUbllFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataUbllToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataIto {
	late String id;
	late String title;

	CertifySelectionDataIto();

	factory CertifySelectionDataIto.fromJson(Map<String, dynamic> json) => $CertifySelectionDataItoFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataItoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CertifySelectionDataRelist {
	late List<String> t1;
	late List<String> t2;
	late List<String> t3;

	CertifySelectionDataRelist();

	factory CertifySelectionDataRelist.fromJson(Map<String, dynamic> json) => $CertifySelectionDataRelistFromJson(json);

	Map<String, dynamic> toJson() => $CertifySelectionDataRelistToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}