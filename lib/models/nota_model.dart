class Nota {
  String id;
  String titulo;
  String contenido;
  int fechaCreado;
  int fechaModificado;
  int fechaEliminado;

  Nota();
  Nota.fromJson(String key, Map value) {
    id = key;
    titulo = value['titulo'];
    contenido = value['contenido'];
    fechaCreado = value['fechaCreado'];
    fechaModificado = value['fechaModificado'];
    fechaEliminado = value['fechaEliminado'];
  }
}
