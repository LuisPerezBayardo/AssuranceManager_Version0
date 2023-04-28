import 'package:assurance/constants/constants.dart';

class Usuario {
  String uid;
  String avatar = Constants.urlProfileGeneric;
  bool borrado;
  String correo;
  bool correoBirthday;
  bool correoChristmas;
  bool correoNewYear;
  bool correoRecordatorioPagos;
  int fechaCreado;
  int fechaModificado;
  String nombre;
  String rfc;
  String telefono;

  Usuario();
  Usuario.fromJson(String key, Map value) {
    uid = key;
    String avt = value['avatar'];
    if (avt.length > 0) {
      avatar = value['avatar'];
    }
    borrado = value['borrado'];
    correo = value['correo'];
    correoBirthday = value['correoBirthday'];
    correoChristmas = value['correoChristmas'];
    correoNewYear = value['correoNewYear'];
    correoRecordatorioPagos = value['correoRecordatorioPagos'];
    fechaCreado = value['fechaCreado'];
    fechaModificado = value['fechaModificado'];
    nombre = value['nombre'];
    rfc = value['rfc'];
    telefono = value['telefono'];
  }
}
