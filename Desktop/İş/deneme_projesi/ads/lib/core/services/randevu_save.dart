import 'package:ads/core/models/mesaj_model.dart';
import 'package:ads/core/models/randevumodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FrRandevuSave {
  var saveRandevu = FirebaseFirestore.instance.collection('randevu');
  var saveMessaj = FirebaseFirestore.instance.collection('mesaj');

  randevuEkle(RandevuModel randevuModel) async {
    try {
      await saveRandevu.doc(randevuModel.randevuID).set(randevuModel.toMap());
      debugPrint('Ekleme Başarılı');
    } catch (e) {
      debugPrint('FrSaveUser / userEkle hata var $e');
    }
  }

  Future<List<RandevuModel>?> getRandevularByOgrenciID(String ogrenciID) async {
    List<RandevuModel> randevular = [];

    try {
      var querySnapshot =
          await saveRandevu.where('ogrenciID', isEqualTo: ogrenciID).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var randevuData = doc.data();
          var randevu = RandevuModel.fromMap(randevuData);
          randevular.add(randevu);
        }
      }

      return randevular;
    } catch (e) {
      // Hata durumunda işlemler
      debugPrint('getRandevularByOgrenciID fonksiyonunda hata var: $e');
      return [];
    }
  }

  Future<List<RandevuModel>?> getRandevularAkademisyenID(
      String ogrenciID) async {
    List<RandevuModel> randevular = [];

    try {
      var querySnapshot =
          await saveRandevu.where('akademisyenID', isEqualTo: ogrenciID).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var randevuData = doc.data();
          var randevu = RandevuModel.fromMap(randevuData);
          randevular.add(randevu);
        }
      }

      return randevular;
    } catch (e) {
      // Hata durumunda işlemler
      debugPrint('getRandevularByOgrenciID fonksiyonunda hata var: $e');
      return [];
    }
  }

  Future<void> toggleOnayDurumu(
      String randevuID, bool currentOnayDurumu) async {
    try {
      await saveRandevu.doc(randevuID).update({
        'onayDurumu': currentOnayDurumu, // Mevcut değerin tersini al
      });
    } catch (e) {
      debugPrint('Onay durumu güncelleme hatası: $e');
    }
  }

  Future<void> randevuOnayMesajYolla(MessajModel mesajmoddel) async {
    try {
      await saveMessaj.doc(mesajmoddel.mesajID).set(mesajmoddel.toMap());
    } catch (e) {
      debugPrint('Mesaj atma hatası: $e');
    }
  }

  // Diğer metodlar buraya eklenebilir

  Future<List<MessajModel>?> mesajlariCek(String ogrenciID) async {
    List<MessajModel> randevular = [];

    try {
      var querySnapshot =
          await saveMessaj.where('ogrenciID', isEqualTo: ogrenciID).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var randevuData = doc.data();
          var randevu = MessajModel.fromMap(randevuData);
          randevular.add(randevu);
        }
      }

      return randevular;
    } catch (e) {
      // Hata durumunda işlemler
      debugPrint('mesajlar fonksiyonunda hata var: $e');
      return [];
    }
  }
}
