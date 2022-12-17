// To parse this JSON data, do
//
//     final meslekler = mesleklerFromMap(jsonString);

import 'dart:convert';

List<Meslekler> mesleklerFromMap(String str) =>
    List<Meslekler>.from(json.decode(str).map((x) => Meslekler.fromMap(x)));

String mesleklerToMap(List<Meslekler> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Meslekler {
  Meslekler({
    required this.adi,
    required this.hikaye,
  });

  final String adi;
  final String hikaye;

  factory Meslekler.fromMap(Map<String, dynamic> json) => Meslekler(
        adi: json["adi"],
        hikaye: json["hikaye"],
      );

  Map<String, dynamic> toMap() => {
        "adi": adi,
        "hikaye": hikaye,
      };
}
