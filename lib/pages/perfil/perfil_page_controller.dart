import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';

class PerfilPageController extends GetxController {
  Usuario usuario;
  File foto;
  final editar = false.obs;

  final tNome = TextEditingController(text: '');

  var instrumentosSelecionados = [].obs;

  static PerfilPageController get to => Get.find();

  @override
  void onInit() {}

  void changeFoto(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      foto = File(pickedFile.path);
    }
    update();
  }

  void salvarFoto() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref('perfil/${foto.path.split('/').last}')
        .putFile(foto);
    usuario.reference
        .update({'perfil': await taskSnapshot.ref.getDownloadURL()});
    limparFoto();
  }

  void limparFoto() {
    foto = null;
    update();
  }

  void salvar() async {
    if (tNome.text.isNotEmpty) {
      if (instrumentosSelecionados.length > 0) {
        usuario.reference.update(
            {'nome': tNome.text, 'instrumentos': instrumentosSelecionados});
        editar.value = false;
      } else {
        Get.snackbar(
          'Erro',
          'Selecione pelo menos 1 instrumento.',
          backgroundColor: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Erro',
        'O nome não pode está vazio.',
        backgroundColor: Colors.white,
      );
    }
  }
}
