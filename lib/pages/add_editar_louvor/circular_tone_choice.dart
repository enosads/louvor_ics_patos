import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/add_editar_louvor/add_editar_louvor_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class CircularToneChoice extends StatelessWidget {
  String tom;

  CircularToneChoice(
    this.tom,
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: GestureDetector(
          onTap: () => AdicionarEditarLouvorPageController.to.tom.value == tom
              ? AdicionarEditarLouvorPageController.to.tom.value = ''
              : AdicionarEditarLouvorPageController.to.tom.value = tom,
          child: Container(
            padding: EdgeInsets.all(Get.width / 32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Cores.primary),
              color: AdicionarEditarLouvorPageController.to.tom.value == tom
                  ? Cores.primary
                  : Colors.white,
            ),
            child: AutoSizeText(
              tom,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16,
                  color: AdicionarEditarLouvorPageController.to.tom.value == tom
                      ? Colors.white
                      : Cores.primary),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
