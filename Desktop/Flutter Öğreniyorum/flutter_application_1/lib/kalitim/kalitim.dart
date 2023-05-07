import 'package:flutter_application_1/kalitim/model.dart';

//! Burada genel bir sınıf olturdum
//! Toplam 2 mettot yazılmasını mecbur kıldık
//! Birtane geriye bool değer döndürecek olan adminMi()
//! Diğeri UserModel döndürme ihtimali olan girisYap() metodu
//! Bu sınıfdan türeyecek her sınıf bu metotları mecburi dolduracak
// ignore: camel_case_types
abstract class Base_User_Form {
  Future<UserModel?> girisYap(String ad, String soyad,
      String sifre); //Geriye UserModel dönen bir metot girmeye zorluyoruz

  Future<bool> adminMi(
      UserModel userModel); // Geriye True yada False döndüren bir metot
}

//! Şimdi bir sınıf oluşturdum
//! Bu sınıf yukarda oluşturduğum Base_User_Form kalasıyla  extends ettim
//! Base_User_Form klasının istediği metotlar mecburi bir şekilde doldurdum
//! Bunlara ekm olark istersem başka bir metotda ekleyebilirim
//
class Sinif1 extends Base_User_Form {
  @override
  Future<bool> adminMi(UserModel userModel) async {
    if (userModel.ad == 'ibrahim' && userModel.sifre == '123') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserModel?> girisYap(String ad, String soyad, String sifre) async {
    if (ad.isNotEmpty && soyad.isNotEmpty && sifre.isNotEmpty) {
      UserModel olusanUser = UserModel(ad: ad, sifre: sifre, soyad: soyad);
      return olusanUser;
    } else {
      return null;
    }
  }

//
//
//
//! Burda bu sınıfa ait bir metot yazdık
  int sinif1KlasinaAitMetot(int sayi_1, int sayi_2) {
    int toplam = sayi_1 + sayi_2;
    return toplam;
  }
}
