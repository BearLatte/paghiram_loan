import 'package:flutter/material.dart';
import 'package:paghiram_loan/common/common_image.dart';
import 'package:paghiram_loan/common/common_view.dart';
import 'package:paghiram_loan/util/hex_color.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonView(
        title: 'About us',
        child: Center(
          child: Column(children: [
            const SizedBox(height: 40),
            const CommonImage(src: 'asset/icons/about_us_logo.png'),
            const SizedBox(height: 12),
            const Text('Paghiram Loan', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
            _textContainer('OKLIK LENDING COMPANY INC.', topMargin: 30),
            _textContainer('CERTIFICATE OF AUTHORITY NO.2896'),
            _textContainer('NOYICE：Paghiram is owned and operated by OKLIKLENDING COMPANY INC.'),
            _textContainer('ADVISORY：All borrowers are enjoined to study the TEAMS&CONDITIONS in the Disclosure Statement Before Proceeding with the Load Transaction')
          ]),
        ));
  }

  Widget _textContainer(String text, {double topMargin = 0}) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: topMargin),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: HexColor('#FFE6E6E6')))),
        child: Text(text, style: const TextStyle(fontSize: 15)));
  }
}
