import 'package:assurance/models/auto_model.dart';

class Poliza {
  String id;
  String aseguradora;
  Auto auto;
  String clienteID;
  String clienteNombre;
  String cobertura;
  String estatus;
  String fechaEmision;
  String fechaInicio;
  String fechaPago;
  String fechaTerminacion;
  String formaPago;
  String inciso;
  String montoTotal;
  String numero;
  String ramo;

  Poliza();
  Poliza.fromJson(String key, Map value) {
    id = key;
    aseguradora = value['aseguradora'];
    if (value['auto'] != null) {
      auto = Auto.fromJson(value['auto']);
    }
    clienteID = value['clienteID'];
    clienteNombre = value['clienteNombre'];
    cobertura = value['cobertura'];
    estatus = value['estatus'];
    fechaEmision = value['fechaEmision'];
    fechaInicio = value['fechaInicio'];
    fechaPago = value['fechaPago'];
    fechaTerminacion = value['fechaTerminacion'];
    formaPago = value['formaPago'];
    inciso = value['inciso'];
    montoTotal = value['montoTotal'];
    numero = value['numero'];
    ramo = value['ramo'];
  }
}
