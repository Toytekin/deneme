// ignore: file_names
import 'package:flutter/material.dart';

class TemaProvider with ChangeNotifier {
  int _temaSec = 0;

  int get count => _temaSec;

  void beyazTeme() {
    _temaSec = 0;
    notifyListeners();
  }

  void siyahTema() {
    _temaSec = 1;
    notifyListeners();
  }
}
