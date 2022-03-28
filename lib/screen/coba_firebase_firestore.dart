// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/card_quick_setting.dart';

class CobaFirebaseFirestore extends StatefulWidget {
  const CobaFirebaseFirestore({Key? key}) : super(key: key);

  @override
  _CobaFirebaseFirestoreState createState() => _CobaFirebaseFirestoreState();
}

class _CobaFirebaseFirestoreState extends State<CobaFirebaseFirestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("coba firestore"),
          centerTitle: true,
        ),
        body: QuickSettingFirestore());
  }
}

class QuickSettingFirestore extends StatefulWidget {
  const QuickSettingFirestore({Key? key}) : super(key: key);

  @override
  _QuickSettingFirestoreState createState() => _QuickSettingFirestoreState();
}

class _QuickSettingFirestoreState extends State<QuickSettingFirestore> {
  // final Stream<QuerySnapshot> _usersStream =
  // FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? dapatkanUID = firebaseUser?.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(dapatkanUID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("terjadi kesalahan");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          List daftarDevice = data['device_dimiliki'];
          return ListView.builder(
            itemCount: daftarDevice.length,
            itemBuilder: (context, i) {
              return ListTile(title: CardQuickSetting(judulQuickSetting: daftarDevice[i]));
            },
          );
        }
        return Text("Loading");
      },
    );
  }
}
