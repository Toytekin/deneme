import 'package:flutter/material.dart';

class SbtRenkler {
  static SbtRenkler? _instance;
  static SbtRenkler get instance {
    _instance ??= _instance = SbtRenkler._init();
    return _instance!;
  }

  SbtRenkler._init();

  final Color arkaplanBeyaz = const Color(0xffF6F6F6);
  final Color turuncu = const Color(0xffF7622E);
  final Color anaRenk = const Color.fromARGB(189, 81, 217, 210);
  final Color yaziRengi = const Color(0xff4A4A4A);
  final Color siyah = const Color(0xff000000);
  final Color griAlternatif = const Color(0xff818181);
  final Color griTextformfield = const Color(0xffF7F7F7);
  final Color griTextformfieldArkaplan = const Color(0xffCECECE);
  final Color sari = const Color.fromARGB(170, 255, 255, 0);
  final Color yesil = const Color(0xff00c849);
  final Color griPale = const Color(0xfff1f1f1);
  final Color sliderInactiveGrey = const Color(0xffe7e6e6);
}
