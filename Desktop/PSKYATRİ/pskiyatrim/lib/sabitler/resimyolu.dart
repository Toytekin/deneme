class ResimYolu {
  static ResimYolu? _instance;
  static ResimYolu get instance {
    _instance ??= _instance = ResimYolu._init();
    return _instance!;
  }

  ResimYolu._init();
  String get danisanekle => toPng("danisanekle");
  String get danisanlar => toPng("danisanlar");
  String get quiz => toPng("quiz");
  String get testekle => toPng("testekle");
  String get user => toPng("user");
  String get doctor => toPng("doctor");
  //!
  //? Üste belittiğim arkaplan içerisine png dosya adımı yazım 'rakaplan_resmi'
  //? Alt tarafdayazdığım değeri yoluma $ işareti ile belirtip sonuna .png yazdım
  String toPng(value) => 'assets/$value.png';
}

// ÖRENEK KULLANIM
// Image.asset(ResimYolu.instance.arkaPlan);

//!
//!
//!
//!
//! YUKARIDAKİNİNİ SVG OLANI. UZANTISI SVG OLANLAR İÇİN

class SvgConstants {
  static SvgConstants? _instance;
  static SvgConstants get instance {
    _instance ??= _instance = SvgConstants._init();
    return _instance!;
  }

  SvgConstants._init();

  String get danisanekle => toSvg("danisanekle");
  String get danisanlar => toSvg("danisanlar");
  String get quiz => toSvg("quiz");
  String get testekle => toSvg("testekle");
  String get user => toSvg("user");

  String toSvg(String value) => 'assets/svg/$value.svg';
}
