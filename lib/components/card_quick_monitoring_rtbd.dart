// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_room/components/kontanta_warna.dart';

class CardQuickMonitoringRtbd extends StatelessWidget {
  final _databaseSaya = FirebaseDatabase.instance.ref();

  final String judulQuickMonitoringRtbd;
  CardQuickMonitoringRtbd({Key? key, required this.judulQuickMonitoringRtbd}) : super(key: key);

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
              judulQuickMonitoringRtbd,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder(
              // stream: _databaseSaya.child('data_iot_device').orderByKey().limitToLast(5).onValue,
              stream: _databaseSaya.child('data_iot_device/$judulQuickMonitoringRtbd').onValue,
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
                final jumlahSensor = deviceSaya['jumlah_sensor'];
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    for (var i = 1; i <= jumlahSensor; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            // ini container untuk notifikasi atas
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: warnaPrimer),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.ac_unit),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${deviceSaya['sensor_$i']}*C",
                                          style: TextStyle(fontSize: 30),
                                        )
                                      ],
                                    ),
                                    Text("sensor_$i"),
                                  ],
                                )),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       DatabaseReference gantiRelay =
                            //           _databaseSaya.child('data_iot_device/$judulQuickMonitoringRtbd/relay_$i');
                            //       try {
                            //         await deviceSaya['relay_$i'] ? gantiRelay.set(false) : gantiRelay.set(true);
                            //         print("berhasil ubah data");
                            //       } catch (e) {
                            //         print("terjadi sebuah kesalahan");
                            //       }
                            //     },
                            //     child: Text("ON/OFF")),
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
