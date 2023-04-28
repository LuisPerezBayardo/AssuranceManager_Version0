class Aseguradora {
  String id;
  String nombre;

  Aseguradora();
  Aseguradora.fromJson(String key, Map value) {
    id = key;
    nombre = value['nombre'];
  }
}
