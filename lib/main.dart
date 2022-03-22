// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

// import semua package yang ada dan diperlukan
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_room/screen/authentifikasi/sign_in_page.dart';
import 'package:smart_room/screen/authentifikasi/sign_up_page.dart';
import 'package:smart_room/screen/cara_pakai.dart';
import 'package:smart_room/screen/home_page.dart';
import 'package:smart_room/screen/main_firestore.dart';
import 'package:smart_room/screen/monitoring.dart';
import 'package:smart_room/screen/pengaturan.dart';
import 'package:smart_room/screen/semua_device.dart';
import 'package:smart_room/screen/sub_pengturan/pengaturan_akun.dart';
import 'package:smart_room/screen/tentang.dart';
import 'package:smart_room/service/coba_firebase_firestore.dart';
import 'package:smart_room/service/firebase_auth.dart';
import 'firebase_options.dart';

// jalankan perintah utama #main.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(create: (_) => AuthService(FirebaseAuth.instance)),
      StreamProvider(create: (context) => context.read<AuthService>().keadaanUser, initialData: null)
    ],
    child: MyApp(),
  ));
}

// buat stateles mypp yang menginisialisasi aplikasi ketika pertama kali
// dijalankan dan melakukan setting awal pada material app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/semuaDevice': (context) => SemuaDevices(),
          '/monitoring': (context) => Monitoring(),
          '/caraPakai': (context) => CaraPakai(),
          '/tentang': (context) => Tentang(),
          '/pengaturan': (context) => Pengaturan(),
          '/cobaFirestore': (context) => CobaFirebaseFirestore(),
          '/mainFirestore': (context) => MainFirestore(),
          '/signUp': (context) => SignUpPage(),
          '/pengaturanAkun': (context) => PengaturanAkun(),
        },
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Color.fromARGB(255, 195, 165, 71)),
            scaffoldBackgroundColor: Color.fromARGB(255, 231, 231, 231),
            primaryColor: Color.fromARGB(255, 107, 87, 25)),
        debugShowCheckedModeBanner: false,
        title: 'smart room itera',
        home: WraperAuth());
  }
}

// stateful wparer untuk menentukan arah apakah user ada atau tidak
// kalau ada, langsung masuk ke home page. dan kalau tidak ada masuk ke login page.
class WraperAuth extends StatefulWidget {
  const WraperAuth({Key? key}) : super(key: key);
  @override
  _WraperAuthState createState() => _WraperAuthState();
}

class _WraperAuthState extends State<WraperAuth> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomePage();
    } else {
      return SignInPage();
    }
  }
}
