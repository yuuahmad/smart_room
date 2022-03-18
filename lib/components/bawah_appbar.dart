// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/kontanta_warna.dart';

class BawahAppbar extends StatelessWidget {
  const BawahAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? nama = firebaseUser?.displayName;
    String? tampilkanUID = firebaseUser?.uid;
    String? emailPengguna = firebaseUser?.email;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(tampilkanUID).set({
      'nama_pengguna': nama,
      'uid_pengguna': tampilkanUID,
      'email': emailPengguna,
    }, SetOptions(merge: true));
    Size ukuran = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: ukuran.height * 0.18,
            width: double.infinity,
            decoration: BoxDecoration(
                color: warnaPrimer,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: ukuran.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Hai $nama",
                    style:
                        TextStyle(color: warnaTeksUtama, fontSize: ukuran.height * 0.04, fontWeight: FontWeight.w500),
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
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class CardQuickSetting extends StatelessWidget {
  final String judulQuickSetting;
  const CardQuickSetting({Key? key, required this.judulQuickSetting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _kontrolDevice = FirebaseFirestore.instance.collection('iot_data').snapshots();

    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judulQuickSetting,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _kontrolDevice,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Text((data['lampu_1']).toString()),
                          subtitle: Text((data['lampu_2']).toString()),
                        );
                      }).toList(),
                    );
                  },
                )
                // child: Row(
                //   children: [
                //     for (var i = 0; i < 7; i++)
                //       Container(
                //         padding: EdgeInsets.symmetric(horizontal: 10),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             print("lampu ke-${i + 1} ditekan");
                //           },
                //           child: Container(
                //             margin:
                //                 EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                //             child: Column(children: [
                //               Icon(
                //                 Icons.light,
                //                 size: 55,
                //               ),
                //               Text(
                //                 "Lampu ${i + 1}",
                //                 style: TextStyle(fontSize: 18),
                //               )
                //             ]),
                //           ),
                //         ),
                //       ),
                //   ],
                // ),
                )
          ],
        ));
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
