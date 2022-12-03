import 'package:flutter/material.dart';

class DanisanModel extends ChangeNotifier {
  String? danAd;
  String? danSoyad;
  String? danTC;
  String? danMail;
  String? danSifre;
  String? danTel;
  String? drTC;

  String not;

  veriyiGetir(DanisanModel danisanModel) {
    return danisanModel;
  }

  DanisanModel(
      {required this.danAd,
      required this.danSoyad,
      required this.danTC,
      required this.danMail,
      required this.danSifre,
      this.not = '',
      required this.danTel,
      required this.drTC});

  static Map<String, dynamic> toMap(DanisanModel user) {
    Map<String, dynamic> userMap = {
      'ad': user.danAd,
      'soyad': user.danSoyad,
      'tc': user.danTC,
      'mail': user.danMail,
      'not': user.not,
      'sifre': user.danSifre,
      'danTel': user.danTel,
      'drTC': user.drTC,
    };
    return userMap;
  }

  factory DanisanModel.frommap(Map<String, dynamic> map) {
    return DanisanModel(
      danAd: map['ad'],
      danSoyad: map['soyad'],
      danTC: map['tc'],
      danMail: map['mail'],
      danSifre: map['sifre'],
      danTel: map['danTel'],
      drTC: map['drTC'],
    );
  }
}
