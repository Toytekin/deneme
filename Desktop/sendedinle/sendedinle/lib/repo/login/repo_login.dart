import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/repo/login/base_auth.dart';
import 'package:myapp/repo/login/mixin_user.dart';

class MyLoginServices with ConverUser implements BaseAuth {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  var firebase = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  UserModel? userModel;

  final String baseFotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/sendedinle-3c8e9.appspot.com/o/snededinle%2Fsendedinle.jpeg?alt=media&token=b9858767-31d2-4545-8fcd-b64c5ae16d47';

  //? ***********< SİGN >***********
  Future<UserModel?> signFirebasea(
      {required String pasword, required String mail}) async {
    try {
      var gelenKisi = await firebase.signInWithEmailAndPassword(
          email: mail, password: pasword);
      userModel = userConvert(gelenKisi);
      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  //? ***********< CREATE >***********
  @override
  Future<UserModel?> creatAnonimUser(
      {required String pasword, required String mail}) async {
    try {
      var olusanKisi = await firebase.createUserWithEmailAndPassword(
          email: mail, password: pasword);
      userModel = userConvert(olusanKisi);
      return userModel;
    } on FirebaseAuthException catch (k) {
      debugPrint('User zaten var  :$k');
      return null;
    } catch (e) {
      debugPrint('user oluşturma hatası  :$e');
      return null;
    }
  }

  Future<UserModel?> userKontrolVeKayit(
      {required String pasword, required String mail}) async {
    try {
      var olusanKisi = await firebase.createUserWithEmailAndPassword(
          email: mail, password: pasword);
      var olusanUser = UserModel(
          id: olusanKisi.user!.uid,
          name: mail,
          mail: mail,
          photoUrl: baseFotoUrl);

      await db.collection('user').doc(olusanUser.id).set(olusanUser.toMap());

      userModel = userConvert(olusanKisi);
      return userModel;
    } on FirebaseAuthException catch (k) {
      debugPrint('User zaten var  :$k');
      return null;
    } catch (e) {
      debugPrint('user oluşturma hatası  :$e');
      return null;
    }
  }

  Future<UserModel?> usurKayitYineleme({required UserModel userModel}) async {
    var deneme = await db.collection('user').doc(userModel.id).get();
    var data = deneme.data();
    if (data != null) {
      String userName = data['name'];
      try {
        if (userModel.name != userName) {
          var olusanUser = UserModel(
              id: userModel.id,
              name: userModel.name,
              mail: userModel.mail,
              photoUrl: baseFotoUrl);

          await db
              .collection('user')
              .doc(olusanUser.id)
              .set(olusanUser.toMap());
        } else {
          var olusanUser = UserModel(
            id: userModel.id,
            name: data['name'],
            mail: data['mail'],
            photoUrl: data['photoUrl'],
          );

          await db
              .collection('user')
              .doc(olusanUser.id)
              .set(olusanUser.toMap());
        }

        return userModel;
      } on FirebaseAuthException catch (k) {
        debugPrint('User zaten var  :$k');
        return null;
      } catch (e) {
        debugPrint('user oluşturma hatası  :$e');
        return null;
      }
    } else {}
    return null;
  }

  //? ***********< OUTH >***********

  @override
  Future<void> signOuth() async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
    }
    await firebase.signOut();
  }
  //? ***********< CHANCE >***********

  @override
  Stream<UserModel> get screeChance => firebase
      .authStateChanges()
      .map((event) => UserConvert().userConvert(event!));
  //? ***********< RESET >***********

  Future<void> resetPassword(String email) async {
    try {
      await firebase.sendPasswordResetEmail(email: email);
      debugPrint('Başarılı');
    } catch (e) {
      debugPrint('Redd');

      debugPrint(e.toString());
      // Handle the error here, such as displaying a message to the user
    }
  }
}

class UserConvert {
  UserModel userConvert(User user) {
    return UserModel(
      name: '',
      id: user.uid,
      mail: user.email.toString(),
      photoUrl: '',
    );
  }
}
