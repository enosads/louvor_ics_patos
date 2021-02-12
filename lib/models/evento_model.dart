import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:louvor_ics_patos/models/louvor_model.dart';

class Evento {
  DocumentReference reference;
  DateTime horario;
  DocumentReference grupoReference;
  List<DocumentReference> louvoresReference;

  Evento(
      {this.reference,
      this.horario,
      this.louvoresReference,
      this.grupoReference});

  Evento.fromMap(Map<String, dynamic> map) {
    reference = map['reference'];
    horario = DateTime.parse(map['horario']);
    louvoresReference = map['louvores'].cast<DocumentReference>();

    verificarLouvoresReference();
  }

  Evento.fromSnapshot(DocumentSnapshot documentSnapshot) {
    reference = documentSnapshot.reference;
    horario = DateTime.parse(documentSnapshot.data()['horario']);
    grupoReference = documentSnapshot.data()['grupoReference'];
    louvoresReference =
        documentSnapshot.data()['louvores'].cast<DocumentReference>();
    verificarLouvoresReference();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['horario'] = this.horario.toString();
    data['louvores'] = this.louvoresReference;
    data['grupoRefence'] = this.grupoReference;
    return data;
  }

  getLouvores() async {
    List<Louvor> list = [];
    for (DocumentReference document in louvoresReference) {
      var snapshot = await document.get();
      list.add(Louvor.fromSnapshot(snapshot));
    }
    return list;
  }

  verificarLouvoresReference() async {
    List<DocumentReference> louvoresExistem = [];
    for (DocumentReference document in louvoresReference) {
      var snapshot = await document.get();
      if (snapshot.exists) {
        louvoresExistem.add(snapshot.reference);
      }
    }
    if (louvoresReference.length != louvoresExistem.length) {
      reference.update({'louvores': louvoresExistem});
    }
  }
}
