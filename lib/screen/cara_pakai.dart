import 'package:flutter/material.dart';

class CaraPakai extends StatefulWidget {
  const CaraPakai({Key? key}) : super(key: key);

  @override
  _CaraPakaiState createState() => _CaraPakaiState();
}

class _CaraPakaiState extends State<CaraPakai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cara pakai"),
        centerTitle: true,
      ),
    );
  }
}
