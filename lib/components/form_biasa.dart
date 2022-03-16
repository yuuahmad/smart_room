// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_room/components/kontanta_warna.dart';

// ignore: must_be_immutable
class FormBiasa extends StatelessWidget {
  final TextEditingController? formBiasaKontroller;
  IconData? ikonFormBiasa;
  String? teksFormBiasa;
  bool terlihatkah;

  FormBiasa(
      {Key? key,
      this.formBiasaKontroller,
      this.ikonFormBiasa,
      this.teksFormBiasa,
      this.terlihatkah = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
      decoration: BoxDecoration(
          color: warnaPrimerpucat, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        obscureText: terlihatkah,
        controller: formBiasaKontroller,
        decoration: InputDecoration(
          hintText: teksFormBiasa,
          border: InputBorder.none,
          icon: Icon(
            ikonFormBiasa,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
