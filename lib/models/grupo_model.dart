import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';
import 'package:louvor_ics_patos/pages/grupos/grupos_page_controller.dart';

class Grupo {
  String nome;
  DocumentReference reference;
  List<Usuario> membros = [];
  List<DocumentReference> membrosReference;

  Grupo(this.nome, this.membrosReference);

  Grupo.fromSnapshot(DocumentSnapshot documentSnapshot) {
    reference = documentSnapshot.reference;
    nome = documentSnapshot.data()['nome'];
    membrosReference =
        documentSnapshot.data()['membrosReference'].cast<DocumentReference>();
    verificarMembrosReference();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = this.nome;
    data['membrosReference'] = this.membrosReference;
    return data;
  }

  Future<List<Usuario>> getMembros() async {
    List<Usuario> list = [];
    for (DocumentReference document in membrosReference) {
      var snapshot = await document.get();
      list.add(Usuario.fromSnapshot(snapshot));
    }
    membros = list;
    return list;
  }

  verificarMembrosReference() async {
    List<DocumentReference> membrosExistem = [];
    for (DocumentReference document in membrosReference) {
      var snapshot = await document.get();
      if (snapshot.exists) {
        membrosExistem.add(snapshot.reference);
      }
    }
    if (membrosReference.length != membrosExistem.length) {
      reference.update({'membros': membrosExistem});
    }
  }
}
