class MessajModel {
  String mesajID;
  String ogrenciID;
  String messaj;

  MessajModel({
    required this.mesajID,
    required this.ogrenciID,
    required this.messaj,
  });

  // toMap methodu
  Map<String, dynamic> toMap() {
    return {
      'mesajID': mesajID,
      'ogrenciID': ogrenciID,
      'messaj': messaj,
    };
  }

  // fromMap methodu
  factory MessajModel.fromMap(Map<String, dynamic> map) {
    return MessajModel(
      mesajID: map['mesajID'] ?? '',
      ogrenciID: map['ogrenciID'] ?? '',
      messaj: map['messaj'] ?? '',
    );
  }
}
