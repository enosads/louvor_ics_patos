import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';

class GruposPageController extends GetxController {
  RxList<Grupo> grupos;

  @override
  void onInit() {}

  getMembros() async {
    List<Grupo> novaLista = [];
    for (Grupo grupo in grupos) {
      List<Usuario> usuarios = await grupo.getMembros();
      grupo.membros = usuarios;
      novaLista.add(grupo);
    }
    grupos.clear();
    grupos.addAll(novaLista);
  }

  static GruposPageController get to => Get.find();
}
