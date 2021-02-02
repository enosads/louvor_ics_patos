import 'package:cloud_firestore/cloud_firestore.dart';

class Grupo {
  String nome;
  DocumentReference reference;

  List<String> instrumentos;

  Grupo.fromSnapshot(DocumentSnapshot documentSnapshot) {
    reference = documentSnapshot.reference;
    nome = documentSnapshot.data()['nome'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = this.nome;
    return data;
  }
}
