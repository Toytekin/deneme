import 'package:flutter/material.dart';

class SiklarinTiklanmasiProvider extends ChangeNotifier {
  bool aTiklandi = false;
  bool bTiklandi = false;
  bool cTiklandi = false;
  bool dTiklandi = false;
  bool eTiklandi = false;
  int soruSayisi = 0;

  soruSayisiAl() {
    return soruSayisi;
  }

  tumunuTemizle() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
    notifyListeners();
  }

  soruArttir() {
    soruSayisi = soruSayisi + 1;
    notifyListeners();
  }

  bool aTiklamaSonuc() {
    return aTiklandi;
  }

  bool bTiklamaSonuc() {
    return bTiklandi;
  }

  bool cTiklamaSonuc() {
    return cTiklandi;
  }

  bool dTiklamaSonuc() {
    return dTiklandi;
  }

  bool eTiklamaSonuc() {
    return eTiklandi;
  }

  atikla() {
    // ignore: unused_local_variable
    aTiklandi = true;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
    notifyListeners();
  }

  btikla() {
    aTiklandi = false;
    bTiklandi = true;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
    notifyListeners();
  }

  ctikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = true;
    dTiklandi = false;
    eTiklandi = false;
    notifyListeners();
  }

  dtikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = true;
    eTiklandi = false;
    notifyListeners();
  }

  etikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = true;
    notifyListeners();
  }
}
