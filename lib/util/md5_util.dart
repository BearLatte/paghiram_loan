import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class MD5Util {
  static String md5Encode(String text) {
    Uint8List content = Utf8Encoder().convert(text);
    Digest digest = md5.convert(content);
    return digest.toString();
  }
}