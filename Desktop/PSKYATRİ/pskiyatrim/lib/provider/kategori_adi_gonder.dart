import 'package:flutter/cupertino.dart';

class KategoriAdiGonder extends ChangeNotifier {
  String _kategoriAdi = '';

  String kategoriAdi() {
    return _kategoriAdi;
  }

  kategoriAl(String kategori) {
    _kategoriAdi = kategori;
    notifyListeners();
  }
}
