import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/splash/splash_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashPageController(),
      builder: (SplashPageController _) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 120.0,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
