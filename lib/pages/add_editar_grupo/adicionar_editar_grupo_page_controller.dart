import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/models/usuario_model.dart';

class AdicionarEditarGrupoPageController extends GetxController {
  RxList<Usuario> membros = <Usuario>[].obs;

  var membrosSelecionados = <Usuario>[].obs;

  static AdicionarEditarGrupoPageController get to => Get.find();

  Grupo grupo;

  AdicionarEditarGrupoPageController(this.grupo);

  @override
  void onInit() {}

  Future<void> fetchMembros() async {
    if (grupo != null) {
      var selecionados = await grupo.getMembros();
      membros.forEach((m) {
        selecionados.forEach((s) {
          if (m.reference == s.reference) {
            membrosSelecionados.add(m);
          }
        });
      });
    }
  }

  bool verificarMembro(Usuario m, RxList<Usuario> selecionados) {
    bool response = false;
    selecionados.forEach((s) {
      if (m.reference == s.reference) {
        response = true;
      }
    });
    return response;
  }
}
