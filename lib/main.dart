// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: WraperAuth());
  }
}

class WraperAuth extends StatefulWidget {
  const WraperAuth({Key? key}) : super(key: key);

  @override
  _WraperAuthState createState() => _WraperAuthState();
}

class _WraperAuthState extends State<WraperAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wraper page'),
      ),
      body: Center(
        child: Container(
          child: Text('untuk di hapus nanti kalau sudah jadi backenddnya'),
        ),
      ),
    );
  }
}
