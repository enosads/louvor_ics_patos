import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/splash/splash_page.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

void main() {
  runApp(
    GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Cores.primary,
          primaryColor: Cores.primary),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: SplashPage(),
    ),
  );
}
