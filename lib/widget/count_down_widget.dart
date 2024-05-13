import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/file_manager.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CountDownWidget extends StatefulWidget {
  final int countTime;
  final Function()? countDownFinishedCallback;

  const CountDownWidget({super.key, this.countTime = 0, this.countDownFinishedCallback});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late int _countDownTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _countDownTime = widget.countTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countDownTime--;
        _saveTimeCount();
        if (_countDownTime == 0) {
          _timer.cancel();
          if (widget.countDownFinishedCallback != null) widget.countDownFinishedCallback!();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _countDownTime == 0
        ? _createWaitButton()
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _createBox((_countDownTime / 60 ~/ 60).toString().padLeft(2, '0')),
              _createDoubleDot(),
              _createBox((_countDownTime ~/ 60).toString().padLeft(2, '0')),
              _createDoubleDot(),
              _createBox((_countDownTime % 60 % 60).toString().padLeft(2, '0')),
            ]));
  }

  Widget _createWaitButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 9),
      // decoration: BoxDecoration(color: HexColor('#1AFFA940'), borderRadius: BorderRadius.circular(6)),
      child: Text('Please wait', style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 15)),
    );
  }

  Widget _createDoubleDot() {
    return SizedBox(
      width: 22,
      child: Column(
        children: [
          Container(width: 6, height: 6, margin: const EdgeInsets.only(bottom: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: HexColor('#FFEBF8F9'))),
          Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: HexColor('#FFEBF8F9')))
        ],
      ),
    );
  }

  Container _createBox(String number) {
    return Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: HexColor('#FFE0F5F6'), borderRadius: BorderRadius.circular(8)),
        child: Text(number, style: TextStyle(color: Constant.themeColor, fontSize: 16, fontWeight: FontWeight.bold)));
  }

  void _saveTimeCount() {
    String? phoneNum = Global.prefs?.getString(Constant.PHONE_NUMBER_FLAG);
    if (phoneNum == null) return;
    Global.prefs?.setInt(phoneNum, _countDownTime);
  }
}
