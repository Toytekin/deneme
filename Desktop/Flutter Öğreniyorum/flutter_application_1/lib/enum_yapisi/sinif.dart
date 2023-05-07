// ignore: constant_identifier_names
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum Renkler { KIRMIZI, MAVI, YESIL, LACIVERT }

enum Litrelendirme { bir, iki, uc }

Color renkleriGetir(Renkler renk) {
  switch (renk) {
    case Renkler.KIRMIZI:
      {
        return Colors.red;
      }
    case Renkler.MAVI:
      {
        return Colors.blue;
      }
    case Renkler.YESIL:
      {
        return Colors.green;
      }
    case Renkler.LACIVERT:
      {
        return const Color.fromARGB(255, 45, 85, 154);
      }

    default:
      return Colors.grey;
  }
}

String litreyeGoreFiyatlandir(Litrelendirme litre) {
  switch (litre) {
    case Litrelendirme.bir:
      return (1 * 10).toString();
    case Litrelendirme.iki:
      return (2 * 9.5).toString();
    case Litrelendirme.uc:
      return (3 * 9.3).toString();

    default:
      return 0.toString();
  }
}
