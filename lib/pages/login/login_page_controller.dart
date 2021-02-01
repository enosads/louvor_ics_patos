import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/firebase/firebase_service.dart';
import 'package:louvor_ics_patos/pages/home/home_page.dart';
import 'package:louvor_ics_patos/utils/onesignal_utils.dart';
import 'package:louvor_ics_patos/utils/prefs.dart';
import 'package:louvor_ics_patos/widgets/app_dialog.dart';

class LoginPageController extends GetxController {
  final tEmail = TextEditingController(text: '');
  final tSenha = TextEditingController(text: '');

  @override
  void onInit() {
    lastLogin();
  }

  lastLogin() async {
    String email = await Prefs.getString('lastLogin');
    tEmail.text = email;
  }

  onClickLogin() async {
    await FirebaseService.login(tEmail.text, tSenha.text);
    if (FirebaseAuth.instance.currentUser != null) {
      Prefs.setString('lastLogin', tEmail.text);
      OneSignalUtils.initOneSignal();
      Get.offAll(HomePage());
    } else {
      AppDialog(Text('Não foi possível o login'),
          textConfirm: 'OK', onConfirm: () => Get.back()).show();
    }
  }
}
