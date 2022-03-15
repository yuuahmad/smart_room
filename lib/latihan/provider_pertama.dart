// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => NaikkanAngka()),
//     ],
//     child: MyApp(),
//   ));
// }

class NaikkanAngka extends ChangeNotifier {
  int nilai = 0;
  int nilaikedua = 0;
  void tambah() {
    nilai++;
    notifyListeners();
  }

  void tambahkedua() {
    nilaikedua++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("jumlah nilai sekarang :"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${context.watch<NaikkanAngka>().nilai}',
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    '${context.watch<NaikkanAngka>().nilaikedua}',
                    style: TextStyle(fontSize: 35),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<NaikkanAngka>().tambah();
                      },
                      child: Text("tambah angka")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<NaikkanAngka>().tambahkedua();
                      },
                      child: Text("tambah angka"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
