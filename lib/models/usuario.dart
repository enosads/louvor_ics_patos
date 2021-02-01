import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String id;
  String perfil;
  String nome;
  Timestamp dataNascimento;
  DocumentReference reference;

  List<String> instrumentos;

  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    perfil = map['perfil'];
    nome = map['nome'];
    reference = map['reference'];
    dataNascimento = map['dataNascimento'];
    instrumentos = map['instrumentos'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['perfil'] = this.perfil;
    data['nome'] = this.nome;
    data['dataNascimento'] = this.dataNascimento.toString();
    data['instrumentos'] = this.instrumentos;
    return data;
  }
}
