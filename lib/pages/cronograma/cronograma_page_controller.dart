import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';
import 'package:louvor_ics_patos/models/grupo_model.dart';

class CronogramaPageController extends GetxController {
  var eventos = <Evento>[].obs;


  static CronogramaPageController get to => Get.find();
}
