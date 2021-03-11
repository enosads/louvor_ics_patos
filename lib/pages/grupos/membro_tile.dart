import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_grupo/adicionar_editar_grupo_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/instrumento_chip.dart';

class MembroTile extends StatelessWidget {
  Usuario membro;
  bool selecionada;
  bool selecionarMembros;

  MembroTile(
    this.membro, {
    this.selecionada = false,
    this.selecionarMembros = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selecionarMembros
          ? () {
        print('tocou');
              if (AdicionarEditarGrupoPageController.to.membrosSelecionados
                  .contains(membro)) {
                AdicionarEditarGrupoPageController.to.membrosSelecionados
                    .remove(membro);
              } else {
                AdicionarEditarGrupoPageController.to.membrosSelecionados
                    .add(membro);
              }
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        color: selecionada ? Cores.primary : Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: Get.width * 0.2,
                height: Get.width * 0.2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      membro.nome,
                      style: TextStyle(
                        fontSize: 16,
                        color: selecionada ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildIntrumentos(membro),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: instrumentoWidgets,
      ),
    );
  }
}
