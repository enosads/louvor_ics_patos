import 'package:flutter/material.dart';
import 'package:louvor_ics_patos/pages/perfil/perfil_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class InstrumentoChip extends StatelessWidget {
  String instrumento;
  bool selecionar;
  bool selecionado;

  InstrumentoChip(this.instrumento,
      {this.selecionar = false, this.selecionado = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: !selecionar
          ? Chip(
              label: Text(
                instrumento,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: getColor(),
            )
          : ChoiceChip(
              label: Text(
                instrumento,
                style: TextStyle(color: Colors.white),
              ),
              selected: selecionado,
              selectedColor: selecionado ? getColor() : Colors.grey,
              onSelected: (value) {
                if (value) {
                  PerfilPageController.to.instrumentosSelecionados
                      .add(instrumento);
                } else {
                  PerfilPageController.to.instrumentosSelecionados
                      .remove(instrumento);
                }
              },
            ),
    );
  }

  Color getColor() {
    return instrumento == 'Violão'
        ? Colors.blue
        : instrumento == 'Teclado'
            ? Colors.deepPurple
            : instrumento == 'Contrabaixo'
                ? Colors.orange
                : instrumento == 'Vocal'
                    ? Colors.indigo
                    : instrumento == 'Projetor'
                        ? Colors.lime
                        : Colors.grey;
  }
}
