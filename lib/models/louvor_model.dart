import 'package:cloud_firestore/cloud_firestore.dart';

class Louvor {
  String youtube;
  String tom;
  String titulo;
  String cifra;
  String cantor;
  String status;
  bool selecionado = false;
  DocumentReference reference;

  Louvor(
      {this.youtube,
      this.tom,
      this.titulo,
      this.cifra,
      this.cantor,
      this.selecionado = false,
      this.status});

  Louvor.fromMap(Map<String, dynamic> map) {
    reference = map['id'];
    youtube = map['youtube'];
    tom = map['tom'];
    titulo = map['titulo'];
    cifra = map['cifra'];
    cantor = map['cantor'];
    status = map['status'];
  }

  Louvor.fromSnapshot(DocumentSnapshot documentSnapshot) {
    reference = documentSnapshot.reference;
    youtube = documentSnapshot.data()['youtube'];
    tom = documentSnapshot.data()['tom'];
    titulo = documentSnapshot.data()['titulo'];
    cifra = documentSnapshot.data()['cifra'];
    cantor = documentSnapshot.data()['cantor'];
    status = documentSnapshot.data()['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['youtube'] = this.youtube;
    data['tom'] = this.tom;
    data['titulo'] = this.titulo;
    data['cifra'] = this.cifra;
    data['cantor'] = this.cantor;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return cantor.isEmpty ? titulo : '$titulo - $cantor';
  }
}
