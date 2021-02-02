import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/login/login_page.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page_controller.dart';
import 'package:louvor_ics_patos/services/firebase_service.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/instrumento_chip.dart';
import 'package:shimmer/shimmer.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilPageController>(
      init: PerfilPageController(),
      builder: (_) {
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Não foi possível buscar usuario'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            _.usuario = Usuario.fromSnapshot(snapshot.data);
            return Scaffold(
              appBar: buildAppBar(_),
              body: buildBody(_),
            );
          },
        );
      },
    );
  }

  AppBar buildAppBar(PerfilPageController _) {
    return AppBar(
      title: Text('Perfil'),
      centerTitle: true,
      actions: [
        Obx(
          () => IconButton(
            icon: Icon(_.editar.value
                ? LineAwesomeIcons.check
                : LineAwesomeIcons.edit),
            onPressed: () {

              if (!_.editar.value) {
                _.editar.value = true;
                _.tNome.text = _.usuario.nome;
                _.instrumentosSelecionados = [].obs;
                _.usuario.instrumentos.forEach(
                  (instrumento) => _.instrumentosSelecionados.add(instrumento),
                );
              } else {
                _.salvar();
              }
            },
          ),
        ),
      ],
    );
  }

  buildBody(PerfilPageController _) {
    return ListView(
      children: [
        buildFoto(_),
        Stack(
          children: [
            Column(
              children: [
                Obx(
                  () {
                    return _.editar.value
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                right: Get.width * 0.25,
                                left: Get.width * 0.25,
                                bottom: 8),
                            child: TextFormField(
                              controller: _.tNome,
                              textAlign: TextAlign.center,
                              cursorColor: Cores.accent,
                              decoration: InputDecoration(
                                hintText: "Digite seu nome",
                              ),
                            ),
                          )
                        : AutoSizeText(
                            _.usuario.nome,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                            maxLines: 1,
                          );
                  },
                ),
                AutoSizeText(
                  FirebaseAuth.instance.currentUser.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  maxLines: 1,
                ),
                Obx(() => buildIntrumentos(_))
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              'SAIR',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              FirebaseService.logout();
              Get.offAll(LoginPage());
            },
          ),
        )
      ],
    );
  }

  Center buildFoto(PerfilPageController _) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        height: 200,
        width: 200,
        child: Stack(
          children: [
            _.foto != null
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_.foto),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle),
                  )
                : _.usuario.perfil.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: _.usuario.perfil,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _.foto != null
                                    ? FileImage(_.foto)
                                    : imageProvider,
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            child: Icon(
                              Icons.account_circle,
                              size: 216,
                              color: Colors.grey,
                            ),
                          ),
                          period: Duration(seconds: 3),
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey[100],
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Icon(
                            Icons.account_circle,
                            size: 216,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 216,
                          color: Colors.grey,
                        ),
                      ),
            Obx(() => _.editar.value
                ? Container(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => _.foto != null
                          ? _.salvarFoto()
                          : Get.defaultDialog(
                              title: 'Alterar foto',
                              content: Container(
                                alignment: Alignment.center,
                                width: Get.width,
                                height: 112,
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: ListTile(
                                        title: AutoSizeText(
                                          'Câmera',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        leading:
                                            Icon(Icons.camera_alt_outlined),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        _.changeFoto(ImageSource.camera);
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        _.changeFoto(ImageSource.gallery);
                                      },
                                      child: ListTile(
                                        title: Text(
                                          'Galeria',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        leading:
                                            Icon(Icons.photo_library_outlined),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      child: Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Cores.accent,
                        ),
                        child: Icon(
                          _.foto != null
                              ? LineAwesomeIcons.check
                              : LineAwesomeIcons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container()),
            if (_.foto != null)
              GestureDetector(
                onTap: () => _.limparFoto(),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(
                    LineAwesomeIcons.times,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  buildIntrumentos(PerfilPageController _) {
    List<Widget> instrumentoWidgets = [];
    _.usuario.instrumentos.forEach(
      (instrumento) {
        if (!_.editar.value) {
          instrumentoWidgets.add(InstrumentoChip(instrumento));
        }
      },
    );
    if (_.editar.value) {
      instrumentoWidgets.addAll(
        [
          InstrumentoChip(
            'Violão',
            selecionar: true,
            selecionado: _.instrumentosSelecionados.contains('Violão'),
          ),
          InstrumentoChip(
            'Teclado',
            selecionar: true,
            selecionado: _.instrumentosSelecionados.contains('Teclado'),
          ),
          InstrumentoChip(
            'Contrabaixo',
            selecionar: true,
            selecionado: _.instrumentosSelecionados.contains('Contrabaixo'),
          ),
          InstrumentoChip(
            'Vocal',
            selecionar: true,
            selecionado: _.instrumentosSelecionados.contains('Vocal'),
          ),
          InstrumentoChip(
            'Projetor',
            selecionar: true,
            selecionado: _.instrumentosSelecionados.contains('Projetor'),
          )
        ],
      );
    }
    return _.editar.value
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Wrap(
              children: instrumentoWidgets,
            ),
          )
        : Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Wrap(
              children: instrumentoWidgets,
            ),
          );
  }
}
