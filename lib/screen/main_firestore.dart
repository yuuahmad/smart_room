// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps
// cari todo app buat aplikasi ini
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainFirestore extends StatefulWidget {
  MainFirestore({Key? key}) : super(key: key);

  @override
  _MainFirestoreState createState() => _MainFirestoreState();
}

class _MainFirestoreState extends State<MainFirestore> {
  final kataQuotes = TextEditingController();
  final pengarang = TextEditingController();
  final dataQuotes = <String>["pertama"]; //jika ganjil bearti quotes dan jika genap bearti pengarang
  int penghitung = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    kataQuotes.dispose();
    pengarang.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Main Firestore"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("tuliskan quotes anda disini"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: kataQuotes,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: pengarang,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print("${kataQuotes.text} dengan pengarang ${pengarang.text}");
                    }
                    setState(() {
                      kataQuotes.text;
                      pengarang.text;
                      dataQuotes.add(kataQuotes.text);
                      penghitung++;
                    });
                  },
                  child: Text('tampiklan data')),
              // Text("${kataQuotes.text} dengan pengarang ${pengarang.text}"),
              for (var i = 0; i < dataQuotes.length; i++)
                ListTile(
                  title: Text(dataQuotes[i].toString()),
                )
            ],
          ),
        ),
      ),
    );
  }
}
