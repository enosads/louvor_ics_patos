import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/louvores/louvor_dialog.dart';
import 'package:louvor_ics_patos/pages/selecionar_louvores/selecionar_louvores_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/utils/substring_highlight_app.dart';
import 'package:louvor_ics_patos/utils/substring_highlight_app.dart';

import 'package:substring_highlight/substring_highlight.dart';

class LouvorTile extends StatelessWidget {
  Louvor louvor;
  bool pronto;
  String destaque;
  bool selecionada;
  bool selecionarLouvores;
  bool desselecionarLouvores;

  LouvorTile(this.louvor,
      {this.pronto = false,
      this.selecionada = false,
      this.selecionarLouvores = false,
      this.destaque: '',
      this.desselecionarLouvores = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: selecionada ? Cores.accent : Colors.white,
      child: InkWell(
        onTap: desselecionarLouvores
            ? () {
                if (SelecionarLouvoresPageController.to.louvoresSelecionados
                    .contains(louvor)) {
                  SelecionarLouvoresPageController.to.louvoresSelecionados
                      .remove(louvor);
                }
              }
            : selecionarLouvores
                ? () {
                    if (SelecionarLouvoresPageController.to.louvoresSelecionados
                        .contains(louvor)) {
                      SelecionarLouvoresPageController.to.louvoresSelecionados
                          .remove(louvor);
                    } else {
                      SelecionarLouvoresPageController.to.louvoresSelecionados
                          .add(louvor);
                    }
                  }
                : () {
                    Get.focusScope.unfocus();
                    return Get.dialog(LouvorDialog(louvor));
                  },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: SubstringHighlightApp(
                    text: louvor.titulo,
                    term: destaque,
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: selecionada ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyleHighlight: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selecionada ? Colors.white : Cores.accent),
                  ),
                ),
                Container(
                  child: SubstringHighlightApp(
                    text:
                        louvor.cantor.isEmpty ? 'Desconhecido' : louvor.cantor,
                    term: destaque,
                    textStyle: TextStyle(
                      color: selecionada ? Colors.white : Colors.black,
                    ),
                    textStyleHighlight: TextStyle(
                        color: selecionada ? Colors.black : Cores.accent),
                  ),
                ),
              ],
            ),
            trailing: louvor.status == "Pronto" && pronto
                ? Icon(
                    LineAwesomeIcons.check,
                    color: Cores.accent,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
