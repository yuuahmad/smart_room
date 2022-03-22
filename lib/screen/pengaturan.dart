// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key? key}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? dapatkanNama = firebaseUser?.displayName;
    String? dapatkanUrl = firebaseUser?.photoURL;
    String? dapatkanUid = firebaseUser?.uid;
    String? dapatkanemail = firebaseUser?.email;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Pengaturan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dapatkanUrl != null ? ClipOval(child: Image(image: NetworkImage(dapatkanUrl))) : Text("no photo"),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dapatkanNama != null
                            ? Text(
                                dapatkanNama,
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "Yang Disana",
                                style: TextStyle(fontSize: 25),
                              ),
                        dapatkanemail != null
                            ? Text(
                                dapatkanemail,
                                style: TextStyle(fontSize: 15),
                              )
                            : Text(
                                "Email Anda",
                                style: TextStyle(fontSize: 15),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "UID: ${dapatkanUid!}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 3,
                color: Colors.black45,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/pengaturanAkun');
              },
              title: Text("Pengaturan Akun"),
              trailing: Icon(Icons.person),
            ),
            ListTile(
              onTap: () {},
              title: Text("Dark Mode"),
              trailing: Icon(Icons.sunny),
            ),
            ListTile(
              onTap: () {},
              title: Text("Aktifkan Notifikasi"),
              trailing: Icon(Icons.notifications_active),
            ),
            ListTile(
              onTap: () {},
              title: Text("Set Batas Pemakaian Listrik"),
              trailing: Icon(Icons.publish_rounded),
            ),
            ListTile(
              onTap: () {},
              title: Text("Request Pengaktifan Akun"),
              trailing: Icon(Icons.key),
            ),
            ListTile(
              onTap: () {},
              title: Text("Laporkan Bug Aplikasi"),
              trailing: Icon(Icons.bug_report),
            ),
            ListTile(
              onTap: () {},
              title: Text("Laporkan Bug Hardware"),
              trailing: Icon(Icons.factory),
            ),
          ],
        ),
      ),
    );
  }
}
