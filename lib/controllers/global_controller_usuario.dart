import 'package:assurance/Firebase/firebase_errors.dart';
import 'package:assurance/models/usuario_model.dart';
import 'package:get/get.dart';

class GlobalControllerUsuario extends GetxController {
  Usuario _usuario = Usuario();
  Usuario get usuario => _usuario;
  bool _cargando = true;
  bool get cargando => _cargando;
  bool _error = false;
  bool get error => _error;
  String _errorString = '';
  String get errorString => _errorString;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    _cargando = false;
    _error = false;
    _errorString = '';
    update();
  }

  Usuario getUsuario() {
    return _usuario;
  }

  void setUsuarioError(String error) {
    _cargando = false;
    _error = true;
    _errorString = FirebaseErrors.erroresFirebase(error);
    update();
  }
}
