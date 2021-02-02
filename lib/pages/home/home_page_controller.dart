
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/cronograma/cronograma_page.dart';
import 'package:louvor_ics_patos/pages/louvores/louvores_page.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page.dart';

class HomePageController extends GetxController {
  final showUserDetails = false.obs;

  static HomePageController get to => Get.find();

  final currentIndex = 0.obs;
  List<Widget> pages;



  @override
  void onInit() {

    pages = [
      CronogramaPage(),
      LouvoresPage(),
      PerfilPage()
    ];
  }
}
