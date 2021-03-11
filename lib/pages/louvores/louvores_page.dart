import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_louvor/add_editar_louvor_page.dart';
import 'package:louvor_ics_patos/pages/louvores/louvor_tile.dart';
import 'package:louvor_ics_patos/pages/louvores/louvores_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class LouvoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope.unfocus(),
      child: GetBuilder(
          init: LouvoresPageController(),
          builder: (LouvoresPageController _) {
            return Scaffold(
              appBar: AppBar(
                brightness: Brightness.light,

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 16, color: Cores.primary),
                            controller: _.tBusca,
                            cursorColor: Cores.primary,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16),
                              border: InputBorder.none,
                              hintText: "Buscar louvor",
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.grey[500]),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            onChanged: (value) => _.busca.value = value,
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              _.tBusca.text = '';
                              _.busca.value = '';
                            },
                            child: _.busca.value.isNotEmpty ? Icon(
                                   LineIcons.times,
                                color: Colors.grey[500]): Container(),
                          ),
                        ),
                        Obx(() => PopupMenuButton(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      _.status.value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Cores.primary,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: Cores.primary)
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    'Todos',
                                    style: TextStyle(color: Cores.primary),
                                  ),
                                  value: 'Todos',
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Pronto',
                                    style: TextStyle(color: Cores.primary),
                                  ),
                                  value: 'Pronto',
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Ensaiando',
                                    style: TextStyle(color: Cores.primary),
                                  ),
                                  value: 'Ensaiando',
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Sugestão',
                                    style: TextStyle(color: Cores.primary),
                                  ),
                                  value: 'Sugestão',
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    'Futuro',
                                    style: TextStyle(color: Cores.primary),
                                  ),
                                  value: 'Futuro',
                                )
                              ],
                              onSelected: (value) {
                                Get.focusScope.unfocus();

                                if (value == 'Todos') {
                                  _.status.value = 'Todos';
                                } else if (value == 'Pronto') {
                                  _.status.value = 'Pronto';
                                } else if (value == 'Ensaiando') {
                                  _.status.value = 'Ensaiando';
                                } else if (value == 'Sugestão') {
                                  _.status.value = 'Sugestão';
                                } else {
                                  _.status.value = 'Futuro';
                                }
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: _body(_),
              // drawer: AppDrawerList(),
              floatingActionButton: _fab(_),
            );
          }),
    );
  }

  _body(LouvoresPageController _) {
    return Obx(
      () => StreamBuilder<QuerySnapshot>(
        stream: _.status.value == "Todos"
            ? FirebaseFirestore.instance
                .collection('louvores')
                .orderBy('titulo')
                .snapshots()
            : FirebaseFirestore.instance
                .collection('louvores')
                .where('status', isEqualTo: _.status.value)
                .orderBy('titulo')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Não foi possível buscar louvores.'));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Louvor> louvores = snapshot.data.docs
              .map(
                (DocumentSnapshot document) => Louvor.fromSnapshot(document),
              )
              .toList();
          return Obx(() => getLouvoresListView(_, louvores));
        },
      ),
    );
  }

  getLouvoresListView(LouvoresPageController _, List<Louvor> louvores) {
    if (louvores.isEmpty) {
      return Center(
          child: Text(_.status.value == 'Todos'
              ? 'Nenhum louvor cadastrado'
              : 'Não há louvores com o status: ${_.status.value}'));
    }
    bool encontrado = false;
    louvores.forEach((louvor) {
      if (louvor.titulo.toUpperCase().contains(_.busca.value.toUpperCase()) ||
          louvor.cantor.toUpperCase().contains(_.busca.value.toUpperCase())) {
        encontrado = true;
      }
    });
    if (encontrado) {
      return ListView.builder(
        controller: _.scrollController,
        padding: EdgeInsets.only(bottom: 64),
        itemBuilder: (context, index) {
          Louvor louvor = louvores[index];
          if (louvor.titulo
                  .toUpperCase()
                  .contains(_.busca.value.toUpperCase()) ||
              louvor.cantor
                  .toUpperCase()
                  .contains(_.busca.value.toUpperCase())) {
            return LouvorTile(
              louvor,
              destaque: _.busca.value,
              pronto: true,
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

  _fab(LouvoresPageController _) {
    return FloatingActionButton(
      heroTag: 'louvores_fab',
      onPressed: () {
        Get.focusScope.unfocus();

        Get.to(AdicionarEditarLouvorPage());
      },
      child: Icon(LineIcons.plus),
      backgroundColor: Cores.primary,
    );
  }
}
