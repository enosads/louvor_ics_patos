import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';
import 'package:louvor_ics_patos/pages/home/home_page.dart';
import 'package:louvor_ics_patos/pages/horario_page/horario_page_controller.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page_controller.dart';
import 'package:louvor_ics_patos/pages/selecionar_louvores/selecionar_louvores_page_controller.dart';
import 'package:louvor_ics_patos/services/onesignal_service.dart';
import 'package:louvor_ics_patos/utils/date_utils.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';

class SelecionarGrupoPageController extends GetxController {
  var focusHora = FocusNode();
  Evento evento;
  Rx<Grupo> grupoSelecionado = Rx<Grupo>();
  var grupos = <Grupo>[].obs;

  SelecionarGrupoPageController(this.evento);

  @override
  void onInit() {}

  static SelecionarGrupoPageController get to => Get.find();

  onClickSalvarCulto() async {
    DateTime horario = DateUtil.parse(
        '${HorarioPageController.to.tData.text} - ${HorarioPageController.to.tHora.text}');
    if (evento == null) {
      FirebaseFirestore.instance.collection('eventos').doc().set(Evento(
              horario: horario,
              louvoresReference: SelecionarLouvoresPageController
                  .to.louvoresSelecionados
                  .map((element) => element.reference)
                  .toList(),
              grupoReference: SelecionarGrupoPageController
                  .to.grupoSelecionado.value.reference)
          .toMap());

      OnesignalService().notificar(
          "${PerfilPageController.to.usuario.nome} adicionou um cronograma",
          "${DateUtil.formatDateTimeNotificacao(horario)}\n\n${SelecionarLouvoresPageController.to.louvoresSelecionados.join('\n')}");
    } else {
      evento.reference.update(Evento(
              horario: horario,
              louvoresReference: SelecionarLouvoresPageController
                  .to.louvoresSelecionados
                  .map((element) => element.reference)
                  .toList(),
              grupoReference: SelecionarGrupoPageController
                  .to.grupoSelecionado.value.reference)
          .toMap());
      OnesignalService().notificar(
          "${PerfilPageController.to.usuario.nome} editou um cronograma",
          "${DateUtil.formatDateTimeNotificacao(horario)}\n\n${SelecionarLouvoresPageController.to.louvoresSelecionados.join('\n')}");
    }

    Get.offAll(HomePage());
  }
}
