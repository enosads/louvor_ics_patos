import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/cronograma/cronograma_page.dart';
import 'package:louvor_ics_patos/pages/grupos/grupos_page.dart';
import 'package:louvor_ics_patos/pages/louvores/louvores_page.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page.dart';

class HomePageController extends GetxController {
  final showUserDetails = false.obs;

  HomePageController(int index) {
    this.currentIndex = index.obs;
  }

  static HomePageController get to => Get.find();

  var currentIndex;
  List<Widget> pages;

  @override
  void onInit() {
    pages = [
      CronogramaPage(),
      LouvoresPage(),
      GruposPage(),
      PerfilPage(),
    ];
  }
}
