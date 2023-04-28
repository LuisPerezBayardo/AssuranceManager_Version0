import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/home/pages/home_page.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {
  final TextEditingController _tecNombre = TextEditingController();
  TextEditingController get tecNombre => _tecNombre;
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecTelefono = TextEditingController();
  TextEditingController get tecTelefono => _tecTelefono;
  final TextEditingController _tecPassword = TextEditingController();
  TextEditingController get tecPassword => _tecPassword;
  final TextEditingController _tecPasswordConfirm = TextEditingController();
  TextEditingController get tecPasswordConfirm => _tecPasswordConfirm;
  bool _termsAndConditions = false;
  bool get termsAndConditions => _termsAndConditions;
  ProgressDialog _progressDialog;

  @override
  void onReady() {
    super.onReady();
    _progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
    //llenarDatos();
  }

  void llenarDatos() {
    _tecNombre.text = 'Rogelio';
    _tecEmail.text = 'rogegzll96@gmail.com';
    _tecTelefono.text = '3314653839';
    _tecPassword.text = 'welcome';
    _tecPasswordConfirm.text = 'welcome';
  }

  void registrarUsuario() {
    if (validarRegistro()) {
      registrarUsuarioFirebase();
    }
  }

  void registrarUsuarioFirebase() {
    _progressDialog.show();
    FirebaseServices.firebaseAuth
        .createUserWithEmailAndPassword(
            email: _tecEmail.text.trim(), password: _tecPassword.text)
        .then((res) {
      crearUsuarioFirebase(res.user.uid);
    }).catchError((onError) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        _progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogError(Get.overlayContext,
              FirebaseErrors.erroresFirebase(onError.toString()));
        });
      });
    });
  }

  void crearUsuarioFirebase(String uid) {
    Map data = {
      'nombre': _tecNombre.text,
      'correo': _tecEmail.text,
      'telefono': _tecTelefono.text,
      'avatar': '',
      'rfc': '',
      'correoNewYear': false,
      'correoBirthday': false,
      'correoChristmas': false,
      'correoRecordatorioPagos': false,
      'fechaCreado': DateTime.now().millisecondsSinceEpoch,
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
      'borrado': false
    };
    FirebaseServices.databaseReference
        .child('agentesSeguro')
        .child(uid)
        .set(data)
        .then((value) {
      toHomePage();
    }).catchError((onError) {});
  }

  bool validarRegistro() {
    bool valido = true;

    if (_tecNombre.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreEmpty);
    } else if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    } else if (_tecTelefono.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoEmpty);
    } else if (_tecTelefono.text.trim().length != 10) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoFormat);
    } else if (_tecPassword.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordEmpty);
    } else if (_tecPassword.text.length < 6) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordFormat);
    } else if (_tecPasswordConfirm.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordConfirmEmpty);
    } else if (_tecPasswordConfirm.text != _tecPassword.text) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordConfirmFormat);
    } else if (!_termsAndConditions) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sAceptaTerminosYCondiciones);
    }

    return valido;
  }

  void setTermsAndConditions(bool value) {
    _termsAndConditions = value;
    update();
  }

  void toHomePage() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Get.offAll(() => HomePage());
      });
    });
  }
}
