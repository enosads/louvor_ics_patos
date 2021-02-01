import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:louvor_ics_patos/pages/home/home_page.dart';
import 'package:louvor_ics_patos/pages/login/login_page.dart';

class SplashPageController extends GetxController {
  static SplashPageController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _init();

  }

  Future<void> _init() async {
    await Future.delayed(Duration(seconds: 2));
    await Firebase.initializeApp();
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(HomePage());
    } else {
      Get.off(LoginPage());
    }
  }
}
