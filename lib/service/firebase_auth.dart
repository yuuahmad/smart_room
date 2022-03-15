import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);

  Future<String?> masukApp(
      {required String inputemail, required String inputpass}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: inputemail, password: inputpass);
      return "berhasil masuk";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> daftarApp(
      {required String inputemail, required String inputpass}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: inputemail, password: inputpass);
      return "berhasil daftar";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
