import 'dart:convert';
import 'dart:io';

import 'package:paghiram_loan/util/constant.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {

  static Future saveFileToTempDirectory(String filename, String fileContent) async {
    var tempDir = await getApplicationCacheDirectory();
    File file = File('${tempDir.path}/$filename');
    return await file.writeAsString(fileContent);
  }

  static Future<String> getFileContentFromTempDirectory(String filename) async {
    var tempDir = await getApplicationCacheDirectory();
    File file = File('${tempDir.path}/$filename');
    bool isExists = await file.exists();
    return isExists ?  await file.readAsString() : '';
  }

  static Future saveFile(String fileName, String fileContent) async {
    File file = await _getFile(fileName);
    return await file.writeAsString(fileContent);
  }

  static Future<String> getContents(String fileName) async {
    File file = await _getFile(fileName);
    bool isExists = await file.exists();
    return isExists ?  await file.readAsString() : '';
  }

  static Future<File> _getFile(String fileName) async {
    var documentDir = await getApplicationDocumentsDirectory();
    return File('${documentDir.path}/$fileName');
  }
}