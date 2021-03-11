import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_grupo/adicionar_editar_grupo_page.dart';
import 'package:louvor_ics_patos/pages/grupos/grupo_tile.dart';
import 'package:louvor_ics_patos/pages/grupos/grupos_page_controller.dart';
import 'package:louvor_ics_patos/pages/grupos/membro_tile.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class GruposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope.unfocus(),
      child: GetBuilder(
        init: GruposPageController(),
        builder: (GruposPageController _) {
          return Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,

              automaticallyImplyLeading: false,
              title: Text('Grupos'),
              centerTitle: true,
            ),
            body: _body(_),
            // drawer: AppDrawerList(),
            floatingActionButton: _fab(_),
          );
        },
      ),
    );
  }

  _body(GruposPageController _) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('grupos')
          .orderBy('nome', descending: false)
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
        _.grupos = snapshot.data.docs
            .map(
              (DocumentSnapshot document) => Grupo.fromSnapshot(document),
            )
            .toList()
            .obs;
        _.getMembros();
        return getGruposListView(_);
      },
    );
  }

  getGruposListView(
    GruposPageController _,
  ) {
    if (_.grupos.isEmpty) {
      return Center(child: Text('Nenhum grupo cadastrado'));
    }

    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.only(bottom: 64),
        itemBuilder: (context, index) {
          return GrupoTile(_.grupos[index]);
        },
        itemCount: _.grupos.length,
      ),
    );
  }

  _fab(GruposPageController _) {
    return FloatingActionButton(
      heroTag: 'grupos_fab',
      onPressed: () {
        Get.focusScope.unfocus();

        Get.to(AdicionarEditarGrupoPage());
      },
      child: Icon(LineIcons.plus),
      backgroundColor: Cores.primary,
    );
  }

  getMembroTiles(Grupo grupo) {
    List<Widget> widgets = [];
    grupo.membros.forEach(
      (membro) {
        widgets.add(
          MembroTile(membro),
        );
      },
    );
    return Column(
      children: widgets,
    );
  }
}
