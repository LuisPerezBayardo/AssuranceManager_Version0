import 'package:assurance/Firebase/firebase_services.dart';
import 'package:assurance/constants/constants.dart';
import 'package:assurance/constants/strings.dart';
import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/models/archivo_poliza_model.dart';
import 'package:assurance/models/aseguradora_model.dart';
import 'package:assurance/models/cliente_model.dart';
import 'package:assurance/models/poliza_model.dart';
import 'package:assurance/modules/inicio_clientes/pages/crear_cliente_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/agregar_documentos_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/crear_poliza_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_aseguradoras_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_clientes_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_date_polizas.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_widgets.dart/modal_generic_polizas.dart';
import 'package:assurance/utils/utils_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PolizasController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  //Poliza
  TextEditingController tecNumeroPoliza = TextEditingController();
  TextEditingController tecCobertura = TextEditingController();
  TextEditingController tecRamo = TextEditingController();
  TextEditingController tecAseguradora = TextEditingController();
  TextEditingController tecInciso = TextEditingController();
  TextEditingController tecFechaInicio = TextEditingController();
  TextEditingController tecFechaTerminacion = TextEditingController();
  TextEditingController tecFechaEmision = TextEditingController();
  TextEditingController tecFechaPago = TextEditingController();
  TextEditingController tecFormaPago = TextEditingController();
  TextEditingController tecMontoTotal = TextEditingController();
  TextEditingController tecEstatus = TextEditingController();
  //Cliente
  TextEditingController tecCliente = TextEditingController();
  //Automóvil
  TextEditingController tecAutoMarca = TextEditingController();
  TextEditingController tecAutoTipo = TextEditingController();
  TextEditingController tecAutoModelo = TextEditingController();
  TextEditingController tecAutoSerie = TextEditingController();
  TextEditingController tecAutoMotor = TextEditingController();
  TextEditingController tecAutoPlacas = TextEditingController();
  TextEditingController tecAutoResidente = TextEditingController();
  TextEditingController tecAutoLegalizado = TextEditingController();
  TextEditingController tecAutoAdaptaciones = TextEditingController();
  final TextEditingController _tecBuscador = TextEditingController();
  TextEditingController get tecBuscador => _tecBuscador;
  final TextEditingController _tecBuscadorA = TextEditingController();
  TextEditingController get tecBuscadorA => _tecBuscadorA;
  int _segmentedControlValue = 0;
  int get segmentedControlValue => _segmentedControlValue;
  ProgressDialog progressDialog;
  //Polizas
  List<Poliza> _listPoliza = [];
  List<Poliza> get listPoliza => _listPoliza;
  List<Poliza> _listPolizaBuscador = [];
  List<Poliza> get listPolizaBuscador => _listPolizaBuscador;
  bool cargando = true;
  //Clientes
  List<Cliente> _listCliente = [];
  List<Cliente> get listCliente => _listCliente;
  String idClienteSelected = '';
  //Aseguradoras
  List<Aseguradora> _listAseguradora = [];
  List<Aseguradora> get listAseguradora => _listAseguradora;
  List<Aseguradora> _listAseguradoraBuscador = [];
  List<Aseguradora> get listAseguradoraBuscador => _listAseguradoraBuscador;
  Aseguradora aseguradoraSelected = Aseguradora();
  //Constants
  List<String> listRamo = [
    Constants.ramoAuto,
    Constants.ramoHogar,
    Constants.ramoVida,
    Constants.ramoSalud,
  ];
  List<String> listEstatus = [
    Constants.estatusPagado,
    Constants.estatusPeriodoGracia,
    Constants.estatusVencido,
    Constants.estatusCancelado,
  ];
  List<String> listTipoAuto = [
    Constants.autoCoche,
    Constants.autoMoto,
    Constants.autoCiclomotor,
    Constants.autoFurgoneta,
    Constants.autoPickup,
  ];
  List<String> listSiNo = ['Si', 'No'];

  @override
  void onReady() {
    super.onReady();
    obtenerPolizas();
    obtenerAseguradoras();
    progressDialog = UtilsDialog.showProgresDialog(Get.overlayContext, false);
  }

  void onInputTextChange(String text) {
    if (text == '') {
      _listPolizaBuscador = _listPoliza;
    } else {
      _listPolizaBuscador = _listPoliza
          .where((el) =>
                  el.numero.toLowerCase().contains(text.toLowerCase()) ||
                  el.aseguradora.toLowerCase().contains(text.toLowerCase()) ||
                  el.clienteNombre.toLowerCase().contains(text.toLowerCase()) ||
                  el.fechaEmision.toLowerCase().contains(text.toLowerCase()) ||
                  el.cobertura.toLowerCase().contains(text.toLowerCase()) ||
                  el.inciso.toLowerCase().contains(text.toLowerCase())
              /*el.auto.marca.toLowerCase().contains(text) ||
              el.auto.modelo.toLowerCase().contains(text) ||
              el.auto.placas.toLowerCase().contains(text)*/
              )
          .toList();
    }
    update();
  }

  void onInputTextChangeAseguradoras(String text) {
    if (text == '') {
      _listAseguradoraBuscador = _listAseguradora;
    } else {
      _listAseguradoraBuscador = _listAseguradora
          .where((el) => el.nombre.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    update();
  }

  void cleanBuscador() {
    _tecBuscador.text = '';
    _listPolizaBuscador = _listPoliza;
    update();
  }

  void cleanBuscadorAseguradora() {
    _tecBuscadorA.text = '';
    _listAseguradoraBuscador = _listAseguradora;
    update();
  }

  void obtenerPolizas() {
    _listPoliza.clear();
    _listPolizaBuscador.clear();
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .once()
        .then((snap) {
      _listPoliza.clear();
      _listPolizaBuscador.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listPoliza.add(Poliza.fromJson(key, value));
          _listPolizaBuscador = _listPoliza;
        });
      }
      cargando = false;
      update();
    });
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
        });
      }
      update();
    });
  }

  void obtenerAseguradoras() {
    _listAseguradora.clear();
    _listAseguradoraBuscador.clear();
    FirebaseServices.databaseReference
        .child('aseguradoras')
        .orderByChild('nombre')
        .once()
        .then((snap) {
      _listAseguradora.clear();
      _listAseguradoraBuscador.clear();
      if (snap.exists) {
        snap.value.forEach((key, value) {
          _listAseguradora.add(Aseguradora.fromJson(key, value));
          _listAseguradoraBuscador = _listAseguradora;
        });
      }
      update();
    });
  }

  void crearPoliza({Poliza poliza}) {
    if (validarDatosPoliza()) {
      poliza == null
          ? crearPolizaFirebase()
          : crearPolizaFirebase(poliza: poliza);
    }
  }

  void crearPolizaFirebase({Poliza poliza}) {
    progressDialog.show();
    String idPoliza = poliza == null
        ? FirebaseServices.databaseReference.push().key
        : poliza.id;
    Map auto = {
      'marca': tecAutoMarca.text,
      'tipo': tecAutoTipo.text,
      'modelo': tecAutoModelo.text,
      'serie': tecAutoSerie.text,
      'motor': tecAutoMotor.text,
      'placas': tecAutoPlacas.text,
      'esResidente': tecAutoResidente.text,
      'esLegalizado': tecAutoLegalizado.text,
      'adaptaciones': tecAutoAdaptaciones.text
    };
    Map<String, dynamic> value = {
      'numero': tecNumeroPoliza.text,
      'ramo': tecRamo.text,
      'aseguradora': tecAseguradora.text,
      'cobertura': tecCobertura.text,
      'inciso': tecInciso.text,
      'fechaInicio': tecFechaInicio.text,
      'fechaTerminacion': tecFechaTerminacion.text,
      'fechaEmision': tecFechaEmision.text,
      'fechaPago': tecFechaPago.text,
      'formaPago': tecFormaPago.text,
      'estatus': tecEstatus.text,
      'montoTotal': tecMontoTotal.text,
      'clienteID': idClienteSelected,
      'clienteNombre': tecCliente.text,
    };
    if (tecRamo.text == 'Auto') value['auto'] = auto;
    print(idPoliza);
    print(value);
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(idPoliza)
        .update(value)
        .then((value) {
      idClienteSelected = '';
      obtenerPolizas();
      if (poliza == null) {
        Future.delayed(const Duration(milliseconds: 300)).then((value) {
          progressDialog.hide().whenComplete(() {
            UtilsDialog.alertDialogTwoActions(
                Get.overlayContext,
                Strings.sPolizaGuardada,
                Strings.sPolizaGuardadaText,
                Strings.sNo,
                Strings.sAgregregarArchivos, () {
              Get.back();
              Get.back();
            }, () {
              Get.back();
              Get.back();
              toAgregarArchivos(idPoliza);
            });
          });
        });
      } else {
        Get.back();
        Get.back();
      }
    }).catchError((onError) {});
  }

  void eliminarPoliza(int index, Poliza poliza) {
    UtilsDialog.alertDialogTwoActions(
        Get.overlayContext,
        Strings.sEliminarPoliza,
        Strings.sEliminarPolizaConfirm,
        Strings.sEliminar,
        Strings.sCancelar, () {
      Get.back();
      progressDialog.show();
      FirebaseServices.databaseReference
          .child('polizas')
          .child(globalControllerUsuario.usuario.uid)
          .child(poliza.id)
          .child('archivos')
          .once()
          .then((snap) {
        if (snap.exists) {
          snap.value.forEach((key, value) {
            ArchivoPoliza archivoPoliza = ArchivoPoliza.fromJson(key, value);
            FirebaseServices.storageReference.storage
                .refFromURL(archivoPoliza.url)
                .delete()
                .then((value) {});
          });
        }
        eliminarPolizaFirebase(index, poliza);
      });
    }, () {
      Get.back();
    });
  }

  void eliminarPolizaFirebase(int index, Poliza poliza) {
    FirebaseServices.databaseReference
        .child('polizas')
        .child(globalControllerUsuario.usuario.uid)
        .child(poliza.id)
        .remove()
        .then((value) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          _listPoliza.removeAt(index);
          update();
          Get.back();
        });
      });
    }).catchError((onError) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        progressDialog.hide().whenComplete(() {
          UtilsDialog.alertDialogError(
              Get.overlayContext, Strings.sEliminarPolizaError);
        });
      });
    });
  }

  bool validarDatosPoliza() {
    bool valido = true;
    if (tecNumeroPoliza.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaNumero);
    } else if (tecRamo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaRamo);
    } else if (tecAseguradora.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaAseguradora);
    } else if (tecCobertura.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaCobertura);
    } else if (tecInciso.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaInciso);
    } else if (tecFechaInicio.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaInicio);
    } else if (tecFechaTerminacion.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaTerminacion);
    } else if (tecFechaEmision.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaEmision);
    } else if (tecFechaPago.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFechaPago);
    } else if (tecFormaPago.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaFormaPago);
    } else if (tecEstatus.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaEstatus);
    } else if (tecMontoTotal.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMontoTotal);
    } else if (tecRamo.text == 'Auto') {
      if (validarDatosAutomovil()) {
        valido = validarDatosAutomovil();
      }
    }
    return valido;
  }

  bool validarDatosAutomovil() {
    bool valido = true;
    if (tecAutoMarca.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMarca);
    } else if (tecAutoTipo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaTipoAuto);
    } else if (tecAutoModelo.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaModeloAuto);
    } else if (tecAutoSerie.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaSerieAuto);
    } else if (tecAutoMotor.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaMotorAuto);
    } else if (tecAutoPlacas.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaPlacasAuto);
    } else if (tecAutoResidente.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaResidenteAuto);
    } else if (tecAutoLegalizado.text.trim().isEmpty) {
      valido = false;
      UtilsDialog.alertDialogError(
          Get.overlayContext, Strings.sErrorPolizaLegalizadoAuto);
    }
    return valido;
  }

  void showModalGeneric(String type, String title, List<String> options) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalGenericPolizas(
            type: type,
            title: title,
            options: options,
          );
        });
  }

  void showModalClientes(List<Cliente> listcliente) {
    obtenerClientes();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalClientesPolizas(
            clientes: listCliente,
          );
        });
  }

  void showModalAseguradora(List<Aseguradora> listAseguradora) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        context: Get.overlayContext,
        builder: (_) {
          return ModalAseguradorasPolizas(
            aseguradoras: listAseguradora,
          );
        });
  }

  void showModalDatePolizas(String type) {
    showCupertinoModalPopup(
        context: Get.overlayContext,
        builder: (_) {
          return ModalDatePolizas(
            type: type,
          );
        });
  }

  void selectOption(String type, int index) {
    switch (type) {
      case 'ramo':
        tecRamo.text = listRamo[index];
        Get.back();
        break;
      case 'estatus':
        tecEstatus.text = listEstatus[index];
        Get.back();
        break;
      case 'tipoAuto':
        tecAutoTipo.text = listTipoAuto[index];
        Get.back();
        break;
      case 'residente':
        tecAutoResidente.text = listSiNo[index];
        Get.back();
        break;
      case 'legalizado':
        tecAutoLegalizado.text = listSiNo[index];
        Get.back();
        break;
    }
    update();
  }

  void setDateBirth(String date, String type) {
    String fecha = date.split(' ')[0];
    String day = fecha.split('-')[2];
    String month = fecha.split('-')[1];
    String year = fecha.split('-')[0];
    switch (type) {
      case 'fechaInicio':
        tecFechaInicio.text = day + '-' + month + '-' + year;
        break;
      case 'fechaTerminacion':
        tecFechaTerminacion.text = day + '-' + month + '-' + year;
        break;
      case 'fechaEmision':
        tecFechaEmision.text = day + '-' + month + '-' + year;
        break;
      case 'fechaPago':
        tecFechaPago.text = day + '-' + month + '-' + year;
        break;
    }
  }

  void selectCliente(Cliente cliente, int index) {
    idClienteSelected = cliente.id;
    tecCliente.text = cliente.nombre;
    Get.back();
  }

  void selectAseguradora(Aseguradora aseguradora, int index) {
    aseguradoraSelected = aseguradora;
    tecAseguradora.text = aseguradoraSelected.nombre;
    Get.back();
  }

  void selectType(int value) {
    _segmentedControlValue = value;
    update();
  }

  void toAddPoliza() {
    _segmentedControlValue == 0 ? Get.to(() => CrearPolizaPage()) : null;
    cleanDataPolizaEdit();
  }

  void toEditPoliza(int index, Poliza poliza) {
    _segmentedControlValue == 0
        ? Get.to(() => CrearPolizaPage(
              index: index,
              poliza: poliza,
            ))
        : null;
    llenarDatosPolizaEdit(poliza);
  }

  void llenarDatosPolizaEdit(Poliza poliza) {
    tecNumeroPoliza.text = poliza.numero;
    tecRamo.text = poliza.ramo;
    tecAseguradora.text = poliza.aseguradora;
    tecCobertura.text = poliza.cobertura;
    tecInciso.text = poliza.inciso;
    tecFechaInicio.text = poliza.fechaInicio;
    tecFechaTerminacion.text = poliza.fechaTerminacion;
    tecFechaEmision.text = poliza.fechaEmision;
    tecFechaPago.text = poliza.fechaPago;
    tecFormaPago.text = poliza.formaPago;
    tecEstatus.text = poliza.estatus;
    tecMontoTotal.text = poliza.montoTotal;
    idClienteSelected = poliza.clienteID;
    tecCliente.text = poliza.clienteNombre;
    if (poliza.ramo == 'Auto') {
      tecAutoMarca.text = poliza.auto.marca;
      tecAutoTipo.text = poliza.auto.tipo;
      tecAutoModelo.text = poliza.auto.modelo;
      tecAutoSerie.text = poliza.auto.serie;
      tecAutoMotor.text = poliza.auto.motor;
      tecAutoPlacas.text = poliza.auto.placas;
      tecAutoResidente.text = poliza.auto.esResidente;
      tecAutoLegalizado.text = poliza.auto.esLegalizado;
      tecAutoAdaptaciones.text = poliza.auto.adaptaciones;
    }
    update();
  }

  void cleanDataPolizaEdit() {
    tecNumeroPoliza.text = '';
    tecRamo.text = '';
    tecAseguradora.text = '';
    tecCobertura.text = '';
    tecInciso.text = '';
    tecFechaInicio.text = '';
    tecFechaTerminacion.text = '';
    tecFechaEmision.text = '';
    tecFechaPago.text = '';
    tecFormaPago.text = '';
    tecEstatus.text = '';
    tecMontoTotal.text = '';
    idClienteSelected = '';
    tecCliente.text = '';
    tecAutoMarca.text = '';
    tecAutoTipo.text = '';
    tecAutoModelo.text = '';
    tecAutoSerie.text = '';
    tecAutoMotor.text = '';
    tecAutoPlacas.text = '';
    tecAutoResidente.text = '';
    tecAutoLegalizado.text = '';
    tecAutoAdaptaciones.text = '';
    update();
  }

  void toAgregarArchivos(String idPoliza) {
    Get.to(() => AgregarDocumentosPage(), arguments: idPoliza);
  }

  void toAddCliente() {
    Get.back();
    Get.to(() => CrearClientePage());
  }
}
