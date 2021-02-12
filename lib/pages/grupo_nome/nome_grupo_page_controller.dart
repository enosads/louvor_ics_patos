import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_grupo/adicionar_editar_grupo_page_controller.dart';
import 'package:louvor_ics_patos/pages/home/home_page.dart';

class NomeGrupoPageController extends GetxController {
  final form = GlobalKey<FormState>();

  final tNome = TextEditingController(text: '');

  Grupo grupo;

  NomeGrupoPageController(this.grupo);

  @override
  void onInit() {
    if (grupo != null) {
      tNome.text = grupo.nome;
    }
  }

  static NomeGrupoPageController get to => Get.find();

  String validatorNome(String value) {
    if (value.isEmpty)
      return 'Esse campo deve ser preenchido';
    else
      return null;
  }

  salvaGrupo() async {
    if (form.currentState.validate()) {
      if (grupo == null) {
        print(AdicionarEditarGrupoPageController.to.membrosSelecionados);
        print(AdicionarEditarGrupoPageController.to.membrosSelecionados
            .map((element) => element.reference)
            .toList());
        FirebaseFirestore.instance.collection('grupos').doc().set(Grupo(
                tNome.text,
                AdicionarEditarGrupoPageController.to.membrosSelecionados
                    .map((element) => element.reference)
                    .toList())
            .toMap());
      } else {
        grupo.reference.update(Grupo(
                tNome.text,
                AdicionarEditarGrupoPageController.to.membrosSelecionados
                    .map((element) => element.reference)
                    .toList())
            .toMap());
      }
      Get.offAll(HomePage(index: 2,));
    }
  }
}
