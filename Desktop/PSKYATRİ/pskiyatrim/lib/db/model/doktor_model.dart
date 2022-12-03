import 'package:flutter/material.dart';

class DoktorModel extends ChangeNotifier {
  String? danAdSoyad;

  String? danTC;
  String? yazi;

  // ignore: non_constant_identifier_names
  veriyiGetir(DoktorModel DoktorModel) {
    return DoktorModel;
  }

  DoktorModel({
    required this.danAdSoyad,
    required this.danTC,
    required this.yazi,
  });

  static Map<String, dynamic> toMap(DoktorModel user) {
    Map<String, dynamic> userMap = {
      'ad': user.danAdSoyad,
      'tc': user.danTC,
      'mail': user.yazi,
    };
    return userMap;
  }

  factory DoktorModel.frommap(Map<String, dynamic> map) {
    return DoktorModel(
      danAdSoyad: map['ad'],
      danTC: map['tc'],
      yazi: map['mail'],
    );
  }
}
