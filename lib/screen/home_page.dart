// ignore_for_file: avoid_print, prefer_const_constructors
import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/bawah_appbar.dart';
import 'package:smart_room/components/card_quick_setting.dart';
import 'package:smart_room/components/kontanta_warna.dart';
import 'package:smart_room/service/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  final _aspectTolerance = 0.00;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  Widget build(BuildContext context) {
    // scanresult data
    // data firebase
    final firebaseUser = context.watch<User?>();
    String? namaPengguna = firebaseUser?.displayName;
    String? tampilkanUID = firebaseUser?.uid;
    String? emailPengguna = firebaseUser?.email;

// ini adalah alamat untuk database user pada umumnya
    final Stream<DocumentSnapshot> users = FirebaseFirestore.instance.collection('users').doc(tampilkanUID).snapshots();
    CollectionReference dataUsers = FirebaseFirestore.instance.collection('users');

    dataUsers.doc(tampilkanUID).set({
      'nama_pengguna': namaPengguna ?? "#noName",
      'uid_pengguna': tampilkanUID,
      'email': emailPengguna,
    }, SetOptions(merge: true));

    // dataUsers.doc(tampilkanUID).update({
    //   'device_dimiliki': [hasilScan]
    // });

    // users.doc(tampilkanUID).get().then((DocumentSnapshot documentSnapshot) async {
    //   if (documentSnapshot.exists) {
    //     namaDariFirestore = 'Document data: ${documentSnapshot.data()}';
    //   } else {
    //     namaDariFirestore = 'Document does not exist on the database';
    //   }
    // });

    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ScanBarcode()));
        //   },
        //   child: Icon(Icons.add),
        // ),
        // kode utuk drawer bagian samping. kalau dilihat sekilas memang ruwet
        // karena memang ruwet pada dasarnya
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: warnaPrimer,
                ),
                child: Center(
                    child: Text(
                  'Drawer Header',
                  style: TextStyle(fontSize: 20, color: warnaTeksUtama),
                )),
              ),
              ListTileSaya(
                keHalaman: '/semuaDevice',
                iconTile: Icons.device_hub,
                judulTile: "Semua Device",
              ),
              ListTileSaya(
                keHalaman: '/monitoring',
                iconTile: Icons.analytics,
                judulTile: "Monitoring",
              ),
              ListTileSaya(
                keHalaman: '/caraPakai',
                iconTile: Icons.book,
                judulTile: "Cara Pakai",
              ),
              ListTileSaya(
                keHalaman: '/tentang',
                iconTile: Icons.perm_device_information,
                judulTile: "Tentang",
              ),
              ListTileSaya(
                keHalaman: '/pengaturan',
                iconTile: Icons.settings,
                judulTile: "Pengaturan",
              ),
              ListTileSaya(
                keHalaman: '/cobaFirestore',
                iconTile: Icons.format_list_numbered,
                judulTile: "Coba Firestore",
              ),
              ListTileSaya(
                keHalaman: '/mainFirestore',
                iconTile: Icons.car_rental,
                judulTile: "Main Firestore",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 2),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return warnaSekunder.withOpacity(0.5);
                          }
                          return warnaSekunder; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      context.read<AuthService>().keluar();
                    },
                    child: Text("Keluar Akun")),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: dataUsers.doc(tampilkanUID).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return BawahAppbar(judulBawahAppbar: "Hai Yang Disana");
                    // return Text("Something went wrong");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return BawahAppbar(judulBawahAppbar: "Siapa Anda?");
                    // return Text(snapshot.data.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return BawahAppbar(judulBawahAppbar: "${data['nama_pengguna']}");
                    // return Text("Full Name: ${data['nama_pengguna']}}");
                  }
                  return Text("loading");
                },
              ),
              // awal dari list yang banyak
              StreamBuilder<DocumentSnapshot>(
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
                        children: daftarDevice
                            .map((i) => CardQuickSetting(
                                  judulQuickSetting: i,
                                ))
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
              ElevatedButton(
                  onPressed: () {
                    _scan(tampilkanUID!);
                  },
                  child: Text("scan dan tambah"))
            ],
          ),
        ));
  }

  Future<void> _scan(String inputUID) async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      result.rawContent.isNotEmpty
          ? FirebaseFirestore.instance.collection('users').doc(inputUID).update({
              'device_dimiliki': FieldValue.arrayUnion([result.rawContent])
            })
          : print("data tidak ditemukan");
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}

// ini adalah list tile untuk drawer
class ListTileSaya extends StatelessWidget {
  final String judulTile;
  final IconData iconTile;
  final String keHalaman;
  const ListTileSaya({Key? key, required this.judulTile, required this.iconTile, required this.keHalaman})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(iconTile, size: 24),
      title: Text(
        judulTile,
        style: TextStyle(fontSize: 17),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, keHalaman);
      },
    );
  }
}
