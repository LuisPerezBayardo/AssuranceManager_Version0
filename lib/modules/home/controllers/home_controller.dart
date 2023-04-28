import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/usuario_model.dart';
import 'package:assurance/modules/inicio/pages/inicio_page.dart';
import 'package:assurance/modules/login/pages/login_page.dart';
import 'package:assurance/modules/perfil/pages/perfil_page.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:assurance/widgets/widget_error.dart';
import 'package:assurance/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Widget> _tabs = <Widget>[
    WidgetLoading(),
    WidgetLoading(),
  ];
  List<Widget> get tabs => _tabs;

  @override
  void onReady() {
    super.onReady();
    obtenerUsuarioFirebase();
  }

  Future<void> obtenerUsuarioFirebase() async {
    updatePageLoading();
    FirebaseServices.databaseReference
        .child('agentesSeguro')
        .child(FirebaseServices.getUID())
        .once()
        .then((snap) {
      Usuario usuario = Usuario.fromJson(snap.key, snap.value);
      globalControllerUsuario.setUsuario(usuario);
      updatePages();
    }).catchError((onError) {
      globalControllerUsuario.setUsuarioError(onError.toString());
      updatePagesError();
    });
  }

  void updatePages() {
    _tabs[0] = InicioPage();
    _tabs[1] = PerfilPage();
    update();
  }

  void updatePageLoading() {
    _tabs[0] = WidgetLoading();
    _tabs[1] = WidgetLoading();
    update();
  }

  void updatePagesError() {
    _tabs[0] = WidgetError(
        fun: obtenerUsuarioFirebase,
        title: Strings.sError,
        text: Strings.sErrorUsuario,
        textButton: Strings.sIntentarDeNuevo);
    _tabs[1] = WidgetError(
        fun: obtenerUsuarioFirebase,
        title: Strings.sError,
        text: Strings.sErrorUsuario,
        textButton: Strings.sIntentarDeNuevo);
    update();
  }

  void setIndex(int index) {
    if (index != 2) {
      _currentIndex = index;
    } else {
      UtilsDialog.alertDialogTwoActions(Get.overlayContext, Strings.signOut,
          Strings.signOutConfirm, Strings.sAceptar, Strings.sCancelar, () {
        Get.back();
        cerrarSesion();
      }, () {
        Get.back();
      });
    }
    update();
  }

  void cerrarSesion() {
    FirebaseServices.firebaseAuth
        .signOut()
        .then((value) => toWelcomePage())
        .catchError((onError) => UtilsDialog.alertDialogError(
            Get.overlayContext, Strings.signOutError));
  }

  void toWelcomePage() {
    Get.offAll(() => LoginPage());
  }
}
