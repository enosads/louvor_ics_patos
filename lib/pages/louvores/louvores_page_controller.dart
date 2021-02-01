import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LouvoresPageController extends GetxController {
  final tBusca = TextEditingController();

  final busca = ''.obs;

  var scrollController = ScrollController();


  @override
  void onInit() {
    scrollController.addListener(() {
      Get.focusScope.unfocus();
    });
  }

  static LouvoresPageController get to => Get.find();
  final status = 'Todos'.obs;
}
