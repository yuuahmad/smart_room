// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_room/components/kontanta_warna.dart';

class CardQuickSetting extends StatelessWidget {
  final String judulQuickSetting;
  const CardQuickSetting({Key? key, required this.judulQuickSetting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> iotDataUser =
        FirebaseFirestore.instance.collection('iot_data').doc(judulQuickSetting).snapshots();

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
            StreamBuilder<DocumentSnapshot>(
              stream: iotDataUser,
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
                // ignore: non_constant_identifier_names
                int? jumlah_relay = data['jumlah_relay'];
                if (jumlah_relay != null) {
                  return Row(
                    children: [
                      // ignore: unnecessary_null_comparison
                      for (var i = 1; i <= jumlah_relay; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              // ini container untuk notifikasi atas
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: data['relay_$i'] ? warnaPrimer : warnaPrimerpucat),
                                child: Column(children: [Icon(Icons.light, size: 40), Text("data")]),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    CollectionReference gantiDataIot =
                                        FirebaseFirestore.instance.collection('iot_data');
                                    data['relay_$i']
                                        ? gantiDataIot.doc(judulQuickSetting).update({'relay_$i': false})
                                        : gantiDataIot.doc(judulQuickSetting).update({'relay_$i': true});
                                  },
                                  child: Text("ON/OFF")),
                              // Text(data['relay_$i'].toString()),
                            ],
                          ),
                        )
                    ],
                  );
                } else {
                  return Text("tidak ada data");
                }

                // return Row(
                //     children: kondisiDevice.map((i) {
                //   int idx = kondisiDevice.indexOf(i);
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 5),
                //     child: ElevatedButton.icon(
                //         onPressed: () {
                //           FirebaseFirestore.instance
                //               .collection('iot_data')
                //               .doc(judulQuickSetting)
                //               .set(
                //                   i
                //                       ? {
                //                           // cara menulis sesuai dengan indexnya
                //                           'relay': kondisiDevice[idx] = false
                //                         }
                //                       : {'relay': kondisiDevice[idx] = true},
                //                   SetOptions(merge: true))
                //               .then((value) => print("User Added"))
                //               .catchError((error) => print("Failed to add user: $error"));
                //         },
                //         icon: Icon(Icons.meeting_room),
                //         label: Text("lampu-$idx ${i.toString()}")),
                //   );
                // }).toList());
                // return Text("data device anda: ${data['device_dimiliki']}}");
              },
            ),
          ],
        ));
  }
}
