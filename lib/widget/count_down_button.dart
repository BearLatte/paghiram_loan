import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paghiram_loan/util/global.dart';

class CountDownButton extends StatefulWidget {
  final int countDownValue;
  final String session;
  final String? text;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? cornerRadius;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final EdgeInsetsGeometry? margin;
  final Function(CountDownButtonState state)? onTap;

  const CountDownButton({
    super.key,
    required this.countDownValue,
    required this.session,
    this.onTap,
    this.text,
    this.width,
    this.height,
    this.backgroundColor,
    this.cornerRadius,
    this.textStyle,
    this.disabledBackgroundColor,
    this.disabledTextStyle,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() => CountDownButtonState();
}

class CountDownButtonState extends State<CountDownButton> {
  // final String boolSuffix = 'BOOL';
  // final String intSuffix = 'INT';

  late String _text;
  bool _disabled = false;
  Timer? timer;
  int? _startTimeStamp;
  bool? _isStart;

  @override
  void initState() {
    super.initState();
    _text = widget.text ?? 'Send';
    // _isStart = Global.prefs?.getBool(widget.session + boolSuffix) ?? false;
    // int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    // int startTimeStamp = Global.prefs?.getInt(widget.session + intSuffix) ?? 0;
    // if (startTimeStamp != 0 && (currentTimeStamp - startTimeStamp) / 1000 <= widget.countDownValue && (_isStart ?? false)) {
    //   startTimer();
    // }
  }

  void startTimer() {
    int count = 0;
    // int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    // // int startTimeStamp = Global.prefs?.getInt(widget.session + intSuffix) ?? 0;
    // if (startTimeStamp == 0 || (currentTimeStamp - startTimeStamp) / 1000 > widget.countDownValue) {
    //   _startTimeStamp = currentTimeStamp;
    // } else {
    //   count = (currentTimeStamp - startTimeStamp) ~/ 1000;
    //   _startTimeStamp = startTimeStamp;
    // }

    const period = Duration(seconds: 1);
    timer = Timer.periodic(period, (timer) {
      count++;
      num max = widget.countDownValue;

      if (widget.countDownValue == 0 || count >= max) {
        timer.cancel();
        _isStart = false;
        // Global.prefs?.setBool(widget.session + boolSuffix, false);
        // Global.prefs?.setInt(widget.session + intSuffix, 0);
        setState(() {
          _text = widget.text ?? 'Send';
          _disabled = false;
        });
      } else {
        _isStart = true;
        setState(() {
          _text = '${widget.countDownValue - count}S';
          _disabled = true;
        });
      }
    });
  }

  void stopCountDown() {
    timer?.cancel();
    _isStart = false;
    // Global.prefs?.setBool(widget.session + boolSuffix, false);
    // Global.prefs?.setInt(widget.session + intSuffix, 0);
    setState(() {
      _text = widget.text ?? 'Send';
      _disabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onTap != null && !_disabled) {
            widget.onTap!(this);
          }
        },
        child: Container(
          margin: widget.margin,
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _disabled ? (widget.disabledBackgroundColor ?? Colors.grey) : (widget.backgroundColor ?? Colors.orangeAccent),
              borderRadius: BorderRadius.circular(widget.cornerRadius ?? 0)),
          child: Text(_text, style: _disabled ? widget.disabledTextStyle : widget.textStyle),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    // Global.prefs?.setBool(widget.session + boolSuffix, _isStart ?? false);
    // Global.prefs?.setInt(widget.session + intSuffix, _startTimeStamp ?? 0);
  }
}
