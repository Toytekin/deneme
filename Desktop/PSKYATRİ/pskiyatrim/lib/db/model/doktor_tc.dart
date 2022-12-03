import 'package:flutter/material.dart';

class DrTc extends ChangeNotifier {
  String _tc = '';

  tcVer(String gelenTc) {
    _tc = gelenTc;
    notifyListeners();
  }

  tcAl() {
    return _tc;
  }
}
