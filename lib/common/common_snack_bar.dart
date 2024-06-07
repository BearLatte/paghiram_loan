import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/util/constant.dart';

enum SnackType { info, error, success }

class CommonSnackBar {
  static SnackbarStatus _snackBarStatus = SnackbarStatus.CLOSED;

  static void showSnackBar(String? message, {String? title, SnackType type = SnackType.info}) {
    String snackBarTitle = title ?? (type == SnackType.info ? 'Info' : (type == SnackType.error ? 'Error' : 'Success'));
    IconData snackBarIcon = type == SnackType.info ? Icons.info_outline : (type == SnackType.error ? Icons.error_outline_outlined : Icons.check_outlined);
    Color iconColor = type == SnackType.info ? Colors.orangeAccent : (type == SnackType.error ? Colors.redAccent : Colors.lightGreenAccent);
    if (_snackBarStatus == SnackbarStatus.CLOSED) {
      Get.showSnackbar(GetSnackBar(
        snackbarStatus: (status) => _snackBarStatus = status!,
        barBlur: 10.0,
        borderRadius: 12,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        duration: const Duration(milliseconds: 1500),
        icon: Icon(snackBarIcon, color: iconColor, size: 40),
        titleText: Text(snackBarTitle, style: TextStyle(color: Constant.themeColor, fontSize: 20, fontWeight: FontWeight.bold)),
        messageText: Text(message ?? '', style: TextStyle(color: Constant.themeColor, fontSize: 16)),
        backgroundColor: Colors.black.withOpacity(0.7),
      ));
    }
  }
}
