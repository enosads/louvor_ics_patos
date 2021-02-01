import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_louvor/add_editar_louvor_page.dart';
import 'package:louvor_ics_patos/utils/url_launch.dart';

class LouvorDialog extends StatelessWidget {
  Louvor louvor;

  LouvorDialog(this.louvor);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        width: Get.width,
        child: Material(
          type: MaterialType.card,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: Theme.of(context).dialogTheme.elevation ?? 24.0,
          child: Container(
            padding: EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 8),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: AutoSizeText(
                        louvor.titulo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: AutoSizeText(
                        louvor.cantor.isEmpty ? 'Desconhecido' : louvor.cantor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    InkWell(
                      onTap: louvor.youtube.isBlank
                          ? null
                          : () => UrlLaunch.launchURL(louvor.youtube),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Icon(
                              LineAwesomeIcons.youtube_play,
                              color: louvor.youtube.isBlank
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              child: AutoSizeText(
                                'Ouvir no Youtube',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: louvor.youtube.isBlank
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: louvor.cifra.isBlank
                          ? null
                          : () => UrlLaunch.launchURL(louvor.cifra),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Icon(
                              LineAwesomeIcons.music,
                              color: louvor.cifra.isBlank
                                  ? Colors.grey
                                  : Colors.orange,
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              child: AutoSizeText(
                                'Ver a cifra',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: louvor.cifra.isBlank
                                        ? Colors.grey
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(4),
                      child: AutoSizeText(
                        'Tom: ${louvor.tom.isBlank ? 'Não selecionado' : louvor.tom}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(4),
                      child: AutoSizeText(
                        'Status: ${louvor.status}',      maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(LineAwesomeIcons.edit),
                    onPressed: () {
                      Get.back();
                      return Get.to(
                        AdicionarEditarLouvorPage(
                          louvor: louvor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
