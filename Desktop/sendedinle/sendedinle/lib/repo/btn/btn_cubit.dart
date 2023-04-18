import 'package:flutter/material.dart';

class BtnTiklama extends ChangeNotifier {
  bool tiklama = false;
  bool tiklama2 = false;

  tiklamaState() {
    tiklama = !tiklama;
    notifyListeners();
  }

  tiklamaState2() {
    tiklama2 = !tiklama2;
    notifyListeners();
  }

  tiklamaState2False() {
    tiklama2 = false;
    notifyListeners();
  }
}
