import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/nota_model.dart';
import 'package:assurance/modules/inicio_notas/pages/create_note_page.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotasController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  TextEditingController _tecTitle = TextEditingController();
  TextEditingController get tecTitle => _tecTitle;
  TextEditingController _tecContent = TextEditingController();
  TextEditingController get tecContent => _tecContent;
  List<Nota> _listNotas = [];
  List<Nota> get listNotas => _listNotas;
  bool _cargando = true;
  bool get cargando => _cargando;
  bool _isEditing = false;
  bool get isEditing => _isEditing;

  @override
  void onReady() {
    super.onReady();
    obtenerNotas();
  }

  void obtenerNotas() {
    _listNotas.clear();
    FirebaseServices.databaseReference
        .child('notas')
        .child(globalControllerUsuario.usuario.uid)
        .once()
        .then((snap) {
      _listNotas.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          print(key);
          print(value);
          _listNotas.add(Nota.fromJson(key, value));
        });
      }
      _cargando = false;
      update();
    });
  }

  void createNotaFirebase() {
    Get.back();
    Map value = {
      'titulo': _tecTitle.text,
      'contenido': _tecContent.text,
      'fechaCreado': DateTime.now().millisecondsSinceEpoch,
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
      'fechaEliminado': DateTime.now().millisecondsSinceEpoch,
    };
    if (_tecTitle.text.trim().isNotEmpty &&
        _tecContent.text.trim().isNotEmpty) {
      FirebaseServices.databaseReference
          .child('notas')
          .child(globalControllerUsuario.usuario.uid)
          .push()
          .set(value)
          .then((value) => cleanInputs());
    }
  }

  void editarNotaFirebase(Nota nota) {
    Get.back();
    Map<String, dynamic> value = {
      'titulo': _tecTitle.text,
      'contenido': _tecContent.text,
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
    };
    if (_tecTitle.text.trim().isNotEmpty &&
        _tecContent.text.trim().isNotEmpty) {
      FirebaseServices.databaseReference
          .child('notas')
          .child(globalControllerUsuario.usuario.uid)
          .child(nota.id)
          .update(value)
          .then((value) => cleanInputs());
    }
  }

  void deleteNota(Nota nota, int index) {
    UtilsDialog.alertDialogTwoActions(Get.overlayContext, Strings.sEliminarNota,
        Strings.sEliminarNotaConfirm, Strings.sEliminar, Strings.sCancelar, () {
      Get.back();
      Get.back();
      FirebaseServices.databaseReference
          .child('notas')
          .child(globalControllerUsuario.usuario.uid)
          .child(nota.id)
          .remove()
          .then((value) {
        _listNotas.removeAt(index);
        update();
        cleanInputs();
      });
    }, () {
      Get.back();
    });
  }

  void cleanInputs() {
    obtenerNotas();
    _tecTitle.text = '';
    _tecContent.text = '';
  }

  void toCreateNota({Nota nota, int index}) {
    if (nota != null) {
      _isEditing = true;
      Get.to(() => CreateNotaPage(
            nota: nota,
            index: index,
          ));
      _tecTitle.text = nota.titulo;
      _tecContent.text = nota.contenido;
    } else {
      _isEditing = false;
      Get.to(() => CreateNotaPage());
    }
  }
}
