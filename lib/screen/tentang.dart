import 'package:flutter/material.dart';

class Tentang extends StatefulWidget {
  const Tentang({Key? key}) : super(key: key);

  @override
  _TentangState createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tentang"),
        centerTitle: true,
      ),
    );
  }
}
