import 'package:flutter/material.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class SelectDayWidget extends StatefulWidget {
  final void Function(int? selectedDay)? itemOnTap;

  const SelectDayWidget({super.key, this.itemOnTap});

  @override
  State<SelectDayWidget> createState() => _SelectDayWidgetState();
}

class _SelectDayWidgetState extends State<SelectDayWidget> {
  int? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 60) / 7;
    final itemHeight = itemWidth;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Wrap(
          children: List.generate(
              31,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedDay = index;
                      });
                      if (widget.itemOnTap != null) {
                        widget.itemOnTap!(_selectedDay);
                      }
                    },
                    child: Container(
                      width: itemWidth,
                      height: itemHeight,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: index == _selectedDay ? Constant.themeColor : null,
                          border: Border(
                              top: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5),
                              right: BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5),
                              left: index % 7 == 0 ? BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5) : BorderSide.none,
                              bottom: index > 23 ? BorderSide(color: HexColor('#FFCCCCCC'), width: 0.5) : BorderSide.none)),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: index == _selectedDay ? Colors.white : HexColor('#FF3B414B'), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ))),
    );
  }
}
