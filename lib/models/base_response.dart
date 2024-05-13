import 'package:paghiram_loan/generated/json/base/json_convert_content.dart';
import 'package:paghiram_loan/generated/json/base/json_field.dart';

class BaseResponse<T> {
  int? code;
  int? status;
  String? error;
  int? updateState;
  int? appVersion;
  int? iUpdateState;
  int? iAppVersion;
  int? mailList;
  String? serviceOne;
  String? serviceTwo;
  String? updateAddr;
  int? smsCheck;
  T? data;
  String? originalData;

  BaseResponse(
      {required this.code,
      required this.error,
      this.data,
      this.updateState,
      this.appVersion,
      this.iUpdateState,
      this.iAppVersion,
      this.mailList,
      this.serviceOne,
      this.serviceTwo,
      this.updateAddr,
      this.smsCheck});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    code = json['code'] == null ? null : (json['code'] is int ? json['code'] : int.parse(json['code']));
    error = json['error'];
    updateState = json['update_state'];
    appVersion = json['app_version'];
    iUpdateState = json['i_update_state'];
    iAppVersion = json['i_app_version'];
    mailList = json['mail_list'];
    serviceOne = json['service_one'];
    serviceTwo = json['service_two'];
    updateAddr = json['update_addr'];
    smsCheck = json['sms_check'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = this.code;
    data['error'] = this.error;
    return data;
  }
}
