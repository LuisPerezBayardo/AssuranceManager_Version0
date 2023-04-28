import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/modules/home/pages/home_page.dart';
import 'package:assurance/modules/login/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // ignore: avoid_print
    Firebase.initializeApp().then((value) => print(value.options.asMap));
    Future.delayed(const Duration(seconds: 3), () => comprobarSesion());
  }

  void comprobarSesion() {
    if (FirebaseServices.firebaseAuth.currentUser != null) {
      Get.offAll(HomePage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }
}
