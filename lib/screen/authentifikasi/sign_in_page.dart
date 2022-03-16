// ignore_for_file: prefer_const_constructors

import 'package:smart_room/components/button_biasa.dart';
import 'package:smart_room/components/form_biasa.dart';
import 'package:smart_room/service/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(0, ukuran.height * 0.2, 0, 20),
              child: Image(
                  image: AssetImage('images/tampilan ikon round fix.png'),
                  height: ukuran.height * 0.2),
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
          ],
        ),
      ),
    );
  }
}
