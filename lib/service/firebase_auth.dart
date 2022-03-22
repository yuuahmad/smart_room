import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);

  Stream<User?> get keadaanUser => _firebaseAuth.authStateChanges();

  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }

  Future<String?> masukApp({required String inputemail, required String inputpass}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: inputemail, password: inputpass);
      return "berhasil masuk";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> daftarApp({required String inputemail, required String inputpass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: inputemail, password: inputpass);
      return "berhasil daftar";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> keluar() async {
    await FirebaseAuth.instance.signOut();
    return "berhasil keluar";
  }
}
