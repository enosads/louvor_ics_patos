import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/pages/horario_page/horario_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_text.dart';
import 'package:louvor_ics_patos/utils/date_utils.dart';

class HorarioPage extends StatelessWidget {
  Evento evento;

  HorarioPage(this.evento);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HorarioPageController(evento),
      builder: (
        HorarioPageController _,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: Text(evento == null ? 'Horário' : 'Editar horário'),
            centerTitle: true,

          ),
          body: _body(_),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _.onClickSalvarCulto(),
            child: Icon(LineAwesomeIcons.check),
            backgroundColor: Cores.accent,
          ),
        );
      },
    );
  }

  _body(HorarioPageController _) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Form(
            key: _.formKeyData,
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.calendar,
                  color: Cores.primary,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AppText(
                    label: "Data",
                    data: true,
                    autofocus: true,
                    nextFocus: _.focusHora,
                    controller: _.tData,
                    validator: _.validatorData,
                    onChanged: (value) {
                      _.data.value = _.tData.text;
                      if (value.length == 10) {
                        _.formKeyData.currentState.validate();
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Obx(
            () => Wrap(
              children: [
                diaDaSemaChoiceChip(
                    _, 'Próxima quinta-feira', DateTime.thursday),
                SizedBox(
                  width: 10,
                ),
                diaDaSemaChoiceChip(_, 'Próximo domingo', DateTime.sunday),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Form(
            key: _.formKeyHora,
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.clock_o,
                  color: Cores.primary,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AppText(
                    label: "Hora",
                    hora: true,
                    controller: _.tHora,
                    focusNode: _.focusHora,
                    validator: _.validatorHora,
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {
                      if (value.length == 5) {
                        _.formKeyHora.currentState.validate();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Obx(() => Wrap(
                children: [
                  horaChoiceChip(_, '09:00'),
                  SizedBox(
                    width: 10,
                  ),horaChoiceChip(_, '18:30'),
                  SizedBox(
                    width: 10,
                  ),horaChoiceChip(_, '19:30'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  ChoiceChip horaChoiceChip(HorarioPageController _, String hora) {
    return ChoiceChip(
      label: Text(
        hora,
        style: TextStyle(
          color: _.hora.value == hora ? Colors.white : Colors.black,
        ),
      ),
      selectedColor: Cores.primary,
      selected: _.hora.value == hora ? true : false,
      onSelected: (bool selected) {
        _.hora.value = hora;
        _.tHora.text = hora;
        _.formKeyHora.currentState.validate();

      },
    );
  }

  ChoiceChip diaDaSemaChoiceChip(
      HorarioPageController _, String titulo, int diaDaSemana) {
    return ChoiceChip(
      label: Text(
        titulo,
        style: TextStyle(
          color: _.data.value ==
                  DateUtil.formatDate(DateUtil.proximaDiaDaSemana(diaDaSemana))
              ? Colors.white
              : Colors.black,
        ),
      ),
      selectedColor: Cores.primary,
      selected: _.data.value ==
              DateUtil.formatDate(DateUtil.proximaDiaDaSemana(diaDaSemana))
          ? true
          : false,
      onSelected: (bool selected) {
        _.data.value =
            DateUtil.formatDate(DateUtil.proximaDiaDaSemana(diaDaSemana));
        _.tData.text =
            DateUtil.formatDate(DateUtil.proximaDiaDaSemana(diaDaSemana));
        _.formKeyData.currentState.validate();
      },
    );
  }
}
