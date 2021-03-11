import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'package:louvor_ics_patos/models/louvor_model.dart';
import 'package:louvor_ics_patos/pages/add_editar_louvor/add_editar_louvor_page_controller.dart';
import 'package:louvor_ics_patos/pages/add_editar_louvor/circular_tone_choice.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_button.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';
import 'package:louvor_ics_patos/widgets/app_text.dart';

class AdicionarEditarLouvorPage extends StatelessWidget {
  Louvor louvor;

  AdicionarEditarLouvorPage({this.louvor});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdicionarEditarLouvorPageController>(
      init: AdicionarEditarLouvorPageController(louvor: louvor),
      builder: (AdicionarEditarLouvorPageController _) {
        return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,

            title: Text(louvor == null ? 'Novo louvor' : 'Editar louvor'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(
                    LineIcons.check,
                  ),
                  onPressed: () => _.onClickSalvar())
            ],
          ),
          body: _body(_),
        );
      },
    );
  }

  _body(AdicionarEditarLouvorPageController _) {
    return Form(
      key: _.formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(
                LineIcons.font,
                color: Cores.primary,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppText(
                  label: "Título",
                  controller: _.tTitulo,
                  validator: _.validatorTitulo,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                LineIcons.userAlt,
                color: Cores.primary,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppText(
                  label: "Cantor",
                  controller: _.tCantor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                LineIcons.youtube,
                color: Cores.primary,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppText(
                  label: "Youtube",
                  controller: _.tYouTube,
                  validator: _.validatorYoutube,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                LineIcons.music,
                color: Cores.primary,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppText(
                  label: "Cifra",
                  controller: _.tCifra,
                  validator: _.validatorCifra,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: Get.width,
            child: Container(
              child: AutoSizeText(
                'Tom',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Cores.primary),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              CircularToneChoice(
                'C',
              ),
              CircularToneChoice('C#'),
              CircularToneChoice('D'),
              CircularToneChoice('D#'),
              CircularToneChoice('E'),
              CircularToneChoice('F'),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              CircularToneChoice('F#'),
              CircularToneChoice('G'),
              CircularToneChoice('G#'),
              CircularToneChoice('A'),
              CircularToneChoice('A#'),
              CircularToneChoice('B'),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: Get.width,
            child: Container(
              child: AutoSizeText(
                'Status',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Cores.primary),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Obx(
            () => Wrap(
              children: [
                ChoiceChip(
                  label: AutoSizeText(
                    'Pronto',
                    maxLines: 1,
                    style: TextStyle(
                        color: _.status.value == 'Pronto'
                            ? Colors.white
                            : Colors.black),
                  ),
                  selectedColor: Cores.primary,
                  selected: _.status.value == 'Pronto' ? true : false,
                  onSelected: (bool selected) {
                    _.status.value = 'Pronto';
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  selectedColor: Cores.primary,
                  label: AutoSizeText(
                    'Ensaiando',
                    maxLines: 1,
                    style: TextStyle(
                        color: _.status.value == 'Ensaiando'
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _.status.value == 'Ensaiando' ? true : false,
                  onSelected: (bool selected) {
                    _.status.value = 'Ensaiando';
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  selectedColor: Cores.primary,
                  label: AutoSizeText(
                    'Sugestão',
                    maxLines: 1,
                    style: TextStyle(
                        color: _.status.value == 'Sugestão'
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _.status.value == 'Sugestão' ? true : false,
                  onSelected: (bool selected) {
                    _.status.value = 'Sugestão';
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  selectedColor: Cores.primary,
                  label: AutoSizeText(
                    'Futuro',
                    maxLines: 1,
                    style: TextStyle(
                        color: _.status.value == 'Futuro'
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _.status.value == 'Futuro' ? true : false,
                  onSelected: (bool selected) {
                    _.status.value = 'Futuro';
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          if (louvor != null)
            AppButton(
              'DELETAR',
              color: Colors.red,
              onPressed: () => AppDialog(
                      AutoSizeText(
                        'Deseja realmente deletar o louvor?',
                        maxLines: 1,
                      ),
                      onConfirm: () => _.onClickDeletar(),
                      textCancel: 'CANCELAR',
                      textConfirm: 'DELETAR',
                      colorConfirm: Colors.red)
                  .show(),
            ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
