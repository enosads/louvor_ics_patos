import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/cronograma/cronograma_page_controller.dart';
import 'package:louvor_ics_patos/pages/cronograma/drawer_list.dart';
import 'package:louvor_ics_patos/pages/louvores/louvor_loading_shimmer.dart';
import 'package:louvor_ics_patos/pages/louvores/louvor_tile.dart';
import 'package:louvor_ics_patos/pages/selecionar_louvores/selecionar_louvores_page.dart';
import 'package:louvor_ics_patos/utils/app_reorderable_list_view.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/utils/date_utils.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';

class CronogramaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CronogramaPageController(),
      builder: (CronogramaPageController _) {
        return Scaffold(
          appBar: AppBar(
            title: AutoSizeText('Cronograma'),
            centerTitle: true,
          ),
          body: buildBody(_),
          drawer: AppDrawerList(),
          floatingActionButton: FloatingActionButton(
            heroTag: 'cronograma_fab',
            onPressed: () => Get.to(SelecionarLouvoresPage()),
            child: Icon(LineAwesomeIcons.plus),
            backgroundColor: Cores.accent,
          ),
        );
      },
    );
  }

  buildBody(CronogramaPageController _) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('eventos')
          .orderBy('horario')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Não foi possível buscar agenda');
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _.eventos = snapshot.data.docs
            .map((DocumentSnapshot document) {
              return Evento.fromSnapshot(document);
            })
            .toList()
            .obs;
        return Obx(() => getCronogramaListView(_));
      },
    );
  }

  getCronogramaListView(CronogramaPageController _) {
    if (_.eventos.isEmpty) {
      return Center(
        child: AutoSizeText('Não há cultos no cronograma.'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 64),
      itemBuilder: (context, index) {
        Evento evento = _.eventos[index];
        if (evento.horario.isBefore(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
          evento.reference.delete();
        }

        return Card(
          child: Container(
            height: (evento.louvoresReference.length * 70) + 59.0,
            // height: 400,
            child: ReorderableListViewApp(
              padding: EdgeInsets.all(0),
              header: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(LineAwesomeIcons.ellipsis_v),
                      onPressed: () => Get.dialog(Dialog(
                        child: Container(
                          height: 112,
                          width: Get.width,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  LineAwesomeIcons.edit,
                                ),
                                onTap: () => Get.off(
                                  SelecionarLouvoresPage(
                                    evento: evento,
                                  ),
                                ),
                                title: AutoSizeText('Editar'),
                              ),
                              ListTile(
                                leading: Icon(
                                  LineAwesomeIcons.trash,
                                ),
                                onTap: () {
                                  Get.back();
                                  AppDialog(
                                          AutoSizeText(
                                              'Deseja realmente deletar o culto?'),
                                          onConfirm: () {
                                    Get.back();
                                    evento.reference.delete();
                                  },
                                          textCancel: 'CANCELAR',
                                          textConfirm: 'DELETAR',
                                          colorConfirm: Colors.red)
                                      .show();
                                },
                                title: AutoSizeText('Deletar'),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 40),
                    child: AutoSizeText(
                      DateUtil.formatDateTimeDescrito(evento.horario),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Cores.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              children: louvoresList(evento),
              onReorder: (oldIndex, newIndex) {
                var louvoresReferences = evento.louvoresReference;
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final DocumentReference item =
                    louvoresReferences.removeAt(oldIndex);
                louvoresReferences.insert(newIndex, item);
                FirebaseFirestore.instance
                    .collection('eventos')
                    .doc(evento.reference.id)
                    .update({'louvores': louvoresReferences});
              },
            ),
          ),
        );
      },
      itemCount: _.eventos.length,
    );
  }

  List<Widget> louvoresList(Evento evento) {
    List<Widget> louvoresWidgets = [];
    evento.louvoresReference.forEach(
      (reference) {
        evento.verificarLouvoresReference();
        louvoresWidgets.add(
          Container(
            key: ValueKey(reference.id),
            height: 70,
            child: StreamBuilder<DocumentSnapshot>(
              stream: reference.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Text('Não foi possível buscar louvor'),
                  );
                }
                if (!snapshot.hasData) {
                  return LouvorLoadingShimmer();
                }
                return LouvorTile(Louvor.fromSnapshot(snapshot.data),
                    pronto: false);
              },
            ),
          ),
        );
      },
    );
    return louvoresWidgets;
  }
}
