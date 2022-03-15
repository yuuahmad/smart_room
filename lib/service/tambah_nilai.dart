import 'package:flutter/material.dart';

class Penghitung extends ChangeNotifier {
  int nilai = 0;
  void tambahnilai() {
    nilai++;
    notifyListeners();
  }
}
