class TestModel {
  String kategori;
  String gonderenDrTc = '';
  String soru = '';
  String cevap = '';
  String aSikki = '';
  String bSikki = '';
  String cSikki = '';
  String dSikki = '';
  String eSikki = '';
  String gelenCevap = '';
  String tip = '';
  String testCozenID = '';
  String soruIdm = '';

  static Map<String, dynamic> toMap(TestModel soru) {
    Map<String, dynamic> soruMap = {
      'kategori': soru.kategori,
      'gonderenDrTc': soru.gonderenDrTc,
      'soru': soru.soru,
      'aSikki': soru.aSikki,
      'bSikki': soru.bSikki,
      'cSikki': soru.cSikki,
      'dSikki': soru.dSikki,
      'eSikki': soru.eSikki,
      'cevap': soru.cevap,
      'gelenCevap': soru.gelenCevap,
      'tip': soru.tip,
      'testCozenID': soru.testCozenID,
      'soruIdm': soru.soruIdm
    };
    return soruMap;
  }

  TestModel(
      {required this.kategori,
      required this.gonderenDrTc,
      required this.soru,
      required this.aSikki,
      required this.bSikki,
      required this.cSikki,
      required this.dSikki,
      required this.eSikki,
      required this.cevap,
      required this.gelenCevap,
      required this.tip,
      required this.testCozenID,
      required this.soruIdm});

  factory TestModel.frommap(Map<String, dynamic> map) {
    return TestModel(
      kategori: map['kategori'],
      gonderenDrTc: map['gonderenDrTc'],
      soru: map['soru'],
      aSikki: map['aSikki'],
      bSikki: map['bSikki'],
      cSikki: map['cSikki'],
      dSikki: map['dSikki'],
      eSikki: map['eSikki'],
      gelenCevap: map['gelenCevap'],
      cevap: map['cevap'],
      tip: map['tip'],
      testCozenID: map['testCozenID'],
      soruIdm: map['soruIdm'],
    );
  }
}
