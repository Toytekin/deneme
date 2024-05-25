import 'package:ads/core/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FrSaveUser {
  var saveUser = FirebaseFirestore.instance.collection('user');

  userEkle(UserModel userModel) async {
    try {
      await saveUser.doc(userModel.userID).set(userModel.toMap());
      debugPrint('Ekleme Başarılı');
    } catch (e) {
      debugPrint('FrSaveUser / userEkle hata var $e');
    }
  }

  Future<UserModel?> getUserByEmail(String mail, String sifre) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('userMail', isEqualTo: mail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();

        // Şifre kontrolü
        if (userData['userSifre'] == sifre) {
          return UserModel.fromMap(userData);
        } else {
          return null; // Şifre uyuşmazsa null dönebilirsiniz.
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('FrLogin getUserByEmail fonksiyonunda hata var  $e');
      return null;
    }
  }

  Future<List<UserModel>?> getAllAkademisyen() async {
    List<UserModel> allUsers = [];

    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('ogrenciMi', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var userData = doc.data();

          // UserModel oluşturun ve listeye ekleyin
          var user = UserModel.fromMap(userData);
          allUsers.add(user);
        }

        return allUsers;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('getAllAkademisyen fonksiyonunda hata var: $e');
      return null;
    }
  }

//

//
}
