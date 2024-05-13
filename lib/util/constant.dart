import 'dart:ui';
import 'package:paghiram_loan/util/hex_color.dart';

class Constant {
  static Color themeColor = HexColor('#FF00A9B8');
  static const LOGIN_FLAG = 'Login_Flag';
  static const TOKEN_FLAG = 'Access_Token';
  static const PHONE_NUMBER_FLAG = 'Logged_in_number';
  static const CERTIFICATION_OPTIONAL_CONTENT = 'VERIFY_OPTIONAL_CONTENT';
  static const PENDING_STATE_COUNTDOWN_TIME_KEY = 'kPENDING_STATE_COUNTDOWN_TIME_KEY';

  // about aliyun
  static const LIVENESS_IMG_NAME_KEY = 'LIVENESS_IMG';
  static const BUCKET_NAME = 'paghiram';
  static const ALIYUN_ENDPOINT = 'oss-ap-southeast-1.aliyuncs.com';

  // about customer services
  static const SERVICE_PHONE_NUMBER_ONE = 'kSERVICE_PHONE_NUMBER_ONE';
  static const SERVICE_PHONE_NUMBER_TWO = 'kSERVICE_PHONE_NUMBER_TWO';
}
