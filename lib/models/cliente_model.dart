class Cliente {
  String id;
  String correo;
  String fechaNacimiento;
  int fechaCreado;
  int fechaModificado;
  int fechaEliminado;
  String nombre;
  String rfc;
  String telefono;

  Cliente();
  Cliente.fromJson(String key, Map value) {
    id = key;
    correo = value['correo'];
    fechaNacimiento = value['fechaNacimiento'];
    fechaCreado = value['fechaCreado'];
    fechaModificado = value['fechaModificado'];
    fechaEliminado = value['fechaEliminado'];
    nombre = value['nombre'];
    rfc = value['rfc'];
    telefono = value['telefono'];
  }
}
