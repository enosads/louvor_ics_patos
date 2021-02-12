import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_grupo/adicionar_editar_grupo_page_controller.dart';
import 'package:louvor_ics_patos/pages/grupo_nome/nome_grupo_page.dart';
import 'package:louvor_ics_patos/pages/grupos/membro_tile.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class AdicionarEditarGrupoPage extends StatelessWidget {
  Grupo grupo;

  AdicionarEditarGrupoPage({this.grupo});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdicionarEditarGrupoPageController(grupo),
      builder: (AdicionarEditarGrupoPageController _) {
        return Scaffold(
          appBar: buildAppBar(_),
          body: buildBody(_),
          floatingActionButton: buildFloatingActionButton(_),
        );
      },
    );
  }

  AppBar buildAppBar(AdicionarEditarGrupoPageController _) {
    return AppBar(
      title: Text('Selecione os membros'),
      centerTitle: true,
    );
  }

  buildBody(AdicionarEditarGrupoPageController _) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .orderBy(
            'nome',
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Não foi possível buscar grupos.'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _.membros = snapshot.data.docs
            .map((DocumentSnapshot document) => Usuario.fromSnapshot(document))
            .toList()
            .obs;
        _.fetchMembros();
        return geMembrosListView(_);
      },
    );
  }

  geMembrosListView(AdicionarEditarGrupoPageController _) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 96),
      itemBuilder: (context, index) {
        return Obx(
          () => MembroTile(
            _.membros[index],
            selecionada:
                _.verificarMembro(_.membros[index], _.membrosSelecionados),
            selecionarMembros: true,
          ),
        );
      },
      itemCount: _.membros.length,
    );
  }

  FloatingActionButton buildFloatingActionButton(
      AdicionarEditarGrupoPageController _) {
    return FloatingActionButton(
      backgroundColor: Cores.accent,
      onPressed: () {
        if (_.membrosSelecionados.isEmpty) {
          Get.snackbar(
            'Erro',
            'Selecione pelo menos um membro para continuar',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.to(NomeGrupoPage(
            grupo,
          ));
        }
      },
      child: Icon(LineAwesomeIcons.arrow_right),
    );
  }
}
