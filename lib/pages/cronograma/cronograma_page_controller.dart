import 'package:get/get.dart';
import 'package:louvor_ics_patos/models/evento_model.dart';

class CronogramaPageController extends GetxController{
  var eventos = <Evento>[].obs;

  static CronogramaPageController get to => Get.find();

}
