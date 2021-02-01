import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';

class AdicionarEditarLouvorPageController extends GetxController {
  Louvor louvor;

  final formKey = GlobalKey<FormState>();

  AdicionarEditarLouvorPageController({this.louvor});

  final status = 'Futuro'.obs;

  final tTitulo = TextEditingController(text: '');
  final tCantor = TextEditingController(text: '');
  final tYouTube = TextEditingController(text: '');
  final tCifra = TextEditingController(text: '');

  static AdicionarEditarLouvorPageController get to => Get.find();
  final tom = ''.obs;

  @override
  void onInit() {
    if (louvor != null) {
      status.value = louvor.status;
      tTitulo.text = louvor.titulo;
      tCantor.text = louvor.cantor;
      tYouTube.text = louvor.youtube;
      tCifra.text = louvor.cifra;
      tom.value = louvor.tom;
    }
  }

  onClickSalvar() {
    if (formKey.currentState.validate()) {
      if (louvor == null) {
        FirebaseFirestore.instance.collection('louvores').doc().set(Louvor(
                youtube: tYouTube.text,
                titulo: tTitulo.text,
                cantor: tCantor.text,
                cifra: tCifra.text,
                status: status.value,
                tom: tom.value)
            .toMap());
      } else {
        louvor.reference.update(Louvor(
                youtube: tYouTube.text,
                titulo: tTitulo.text,
                cantor: tCantor.text,
                cifra: tCifra.text,
                status: status.value,
                tom: tom.value)
            .toMap());
      }
      Get.back();
    }
  }

  onClickDeletar() {
    louvor.reference.delete();
    Get.back();
    Get.back();
  }

  String validatorYoutube(String value) {
    if (!value.isBlank && !Uri.parse(value.trim()).isAbsolute) {
      return 'O link é inválido';
    }
  }

  String validatorCifra(String value) {
    if (!value.isBlank && !Uri.parse(value.trim()).isAbsolute) {
      return 'O link é inválido';
    }
  }

  String validatorTitulo(String value) {
    if (value.isBlank) {
      return 'Este campo é obrigatório';
    }
  }
}
