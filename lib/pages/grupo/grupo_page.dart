import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_grupo/adicionar_editar_grupo_page.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';
import 'package:louvor_ics_patos/widgets/instrumento_chip.dart';

class GrupoPage extends StatelessWidget {
  Grupo grupo;

  GrupoPage(this.grupo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,

        title: Text(grupo.nome),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(LineIcons.verticalEllipsis),
              alignment: Alignment.center,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Editar',
                ),
                value: 'Editar',
              ),
              PopupMenuItem(
                child: Text(
                  'Excluir',
                ),
                value: 'Excluir',
              ),
            ],
            onSelected: (value) async {
              Get.focusScope.unfocus();

              if (value == 'Editar') {
                Get.to(
                  AdicionarEditarGrupoPage(
                    grupo: grupo,
                  ),
                );
              } else {
                var querySnapshot = await FirebaseFirestore.instance
                    .collection('eventos')
                    .where('grupoReference', isEqualTo: grupo.reference)
                    .get();
                if (querySnapshot.size > 0) {
                  Get.snackbar('Erro',
                      'Não é possível apagar esse: Há cultos no cronograma em que ele está vinculado.',
                      backgroundColor: Colors.red, colorText: Colors.white);
                } else {
                  AppDialog(Text('Deseja realmente deletar este grupo?'),
                      textCancel: 'Cancelar',
                      textConfirm: 'Deletar',
                      colorConfirm: Colors.red, onConfirm: () {
                    grupo.reference.delete();
                    Get.back();
                    Get.back();
                  }).show();
                }
              }
            },
          ),

        ],
      ),
      body: buildBody(),
    );
  }

  buildIntrumentos(Usuario membro) {
    List<Widget> instrumentoWidgets = [];

    membro.instrumentos.forEach(
      (instrumento) {
        instrumentoWidgets.add(InstrumentoChip(instrumento));
      },
    );
    return Container(
      margin: EdgeInsets.symmetric(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: 30,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: instrumentoWidgets,
        ),
      ),
    );
  }

  buildBody() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: grupo.membrosReference.length,
      itemBuilder: (BuildContext context, int index) =>
          StreamBuilder<DocumentSnapshot>(
        stream: grupo.membrosReference[index].snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Usuario membro = Usuario.fromSnapshot(snapshot.data);
            return Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              membro.perfil != null && membro.perfil.isNotEmpty
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        membro.perfil,
                                      ),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        'https://firebasestorage.googleapis.com/v0/b/louvor-ics-patos.appspot.com/o/perfil%2Faccount_circle.png?alt=media&token=99c64c4e-36c0-47a4-85ea-ebfcdae1e9e2',
                                      ),
                                    ),
                        ),
                      ),
                    ),
                    Container(
                      child: AutoSizeText(membro.nome),
                      margin: EdgeInsets.symmetric(vertical: 2),
                    ),
                    buildIntrumentos(membro)
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: EdgeInsets.all(8),
    );
  }
}
