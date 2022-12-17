import 'package:flutter/material.dart';

class PuanArttirProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void puanVer() {
    _count = _count + 10;
    notifyListeners();
  }

  void puanAl() {
    _count = _count - 10;
    notifyListeners();
  }
}
