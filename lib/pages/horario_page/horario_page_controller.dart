import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/utils/date_utils.dart';

class HorarioPageController extends GetxController {
  final formKeyData = GlobalKey<FormState>();
  final formKeyHora = GlobalKey<FormState>();

  final tData = TextEditingController(text: '');
  final data = ''.obs;

  final tHora = TextEditingController(text: '');
  final hora = ''.obs;

  var focusHora = FocusNode();
  Evento evento;

  HorarioPageController(this.evento);

  @override
  void onInit() {
    if (evento != null) {
      tData.text = DateUtil.formatDate(evento.horario);
      data.value = tData.text;
      tHora.text = DateUtil.formatTime(evento.horario);
      hora.value = tHora.text;
    }
  }

  static HorarioPageController get to => Get.find();

  String validatorData(String value) {
    Pattern pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) || value.length != 10)
      return 'Data inválida';
    else
      return null;
  }

  String validatorHora(String value) {
    Pattern pattern = r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Hora inválida';
    else
      return null;
  }


}
