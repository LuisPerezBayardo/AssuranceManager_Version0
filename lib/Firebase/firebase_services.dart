import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static FirebaseDatabase database;
  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  static FirebaseStorage storage;
  static var storageReference = FirebaseStorage.instance.ref();
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static var firebaseUser;
  static String uidUsuario;

  static String getUID() => FirebaseAuth.instance.currentUser.uid;
}
