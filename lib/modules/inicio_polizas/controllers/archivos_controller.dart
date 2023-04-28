import 'dart:io';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/archivo_poliza_model.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ArchivosController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  String idPoliza;
  bool cargando = true;
  List<ArchivoPoliza> listArchivoPoliza = [];
  ProgressDialog progressDialog;

  @override
  void onInit() {
    super.onInit();
    idPoliza = Get.arguments as String;
    print(idPoliza);
  }

  @override
  void onReady() {
    super.onReady();
    obtenerArchivosPoliza();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  void obtenerArchivosPoliza() {
    listArchivoPoliza.clear();
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .child('archivos')
        .once()
        .then((snap) {
      listArchivoPoliza.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          listArchivoPoliza.add(ArchivoPoliza.fromJson(key, value));
        });
      }
      cargando = false;
      update();
    }).catchError((onError) {});
  }

  Future<void> selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx']);

    if (result != null) {
      File file = File(result.files.single.path);
      PlatformFile platformFile = result.files.single;
      print(file.lengthSync());
      if (detectTypeFile(platformFile.name) == 'imagen') {
        file = await Utils.testCompressAndGetFile(
          file,
        );
      }
      print(file.lengthSync());
      print(platformFile.name);
      if (detectTypeFile(platformFile.name) != 'invalid') {
        uploadFileStorage(
            file, platformFile.name, detectTypeFile(platformFile.name));
      } else {
        UtilsDialog.alertDialogError(
            Get.overlayContext, Strings.sErrorFormatFile);
      }
    }
  }

  uploadFileStorage(File file, String fileName, String type) {
    progressDialog.show();
    String idArchivo = FirebaseServices.databaseReference.push().key;
    FirebaseServices.storageReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .child('archivos')
        .child(idArchivo + '.' + detectExtension(fileName))
        .putFile(file)
        .then((snap) {
      snap.ref.getDownloadURL().then((url) {
        uploadFileDatabase(url, idArchivo, fileName, type);
      }).catchError((onError) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          progressDialog.hide().whenComplete(() {
            UtilsDialog.alertDialogError(
                Get.overlayContext, Strings.errorUploadFile);
          });
        });
      });
    });
  }

  uploadFileDatabase(
      String url, String idArchivo, String fileName, String type) {
    Map value = {
      'nombre': fileName,
      'url': url,
      'tipo': type,
    };
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .child('archivos')
        .child(idArchivo)
        .set(value)
        .then((value) {
      obtenerArchivosPoliza();
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogOneAction(
              Get.overlayContext,
              Strings.sArchivoCargado,
              Strings.sArchivoCargadoText,
              Strings.sAceptar,
              () => Get.back());
        });
      });
    });
  }

  void eliminarArchivo(int index, ArchivoPoliza archivoPoliza) {
    UtilsDialog.alertDialogTwoActions(
        Get.overlayContext,
        Strings.sEliminrArchivoPoliza,
        Strings.sEliminrArchivoPolizaComfirm,
        Strings.sEliminar,
        Strings.sCancelar, () {
      Get.back();
      progressDialog.show();
      FirebaseServices.storageReference.storage
          .refFromURL(archivoPoliza.url)
          .delete()
          .then((value) {
        FirebaseServices.databaseReference
            .child('polizas')
            .child(globalControllerUsuario.usuario.uid)
            .child(idPoliza)
            .child('archivos')
            .child(archivoPoliza.id)
            .remove()
            .then((value) {
          listArchivoPoliza.removeAt(index);
          update();
          Future.delayed(Duration(milliseconds: 300)).then((value) {
            progressDialog.hide().whenComplete(() {
              UtilsDialog.alertDialogOneAction(
                  Get.overlayContext,
                  Strings.sArchivoEliminado,
                  Strings.sArchivoEliminadoText,
                  Strings.sAceptar,
                  () => Get.back());
            });
          });
        }).catchError((onError) {});
      }).catchError((onError) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          progressDialog.hide().whenComplete(() {
            UtilsDialog.alertDialogOneAction(
                Get.overlayContext,
                Strings.sError,
                Strings.sArchivoEliminadoError,
                Strings.sAceptar,
                () => Get.back());
          });
        });
      });
    }, () {
      Get.back();
    });
  }

  String detectTypeFile(String fileName) {
    String fileType = '';
    if (fileName.toLowerCase().contains('jpg')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('jpeg')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('png')) {
      fileType = 'imagen';
    } else if (fileName.toLowerCase().contains('pdf')) {
      fileType = 'pdf';
    } else if (fileName.toLowerCase().contains('doc')) {
      fileType = 'word';
    } else if (fileName.toLowerCase().contains('docx')) {
      fileType = 'word';
    } else if (fileName.toLowerCase().contains('xls')) {
      fileType = 'excel';
    } else if (fileName.toLowerCase().contains('xlsx')) {
      fileType = 'excel';
    } else {
      'invalid';
    }
    return fileType;
  }

  String detectExtension(String fileName) {
    String extension = '';

    if (fileName.toLowerCase().contains('jpg')) {
      extension = 'jpg';
    } else if (fileName.toLowerCase().contains('jpeg')) {
      extension = 'jpeg';
    } else if (fileName.toLowerCase().contains('png')) {
      extension = 'png';
    } else if (fileName.toLowerCase().contains('pdf')) {
      extension = 'pdf';
    } else if (fileName.toLowerCase().contains('doc')) {
      extension = 'doc';
    } else if (fileName.toLowerCase().contains('docx')) {
      extension = 'docx';
    } else if (fileName.toLowerCase().contains('xls')) {
      extension = 'xls';
    } else if (fileName.toLowerCase().contains('xlsx')) {
      extension = 'xlsx';
    } else {
      'invalid';
    }

    return extension;
  }

  void toArchivoDetail(ArchivoPoliza archivoPoliza) async {
    launch(
      archivoPoliza.url,
    );
  }
}
