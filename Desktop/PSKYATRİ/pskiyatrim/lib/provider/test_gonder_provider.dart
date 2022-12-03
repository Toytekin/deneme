import 'package:flutter/cupertino.dart';

class TestGonderProvider extends ChangeNotifier {
  String _testKisi = '';

  String testKisi() {
    return _testKisi;
  }

  testKisiAl(String testKisi) {
    _testKisi = testKisi;
    notifyListeners();
  }
}
