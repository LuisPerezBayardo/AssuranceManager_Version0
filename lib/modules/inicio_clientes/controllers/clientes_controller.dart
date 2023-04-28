import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/modules/inicio_clientes/pages/crear_cliente_page.dart';
import 'package:assurance/modules/inicio_clientes/pages/detalle_cliente_page.dart';
import 'package:assurance/modules/inicio_clientes/pages/widgets/modal_date.dart';
import 'package:assurance/utils/utils.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ClientesController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  //Inputs create cliente
  final TextEditingController _tecNombre = TextEditingController();
  TextEditingController get tecNombre => _tecNombre;
  final TextEditingController _tecEmail = TextEditingController();
  TextEditingController get tecEmail => _tecEmail;
  final TextEditingController _tecTelefono = TextEditingController();
  TextEditingController get tecTelefono => _tecTelefono;
  final TextEditingController _tecFechaNacimiento = TextEditingController();
  TextEditingController get tecFechaNacimiento => _tecFechaNacimiento;
  final TextEditingController _tecRFC = TextEditingController();
  TextEditingController get tecRFC => _tecRFC;
  //Inputs edit cliente
  final TextEditingController _tecNombreE = TextEditingController();
  TextEditingController get tecNombreE => _tecNombreE;
  final TextEditingController _tecEmailE = TextEditingController();
  TextEditingController get tecEmailE => _tecEmailE;
  final TextEditingController _tecTelefonoE = TextEditingController();
  TextEditingController get tecTelefonoE => _tecTelefonoE;
  final TextEditingController _tecFechaNacimientoE = TextEditingController();
  TextEditingController get tecFechaNacimientoE => _tecFechaNacimientoE;
  final TextEditingController _tecRFCE = TextEditingController();
  TextEditingController get tecRFCE => _tecRFCE;
  final TextEditingController _tecBuscador = TextEditingController();
  TextEditingController get tecBuscador => _tecBuscador;
  List<Cliente> _listCliente = [];
  List<Cliente> get listCliente => _listCliente;
  List<Cliente> _listClienteBuscador = [];
  List<Cliente> get listClienteBuscador => _listClienteBuscador;
  bool _cargando = true;
  bool get cargando => _cargando;
  String _birthDay = '';
  ProgressDialog progressDialog;
  RxString buscador = ''.obs;

  @override
  void onReady() {
    super.onReady();
    obtenerClientes();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
    //llenarDatos();
  }

  void llenarDatos() {
    _tecNombre.text = 'Rogerio';
    _tecEmail.text = 'roge1@gmail.com';
    _tecTelefono.text = '3314653838';
  }

  void onInputTextChange(String text) {
    buscador.value = text;
    if (text == '') {
      _listClienteBuscador = _listCliente;
    } else {
      _listClienteBuscador = _listCliente
          .where((el) =>
              el.nombre.toLowerCase().contains(text.toLowerCase()) ||
              el.telefono.contains(text) ||
              el.correo.contains(text))
          .toList();
    }
    update();
  }

  void cleanBuscador() {
    _tecBuscador.text = '';
    buscador.value = '';
    _listClienteBuscador = _listCliente;
    update();
  }

  void obtenerClientes() {
    _listCliente.clear();
    FirebaseServices.databaseReference
        .child('clientes')
        .child(globalControllerUsuario.usuario.uid)
        .once()
        .then((snap) {
      _listCliente.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listCliente.add(Cliente.fromJson(key, value));
          _listClienteBuscador = _listCliente;
        });
      }
      _cargando = false;
      update();
    });
  }

  void crearCliente() {
    if (validarDatosCliente()) {
      crearClienteFirebase();
    }
  }

  void editarCliente(Cliente cliente) {
    if (validarDatosClienteEdit()) {
      editarClienteFirebase(cliente);
    }
  }

  void crearClienteFirebase() {
    progressDialog.show();
    Map value = {
      'nombre': _tecNombre.text,
      'correo': _tecEmail.text,
      'telefono': _tecTelefono.text,
      'fechaNacimiento': _tecFechaNacimiento.text,
      'rfc': _tecRFC.text.isEmpty ? '' : _tecRFC.text,
      'fechaCreado': DateTime.now().millisecondsSinceEpoch,
      'fechaModificado': DateTime.now().millisecondsSinceEpoch,
      'fechaEliminado': DateTime.now().millisecondsSinceEpoch,
    };
    FirebaseServices.databaseReference
        .child('clientes')
        .child(globalControllerUsuario.usuario.uid)
        .push()
        .set(value)
        .then((value) {
      obtenerClientes();
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          cleanInputsCreate();
          Get.back();
        });
      });
    }).catchError((onError) {
      closeDialogError(FirebaseErrors.erroresFirebase(onError.toString()));
    });
  }

  void editarClienteFirebase(Cliente cliente) {
    progressDialog.show();
    Map<String, dynamic> value = {
      'nombre': _tecNombreE.text,
      'correo': _tecEmailE.text,
      'telefono': _tecTelefonoE.text,
      'fechaNacimiento': _tecFechaNacimientoE.text,
      'rfc': _tecRFCE.text.isEmpty ? '' : _tecRFCE.text,
      'fechaCreado': DateTime.now().millisecondsSinceEpoch,
    };
    FirebaseServices.databaseReference
        .child('clientes')
        .child(globalControllerUsuario.usuario.uid)
        .child(cliente.id)
        .update(value)
        .then((value) {
      obtenerClientes();
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          cleanInputsCreate();
          Get.back();
        });
      });
    }).catchError((onError) {
      closeDialogError(FirebaseErrors.erroresFirebase(onError.toString()));
    });
  }

  void eliminarCliente(int index, Cliente cliente) {
    UtilsDialog.alertDialogTwoActions(
        Get.overlayContext,
        Strings.sEliminarCliente,
        Strings.sEliminarClienteConfirm,
        Strings.sEliminar,
        Strings.sCancelar, () {
      Get.back();
      progressDialog.show();
      FirebaseServices.databaseReference
          .child('clientes')
          .child(globalControllerUsuario.usuario.uid)
          .child(cliente.id)
          .remove()
          .then((value) {
        Future.delayed(const Duration(milliseconds: 300)).then((value) {
          progressDialog.hide().whenComplete(() {
            _listCliente.removeAt(index);
            update();
            cleanInputsEdit();
            Get.back();
          });
        });
      });
    }, () {
      Get.back();
    });
  }

  void closeDialogError(String error) {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      progressDialog.hide().whenComplete(() {
        UtilsDialog.alertDialogError(Get.overlayContext, error);
      });
    });
  }

  void cleanInputsCreate() {
    _tecNombre.clear();
    _tecEmail.clear();
    _tecTelefono.clear();
    _tecFechaNacimiento.clear();
    _tecRFC.clear();
  }

  void cleanInputsEdit() {
    _tecNombreE.clear();
    _tecEmailE.clear();
    _tecTelefonoE.clear();
    _tecFechaNacimientoE.clear();
    _tecRFCE.clear();
  }

  bool validarDatosCliente() {
    bool valido = true;
    if (_tecNombre.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreCliente);
    } else if (_tecEmail.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailCliente);
    } else if (!Utils.isEmail(_tecEmail.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailClienteFormat);
    } else if (_tecTelefono.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoCliente);
    } else if (_tecFechaNacimiento.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorFechaCliente);
    }
    return valido;
  }

  bool validarDatosClienteEdit() {
    bool valido = true;
    if (_tecNombreE.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorNombreCliente);
    } else if (_tecEmailE.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailCliente);
    } else if (!Utils.isEmail(_tecEmailE.text.trim())) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorEmailClienteFormat);
    } else if (_tecTelefonoE.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorTelefonoCliente);
    } else if (_tecFechaNacimientoE.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorFechaCliente);
    }
    return valido;
  }

  void showModalBirthDate(String type) {
    showCupertinoModalPopup(
        context: Get.overlayContext,
        builder: (_) {
          return ModalDate(
            type: type,
          );
        });
  }

  void setDateBirth(String date, String type) {
    if (type == 'create') {
      _birthDay = date.split(' ')[0];
      String day = _birthDay.split('-')[2];
      String month = _birthDay.split('-')[1];
      String year = _birthDay.split('-')[0];
      _tecFechaNacimiento.text = day + '-' + month + '-' + year;
    } else {
      _birthDay = date.split(' ')[0];
      String day = _birthDay.split('-')[2];
      String month = _birthDay.split('-')[1];
      String year = _birthDay.split('-')[0];
      _tecFechaNacimientoE.text = day + '-' + month + '-' + year;
    }
  }

  void toCreateCliente() {
    Get.to(() => CrearClientePage());
  }

  void toClienteDetail(int index, Cliente cliente) {
    _tecNombreE.text = cliente.nombre;
    _tecEmailE.text = cliente.correo;
    _tecTelefonoE.text = cliente.telefono;
    _tecFechaNacimientoE.text = cliente.fechaNacimiento;
    _tecRFCE.text = cliente.rfc;
    Get.to(() => DetalleClientePage(index: index, cliente: cliente));
  }
}
