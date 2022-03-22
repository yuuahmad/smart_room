// ignore_for_file: prefer_const_constructors

import 'package:smart_room/components/button_biasa.dart';
import 'package:smart_room/components/form_biasa.dart';
import 'package:smart_room/service/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ini adalah halaman sign in yang ditampilkan pada awal masuk app
class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size ukuran = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(0, ukuran.height * 0.2, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('images/tampilan ikon round fix.png'), height: ukuran.height * 0.18),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("x", style: TextStyle(fontSize: 60, color: Colors.black38)),
                  ),
                  Image(image: AssetImage('images/logo itera.png'), height: ukuran.height * 0.18),
                ],
              ),
            ),
            FormBiasa(
              formBiasaKontroller: emailController,
              teksFormBiasa: "Email",
              ikonFormBiasa: Icons.email,
            ),
            FormBiasa(
              formBiasaKontroller: passwordController,
              terlihatkah: true,
              teksFormBiasa: "Password",
              ikonFormBiasa: Icons.password,
            ),
            ButtonBiasa(
              ikonButton: Icons.download,
              namaButton: "MASUK DENGAN EMAIL ITERA",
              aksiKetikaDitekan: () {
                context.read<AuthService>().masukApp(
                      inputemail: emailController.text.trim(),
                      inputpass: passwordController.text.trim(),
                    );
              },
            ),
            ButtonBiasa(
              ikonButton: Icons.account_box_outlined,
              namaButton: "MASUK DENGAN GOOGLE",
              aksiKetikaDitekan: () {
                AuthService.signInWithGoogle();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("anda belum memiliki akun?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: Text("daftar disini"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
