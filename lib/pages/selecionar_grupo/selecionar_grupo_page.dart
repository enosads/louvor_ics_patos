import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/pages/grupos/grupo_tile.dart';
import 'package:louvor_ics_patos/pages/selecionar_grupo/selecionar_grupo_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class SelecionarGrupoPage extends StatelessWidget {
  Evento evento;

  SelecionarGrupoPage(this.evento);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelecionarGrupoPageController(evento),
      builder: (
        SelecionarGrupoPageController _,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Cores.primary,
              ),
              onPressed: () => Get.back(),
            ),
            brightness: Brightness.light,
            title: Text(
              'Selecione um grupo',
              style: TextStyle(color: Cores.primary),
            ),
            centerTitle: true,
          ),
          body: buildBody(_),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _.onClickSalvarCulto(),
            child: Icon(LineIcons.check),
            backgroundColor: Cores.primary,
          ),
        );
      },
    );
  }

  buildBody(SelecionarGrupoPageController _) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('grupos').snapshots(),
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
        _.grupos = snapshot.data.docs
            .map((DocumentSnapshot document) {
              return Grupo.fromSnapshot(document);
            })
            .toList()
            .obs;
        _.grupoSelecionado.value = _.grupos.first;
        return getListViewGrupos(_);
      },
    );
  }

  getListViewGrupos(SelecionarGrupoPageController _) {
    if (_.grupos.isEmpty) {
      return Center(
        child: AutoSizeText('Ainda não há nenhum grupo criado.'),
      );
    }
    return ListView.builder(
      itemCount: _.grupos.length,
      itemBuilder: (context, index) {
        Grupo grupo = _.grupos[index];
        return Obx(
          () => GrupoTile(
            grupo,
            selecionarGrupo: true,
            selecionado: _.grupoSelecionado.value == grupo,
          ),
        );
      },
    );
  }
}
