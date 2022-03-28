// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_room/components/kontanta_warna.dart';

class CardQuickSettingRtbd extends StatelessWidget {
  final _databaseSaya = FirebaseDatabase.instance.ref();

  final String judulQuickSettingRtbd;
  CardQuickSettingRtbd({Key? key, required this.judulQuickSettingRtbd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judulQuickSettingRtbd,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
              // stream: _databaseSaya.child('data_iot_device').orderByKey().limitToLast(5).onValue,
              stream: _databaseSaya.child('data_iot_device/$judulQuickSettingRtbd').onValue,
              initialData: null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("terjadi kesalahan dalam mengambil data");
                  // return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                final deviceSaya = Map<String, dynamic>.from((snapshot.data!).snapshot.value);
                print(deviceSaya);
                final jumlahRelay = deviceSaya['jumlah_relay'];
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      //   children:
                      //     deviceSaya.forEach((key, value) {
                      //   for (var i = 0; i <= deviceSaya['jumlah_relay']; i++) {}
                      //   final deviceTile = Container(
                      //     children: [
                      //       for (var i = 1; i <= deviceSaya['jumlah_relay']; i++)
                      //         Column(
                      //           children: [
                      //             Text("relay $i : ${deviceSaya['relay_$i']}  "),
                      //             ElevatedButton(
                      //                 onPressed: () {
                      //                   deviceSaya['relay_$i'];
                      //                 },
                      //                 child: Text("ubah relay_$i")),
                      //           ],
                      //         )
                      //     ],
                      //   );
                      // })
                      children: [
                        for (var i = 1; i <= jumlahRelay; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                // ini container untuk notifikasi atas
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: deviceSaya['relay_$i'] ? warnaPrimer : warnaPrimerpucat),
                                  child: Column(children: [Icon(Icons.light, size: 40), Text("data")]),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      DatabaseReference gantiRelay =
                                          _databaseSaya.child('data_iot_device/$judulQuickSettingRtbd/relay_$i');
                                      try {
                                        await deviceSaya['relay_$i'] ? gantiRelay.set(false) : gantiRelay.set(true);
                                        print("berhasil ubah data");
                                      } catch (e) {
                                        print("terjadi sebuah kesalahan");
                                      }
                                      // CollectionReference gantiDataIot =
                                      //     FirebaseFirestore.instance.collection('iot_data');
                                      // deviceSaya['relay_$i']
                                      //     ? gantiDataIot.doc(judulQuickSetting).update({'relay_$i': false})
                                      //     : gantiDataIot.doc(judulQuickSetting).update({'relay_$i': true});
                                    },
                                    child: Text("ON/OFF")),
                                // Text(data['relay_$i'].toString()),
                              ],
                            ),
                          )
                      ]),
                );
              },
            )
          ],
        ));
  }
}
