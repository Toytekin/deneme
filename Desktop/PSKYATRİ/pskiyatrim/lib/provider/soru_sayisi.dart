import 'package:flutter/material.dart';

class SoruSayisiProvider extends ChangeNotifier {
  bool cevapVerildimi = false;

  cevapVer() {
    cevapVerildimi = true;
    notifyListeners();
  }

  cevaplariSil() {
    cevapVerildimi = false;
    notifyListeners();
  }

  cevap() {
    return cevapVerildimi;
  }
}
