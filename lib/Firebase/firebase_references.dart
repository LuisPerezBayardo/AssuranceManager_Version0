import 'package:assurance/Firebase/firebase_services.dart';

class FirebaseReferences {
  //Database Reference
  static var dbRefUsuarios =
      FirebaseServices.databaseReference.child('usuarios');
}
