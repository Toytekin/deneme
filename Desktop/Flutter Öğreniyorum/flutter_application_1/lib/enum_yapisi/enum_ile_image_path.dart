// ignore: constant_identifier_names
enum Resimler {
  cho,
  fred,
  giny,
  hermony,
  herry,
  hogvarts,
}

extension ImageExtension on Resimler {
  String path() {
    return 'assets/$name.jpg';
  }
}
