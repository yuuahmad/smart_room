// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, avoid_print
// cari todo app buat aplikasi ini

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/card_quick_monitoring_rtbd.dart';
import 'package:smart_room/components/card_quick_setting_rtbd.dart';

class MainRtbd extends StatefulWidget {
  MainRtbd({Key? key}) : super(key: key);

  @override
  _MainRtbdState createState() => _MainRtbdState();
}

class _MainRtbdState extends State<MainRtbd> {
  final _databaseSaya = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? tampilkanUID = firebaseUser?.uid;

    final Stream<DocumentSnapshot> users = FirebaseFirestore.instance.collection('users').doc(tampilkanUID).snapshots();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Main realtime database update"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: users,
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("terjadi kesalahan dalam mengambil data");
              // return Text("Something went wrong");
            }
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("berhasil menghubungi server namun tidak ditemukan data");
              // return Text(snapshot.data.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            List? daftarDevice = data['device_dimiliki'];
            // ignore: unnecessary_null_comparison
            if (daftarDevice != null && daftarDevice.isNotEmpty) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: daftarDevice
                      .map((i) => Column(children: [
                            CardQuickSettingRtbd(judulQuickSettingRtbd: i),
                            CardQuickMonitoringRtbd(judulQuickMonitoringRtbd: i)
                          ]))
                      .toList());
            } else {
              return Container(
                  margin: EdgeInsets.all(120),
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "oops!?!? sepertinya anda belum memiliki device, scan barcode yang tertempel pada alat untuk menambahkannya",
                    style: TextStyle(fontSize: 16),
                  ));
            }
          },
        ),
      ),
    );
  }
}
