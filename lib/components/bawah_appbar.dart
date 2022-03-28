// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/kontanta_warna.dart';

// ini adalah header pertama pada setiap halaman
// gunakan seperlunya saja karena akan terlalu meriah kalau
// sering digunakan.
class BawahAppbar extends StatelessWidget {
  final String judulBawahAppbar;
  const BawahAppbar({Key? key, required this.judulBawahAppbar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? dapatkanUrl = firebaseUser?.photoURL;
    Size ukuran = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: ukuran.height * 0.025),
      margin: EdgeInsets.only(bottom: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: warnaPrimer,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ukuran.width * 0.04, vertical: ukuran.height * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dapatkanUrl != null ? ClipOval(child: Image(image: NetworkImage(dapatkanUrl))) : Text("no photo"),
            Text(
              judulBawahAppbar,
              style: TextStyle(color: warnaTeksUtama, fontSize: ukuran.height * 0.04, fontWeight: FontWeight.w500),
            ),
            Text(
              "Siap Menggunakan Smart Room Itera?",
              style: TextStyle(
                color: warnaTeksUtama,
                fontSize: ukuran.height * 0.02,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardQuickMonitoring extends StatelessWidget {
  final String judulQuickMonitoring;
  const CardQuickMonitoring({Key? key, required this.judulQuickMonitoring}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judulQuickMonitoring,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < 7; i++)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          print("lampu ke-${i + 1} ditekan");
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                          child: Column(children: [
                            Icon(
                              Icons.light,
                              size: 55,
                            ),
                            Text(
                              "Lampu ${i + 1}",
                              style: TextStyle(fontSize: 18),
                            )
                          ]),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ));
  }
}
