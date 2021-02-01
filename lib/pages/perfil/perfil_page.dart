import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/usuario.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page_controller.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilPageController>(
      init: PerfilPageController(),
      builder: (_) {
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Não foi possível buscar usuario'));
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data.data());
            _.usuario = Usuario.fromMap(
              snapshot.data.data()
                ..addAll(
                  {"id": snapshot.data.id},
                ),
            );
            print(_.usuario.reference);

            return CustomScrollView(
              slivers: <Widget>[
                buildAppBar(_),
                // _body(),
              ],
            );
          },
        );
      },
    );
  }

  // SliverList _body() {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         switch (index) {
  //           case 0:
  //             return Container(
  //               margin: EdgeInsets.all(8),
  //               child: Card(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     ListTile(
  //                       title: AutoSizeText(
  //                         'Informações pessoais',
  //                         style: TextStyle(
  //                             color: Cores.primary,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                     ListTile(
  //                         leading: Icon(
  //                           Icons.person,
  //                           color: Cores.primary,
  //                         ),
  //                         title: AutoSizeText(
  //                             UsuarioController.to.usuario.username,
  //                             ),
  //                         subtitle: 'Nome de usuário'),
  //                     ListTile(
  //                         email: true,
  //                         copy: UsuarioController.to.usuario.email,
  //                         leading: Icon(
  //                           Icons.alternate_email,
  //                           color: Cores.primary,
  //                         ),
  //                         title: TitleTile(UsuarioController.to.usuario.email,
  //                             color: Cores.primary),
  //                         subtitle: 'E-mail'),
  //                     ListTile(
  //                         telefone: true,
  //                         copy: UsuarioController.to.usuario.telefone,
  //                         leading: Icon(
  //                           Icons.phone,
  //                           color: Cores.primary,
  //                         ),
  //                         title: TitleTile(
  //                             UsuarioController.to.usuario.telefone,
  //                             color: Cores.primary),
  //                         subtitle: 'Telefone'),
  //                     ListTile(
  //                         copy: DateUtil.format(
  //                             UsuarioController.to.usuario.dataNascimento),
  //                         leading: Icon(
  //                           Icons.event,
  //                           color: Cores.primary,
  //                         ),
  //                         title: TitleTile(
  //                             DateUtil.format(
  //                                 UsuarioController.to.usuario.dataNascimento),
  //                             color: Cores.primary),
  //                         subtitle: 'Data de nascimento'),
  //                   ],
  //                 ),
  //               ),
  //             );
  //             break;
  //           case 1:
  //             String enderecoTitle =
  //                 '${UsuarioController.to.usuario.endereco.rua},'
  //                 ' ${UsuarioController.to.usuario.endereco.numero}';
  //             String enderecoSubtitle =
  //                 '${UsuarioController.to.usuario.endereco.bairro.nome}, '
  //                 '${UsuarioController.to.usuario.endereco.bairro.cidade.nome}'
  //                 ' - ${UsuarioController.to.usuario.endereco.bairro.cidade.uf}\n'
  //                 '${UsuarioController.to.usuario.endereco.complemento != null ? UsuarioController.to.usuario.endereco.complemento : ''}'
  //                 '${UsuarioController.to.usuario.endereco.complemento != null ? ' - ' : ''}${UsuarioController.to.usuario.endereco.cep}';
  //             return Container(
  //               padding: EdgeInsets.symmetric(horizontal: 8),
  //               child: InkWell(
  //                 child: Card(
  //                   child: Column(
  //                     children: <Widget>[
  //                       ListTile(
  //                         title: TitleTile('Endereço',
  //                             bold: true, color: Cores.primary),
  //                         bold: true,
  //                       ),
  //                       ListTile(
  //                           copy: '$enderecoTitle\n$enderecoSubtitle',
  //                           fittedTitle: true,
  //                           leading: Icon(
  //                             Icons.place,
  //                             color: Cores.primary,
  //                           ),
  //                           isThreeLine: true,
  //                           title: FittedBox(
  //                             fit: BoxFit.fitWidth,
  //                             child: TitleTile(enderecoTitle,
  //                                 color: Cores.primary),
  //                           ),
  //                           subtitle: enderecoSubtitle),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //             break;
  //           default:
  //             return null;
  //         }
  //       },
  //       childCount: 2,
  //     ),
  //   );
  // }

  SliverAppBar buildAppBar(PerfilPageController _) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(_.usuario.nome),
        background: _.usuario.perfil != null
            ? Image(
                image: CachedNetworkImageProvider(_.usuario.perfil),
                fit: BoxFit.cover,
              )
            : Icon(Icons.person),
      ),
    );
  }
}
