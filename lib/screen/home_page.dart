// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_room/components/bawah_appbar.dart';
import 'package:smart_room/components/kontanta_warna.dart';
import 'package:smart_room/service/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
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
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
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
        appBar: AppBar(
          backgroundColor: warnaPrimer,
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.ac_unit_sharp,
                  color: Colors.white,
                ))
          ],
          elevation: 0,
        ),
        body: BawahAppbar());
  }
}

class ListTileSaya extends StatelessWidget {
  final String judulTile;
  final IconData iconTile;
  final String keHalaman;

  const ListTileSaya(
      {Key? key,
      required this.judulTile,
      required this.iconTile,
      required this.keHalaman})
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
