import 'package:flutter/material.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({Key? key}) : super(key: key);

  @override
  _PengaturanAkunState createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  final TextEditingController ubahNamaAkun = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Pengaturan Akun"),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
