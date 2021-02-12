import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String perfil;
  String nome;
  DocumentReference reference;

  List<String> instrumentos;

  Usuario.fromSnapshot(DocumentSnapshot documentSnapshot) {
    reference = documentSnapshot.reference;
    perfil = documentSnapshot.data()['perfil'];
    nome = documentSnapshot.data()['nome'];
    instrumentos = documentSnapshot.data()['instrumentos'].cast<String>();
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    perfil = map['perfil'];
    nome = map['nome'];
    instrumentos = map['instrumentos'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['perfil'] = this.perfil;
    data['nome'] = this.nome;
    data['instrumentos'] = this.instrumentos;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{perfil: $perfil, nome: $nome, reference: $reference, instrumentos: $instrumentos}';
  }
}
