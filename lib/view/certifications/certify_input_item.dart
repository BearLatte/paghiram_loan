import 'package:flutter/material.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class CertifyInputItem extends StatelessWidget {
  final String title;
  final bool isEmpty;
  final TextEditingController? inputController;
  final FocusNode? inputNode;
  final TextInputType? keyboardType;
  final bool inputEnable;
  final void Function()? onEditingCompleted;
  final void Function(String text)? onChanged;

  const CertifyInputItem(
    this.title, {
    super.key,
    this.isEmpty = false,
    this.inputController,
    this.inputNode,
    this.keyboardType,
    this.onEditingCompleted,
    this.inputEnable = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: isEmpty ? Border.all(color: HexColor('#FFFF3232'), width: 0.5) : null),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: TextStyle(fontSize: 15, color: HexColor('#FF3B414B'))),
              SizedBox(height: 15),
              TextField(
                maxLines: 5,
                minLines: 1,
                enabled: inputEnable,
                controller: inputController,
                focusNode: inputNode,
                keyboardType: keyboardType,
                style: TextStyle(fontSize: 15, color: HexColor('#FF3B414B')),
                scrollPadding: EdgeInsets.zero,
                onEditingComplete: onEditingCompleted,
                onChanged: onChanged,
                decoration: InputDecoration(
                    hintText: 'Please fill in', border: InputBorder.none, hintStyle: TextStyle(color: HexColor('#ffcccccc')), contentPadding: EdgeInsets.all(0), isDense: true),
                textInputAction: TextInputAction.done,
              )
            ],
          )),
      if (isEmpty)
        Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 20),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: HexColor('#1AFF3232'), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Icon(Icons.error_outlined, color: HexColor('#FFFF3232'), size: 24),
                SizedBox(width: 8),
                Text('This field is required', style: TextStyle(fontSize: 13, color: HexColor('#FFFF3232')))
              ],
            ))
    ]);
  }
}
