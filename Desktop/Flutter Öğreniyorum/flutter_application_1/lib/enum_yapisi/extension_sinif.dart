extension StringExtensinKullanimi on String {
  String get kareAl {
    switch (this) {
      case 'iki':
        return (2 * 2).toString();
      case 'üç':
        return (3 * 3).toString();
      case 'dört':
        return (4 * 4).toString();
      case 'beş':
        return (5 * 5).toString();
      default:
        return 0.toString();
    }
  }
}
