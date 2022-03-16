import 'package:flutter/material.dart';

class SemuaDevices extends StatefulWidget {
  const SemuaDevices({Key? key}) : super(key: key);

  @override
  _SemuaDevicesState createState() => _SemuaDevicesState();
}

class _SemuaDevicesState extends State<SemuaDevices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("semua devices"),
        centerTitle: true,
      ),
    );
  }
}
