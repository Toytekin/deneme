// Raandevu türünü 0 ise yüzyüze 1 ise online olacak.
//Default olarak 0 olacaak

class RandevuModel {
  String randevuID;
  String ogrenciID;
  String akademisyenID;
  String akademisyenName;
  String ogrenciName;
  String tarih;
  String baslik;
  String mesaj;
  String ogrenciMail;
  int gorusmeTuru;
  bool onayDurumu;

  RandevuModel({
    required this.randevuID,
    required this.ogrenciID,
    required this.akademisyenName,
    required this.ogrenciName,
    required this.akademisyenID,
    required this.tarih,
    required this.baslik,
    required this.mesaj,
    required this.ogrenciMail,
    this.onayDurumu = false,
    this.gorusmeTuru = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'randevuID': randevuID,
      'ogrenciID': ogrenciID,
      'ogrenciName': ogrenciName,
      'akademisyenID': akademisyenID,
      'akademisyenName': akademisyenName,
      'tarih': tarih,
      'baslik': baslik,
      'mesaj': mesaj,
      'ogrenciMail': ogrenciMail,
      'gorusmeTuru': gorusmeTuru,
      'onayDurumu': onayDurumu,
    };
  }

  factory RandevuModel.fromMap(Map<String, dynamic> map) {
    return RandevuModel(
      randevuID: map['randevuID'],
      ogrenciID: map['ogrenciID'],
      ogrenciName: map['ogrenciName'],
      akademisyenName: map['akademisyenName'],
      akademisyenID: map['akademisyenID'],
      tarih: map['tarih'],
      baslik: map['baslik'],
      mesaj: map['mesaj'],
      ogrenciMail: map['ogrenciMail'],
      gorusmeTuru: map['gorusmeTuru'] ?? 0,
      onayDurumu: map['onayDurumu'] ?? false,
    );
  }
}
