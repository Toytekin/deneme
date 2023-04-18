import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilResmiDB {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> resimYukle(File file) async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(firebaseAuth.currentUser!.uid)
        .child('profilResmi.png');

    await yol.putFile(file);
    String url = await yol.getDownloadURL();
    return url;
  }

  Future<String?> resimcek() async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(firebaseAuth.currentUser!.uid)
        .child('profilResmi.png');

    try {
      String url = await yol.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  Future<String?> idyeGoreResimCek(String userID) async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(userID)
        .child('profilResmi.png');

    try {
      String url = await yol.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
