import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/modules/home/pages/home_page.dart';
import 'package:assurance/modules/login/pages/reset_password_page.dart';
import 'package:assurance/modules/register/pages/register_page.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginController extends GetxController {
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecPassword = TextEditingController();
  TextEditingController get tecPassword => _tecPassword;
  final TextEditingController _tecEmailReset = TextEditingController();
  TextEditingController get tecEmailReset => _tecEmailReset;
  ProgressDialog _progressDialog;

  @override
  void onReady() {
    super.onReady();
    _progressDialog = UtilsDialog.showProgresDialog(
      Get.overlayContext,
      false,
    );
  }

  //Login
  void login() {
    if (validarLogin()) {
      loginFirebase();
    }
  }

  void loginFirebase() {
    _progressDialog.show();
    FirebaseServices.firebaseAuth
        .signInWithEmailAndPassword(
            email: _tecEmail.text.trim(), password: _tecPassword.text)
        .then((value) => toHomePage())
        .catchError((onError) =>
            errorDialog(FirebaseErrors.erroresFirebase(onError.toString())));
  }

  bool validarLogin() {
    bool valido = true;
    if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (_tecPassword.text.isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPasswordEmpty);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    }
    return valido;
  }

  void resetPassword() {
    if (validarResetPassword()) {
      resetPasswordFirebase();
    }
  }

  bool validarResetPassword() {
    bool valido = true;
    if (_tecEmailReset.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoEmpty);
    } else if (!Utils.isEmail(_tecEmailReset.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorCorreoFormat);
    }
    return valido;
  }

  void resetPasswordFirebase() {
    _progressDialog.show();
    FirebaseServices.firebaseAuth
        .sendPasswordResetEmail(email: _tecEmailReset.text.trim())
        .then((value) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        _progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogOneAction(
              Get.overlayContext,
              Strings.sEmailResetSent,
              Strings.sEmailResetSentContent,
              Strings.sAceptar, () {
            Get.back();
            Get.back();
          });
        });
      });
    }).catchError((onError) =>
            errorDialog(FirebaseErrors.erroresFirebase(onError.toString())));
  }

  void errorDialog(String message) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _progressDialog.hide().whenComplete(() {
        UtilsDialog.alertDialogError(Get.overlayContext, message);
      });
    });
  }

  void toResetPassword() {
    Get.to(() => const ResetPasswordPage());
  }

  void toRegister() {
    Get.to(() => const RegisterPage());
  }

  void toHomePage() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _progressDialog.hide().whenComplete(() {
        Get.offAll(() => HomePage());
      });
    });
  }
}
