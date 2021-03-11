import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/pages/grupo_nome/nome_grupo_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_text.dart';

class NomeGrupoPage extends StatelessWidget {
  Grupo grupo;

  NomeGrupoPage(this.grupo);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NomeGrupoPageController(grupo),
      builder: (
        NomeGrupoPageController _,
      ) {
        return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,

            title: Text(
                grupo == null ? 'Nome do grupo' : 'Altere o nome do grupo'),
            centerTitle: true,
          ),
          body: _body(_),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _.salvaGrupo(),
            child: Icon(LineIcons.check),
            backgroundColor: Cores.primary,
          ),
        );
      },
    );
  }

  _body(NomeGrupoPageController _) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Form(
            key: _.form,
            child: Row(
              children: [
                Icon(
                  LineIcons.font,
                  color: Cores.primary,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AppText(
                    label: "Nome",
                    controller: _.tNome,
                    validator: _.validatorNome,
                    autofocus: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
