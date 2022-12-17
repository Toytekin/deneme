import 'dart:convert';

class Kelimeler {
  Kelimeler({
    required this.kelime,
    required this.tip,
  });

  String kelime;
  String tip;

  factory Kelimeler.fromJson(String str) => Kelimeler.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kelimeler.fromMap(Map<String, dynamic> json) => Kelimeler(
        kelime: json["kelime"],
        tip: json["tip"],
      );

  Map<String, dynamic> toMap() => {
        "kelime": kelime,
        "tip": tip,
      };
}
