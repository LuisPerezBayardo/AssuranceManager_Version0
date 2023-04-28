class ArchivoPoliza {
  String id;
  String nombre;
  String tipo;
  String url;

  ArchivoPoliza();
  ArchivoPoliza.fromJson(String key, Map value) {
    id = key;
    nombre = value['nombre'];
    tipo = value['tipo'];
    url = value['url'];
  }
}
