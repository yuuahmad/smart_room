// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_room/components/kontanta_warna.dart';

class ButtonBiasa extends StatelessWidget {
  final String namaButton;
  final void Function()? aksiKetikaDitekan;
  final IconData? ikonButton;
  const ButtonBiasa(
      {Key? key,
      required,
      required this.namaButton,
      required this.aksiKetikaDitekan,
      this.ikonButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      decoration: BoxDecoration(
          color: warnaPrimer,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: TextButton(
        onPressed: aksiKetikaDitekan,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              namaButton,
              style: TextStyle(
                color: warnaTeksUtama,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                ikonButton,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
