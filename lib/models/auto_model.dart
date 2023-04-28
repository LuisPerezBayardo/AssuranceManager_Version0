class Auto {
  String adaptaciones;
  String esLegalizado;
  String esResidente;
  String marca;
  String modelo;
  String motor;
  String placas;
  String serie;
  String tipo;

  Auto();
  Auto.fromJson(Map value) {
    adaptaciones = value['adaptaciones'];
    esLegalizado = value['esLegalizado'];
    esResidente = value['esResidente'];
    marca = value['marca'];
    modelo = value['modelo'];
    motor = value['motor'];
    placas = value['placas'];
    serie = value['serie'];
    tipo = value['tipo'];
  }
}
