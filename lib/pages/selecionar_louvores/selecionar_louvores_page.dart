import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/horario_page/horario_page.dart';
import 'package:louvor_ics_patos/pages/louvores/louvor_tile.dart';
import 'package:louvor_ics_patos/pages/selecionar_louvores/selecionar_louvores_page_controller.dart';
import 'package:louvor_ics_patos/utils/app_reorderable_list_view.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';

class SelecionarLouvoresPage extends StatelessWidget {
  Evento evento;

  SelecionarLouvoresPage({this.evento});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SelecionarLouvoresPageController(evento),
      builder: (SelecionarLouvoresPageController _) {
        return Scaffold(
          appBar: buildAppBar(_),
          body: buildBody(_),
          floatingActionButton: buildFloatingActionButton(_),
        );
      },
    );
  }

  AppBar buildAppBar(SelecionarLouvoresPageController _) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100]),
          ),
          TextField(
            style: TextStyle(fontSize: 16, color: Cores.accent),
            controller: _.tBusca,
            cursorColor: Cores.accent,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 40),
              border: InputBorder.none,
              hintText: "Buscar louvor",
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey[500]),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (value) => _.busca.value = value,
          ),
          Positioned(
            left: 0,
            child: IconButton(
              splashRadius: 1,
              icon: Icon(Icons.arrow_back, color: Colors.grey[500]),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            right: 16,
            child: Obx(
              () => GestureDetector(
                onTap: () {
                  _.tBusca.text = '';
                  _.busca.value = '';
                },
                child: Icon(
                    _.busca.value.isNotEmpty
                        ? LineAwesomeIcons.times
                        : LineAwesomeIcons.search,
                    color: _.busca.value.isNotEmpty
                        ? Cores.accent
                        : Colors.grey[500]),
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  buildBody(SelecionarLouvoresPageController _) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('louvores')
          .where('status', isEqualTo: 'Pronto')
          .orderBy('titulo')
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
        List<Louvor> louvores = snapshot.data.docs
            .map((DocumentSnapshot document) => Louvor.fromSnapshot(document))
            .toList();
        return Stack(
          children: [
            Obx(() => getLouvoresListView(_, louvores)),
            buildDraggableScrollableSheet(_),
          ],
        );
      },
    );
  }

  getLouvoresListView(
      SelecionarLouvoresPageController _, List<Louvor> louvores) {
    if (louvores.isEmpty) {
      return Center(
        child: Text(
          'Nenhum louvor cadastrado',
        ),
      );
    }
    bool encontrado = false;
    louvores.forEach(
      (louvor) {
        if (louvor.titulo.toUpperCase().contains(_.busca.value.toUpperCase()) ||
            louvor.cantor.toUpperCase().contains(_.busca.value.toUpperCase())) {
          encontrado = true;
        }
      },
    );
    if (encontrado) {
      return ListView.builder(
        controller: _.scrollController,
        padding: EdgeInsets.only(bottom: Get.height * 0.75),
        itemBuilder: (context, index) {
          Louvor louvor = louvores[index];
          if (louvor.titulo
                  .toUpperCase()
                  .contains(_.busca.value.toUpperCase()) ||
              louvor.cantor
                  .toUpperCase()
                  .contains(_.busca.value.toUpperCase())) {
            return Obx(
              () => LouvorTile(
                louvor,
                destaque: _.busca.value,
                selecionada: _.louvoresSelecionados.contains(louvor),
                selecionarLouvores: true,
              ),
            );
          }
          return Container();
        },
        itemCount: louvores.length,
      );
    } else {
      return Center(
        child: Text('Nenhum louvor encontrado'),
      );
    }
  }

  DraggableScrollableSheet buildDraggableScrollableSheet(
      SelecionarLouvoresPageController _) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
          ),
          color: Colors.grey[100],
        ),
        child: ListView(
          controller: scrollController,
          children: [
            Obx(
              () => Container(
                height: (_.louvoresSelecionados.length * 70) + 60.0,
                child: ReorderableListViewApp(
                  header: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Text(
                      'Louvores selecionados (${_.louvoresSelecionados.length})',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Cores.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Louvor louvor =
                        _.louvoresSelecionados.removeAt(oldIndex);
                    _.louvoresSelecionados.insert(newIndex, louvor);
                  },
                  children: louvoresSelecionadosListView(_),
                ),
              ),
            )
          ],
        ),
      ),
      initialChildSize: 0.15,
      maxChildSize: 0.8,
      minChildSize: 0.15,
    );
  }

  List<Widget> louvoresSelecionadosListView(
      SelecionarLouvoresPageController _) {
    List<Widget> louvoresWidgets = [];
    _.louvoresSelecionados.forEach(
      (louvor) {
        louvoresWidgets.add(
          Container(
            key: ValueKey(louvor.reference.id),
            child: LouvorTile(louvor,
                desselecionarLouvores: true),
          ),
        );
      },
    );
    return louvoresWidgets;
  }

  FloatingActionButton buildFloatingActionButton(
      SelecionarLouvoresPageController _) {
    return FloatingActionButton(
      backgroundColor: Cores.accent,
      onPressed: () {
        if (_.louvoresSelecionados.isEmpty) {
          AppDialog(Text('Selecione pelo menos uma música para continuar'),
              textConfirm: 'OK', onConfirm: () => Get.back()).show();
        } else {
          Get.to(HorarioPage(evento));
        }
      },
      child: Icon(LineAwesomeIcons.arrow_right),
    );
  }
}
