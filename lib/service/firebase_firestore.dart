import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseFirestoreSaya extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const FirebaseFirestoreSaya(this.fullName, this.company, this.age, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? dapatkanNama = ;
    String? dapatkanUID = firebaseUser?.uid;

    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .doc(dapatkanUID)
          .set({
            'nama_pengguna': dapatkanNama,
            'uid_pengguna': dapatkanUID,
            'full_name': fullName,
            'company': company,
            'age': age,
            'device_dimiliki': ["device_rektor", "device_taman", "device_a"]
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: const Text(
        "Add User",
      ),
    );
  }
}
