import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:flutter/material.dart';

class SelecionarLouvoresPageController extends GetxController {
  static SelecionarLouvoresPageController get to => Get.find();

  var louvoresSelecionados = <Louvor>[].obs;
  Evento evento;

  final tBusca = TextEditingController();

  final busca = ''.obs;

  var scrollController = ScrollController();

  SelecionarLouvoresPageController(this.evento);

  @override
  void onInit() {
    if (evento != null) {
      scrollController.addListener(() {
        Get.focusScope.unfocus();
      });
      fetchLouvores();
    }
  }

  Future<void> fetchLouvores() async {
    louvoresSelecionados.addAll(await evento.getLouvores());

  }
}
