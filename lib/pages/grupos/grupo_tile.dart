import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/grupo/grupo_page.dart';
import 'package:louvor_ics_patos/pages/selecionar_grupo/selecionar_grupo_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class GrupoTile extends StatelessWidget {
  Grupo grupo;
  bool selecionado;
  bool selecionarGrupo;

  GrupoTile(this.grupo,
      {this.selecionado = false, this.selecionarGrupo = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selecionarGrupo
          ? () =>
              SelecionarGrupoPageController.to.grupoSelecionado.value = grupo
          : () => Get.to(GrupoPage(grupo)),
      child: Container(
        color: selecionado ? Cores.primary : Colors.transparent,
        height: 100,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
              alignment: Alignment.topLeft,
              child: Text(
                grupo.nome,
                style: TextStyle(
                    color: selecionado ? Colors.white : Cores.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: getMembros(grupo),
            ),
          ],
        ),
      ),
    );
  }

  getMembros(Grupo grupo) {
    List<Widget> membrosWidgets = [];
    grupo.membrosReference.forEach(
      (membro) {
        membrosWidgets.add(
          StreamBuilder<DocumentSnapshot>(
            stream: membro.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Usuario membro = Usuario.fromSnapshot(snapshot.data);
                return Tooltip(
                  message: membro.nome,
                  child: Container(
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: membro.perfil != null && membro.perfil.isNotEmpty
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
                );
              }
              return Container();
            },
          ),
        );
      },
    );
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8),
      scrollDirection: Axis.horizontal,
      children: membrosWidgets,
    );
  }
}
