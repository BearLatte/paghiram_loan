import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:paghiram_loan/util/constant.dart';
import 'package:paghiram_loan/router/application_pages.dart';
import 'package:paghiram_loan/util/global.dart';


class Application extends StatelessWidget {
  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ApplicationPages.initial,
      defaultTransition: Transition.noTransition,
      getPages: ApplicationPages.routes,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Constant.themeColor),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      ),
      onInit: () async {
        await Global.initGlobal();
      },
      builder: EasyLoading.init(),
    );
  }
}
