import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pskiyatrim/db/firebase/core_auth.dart';
import 'package:pskiyatrim/db/model/user_model.dart';

class DbFirebase extends CoreAuth {
  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future googleCikis() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> googleGiris() async {
    GoogleSignIn googleSign = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSign.signIn();

    GoogleSignInAuthentication gooleAuth = await googleUser!.authentication;
    var sonuc = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: gooleAuth.idToken, accessToken: gooleAuth.accessToken));
    User? user = sonuc.user;
    return converStrem(user);
  }

  @override
  Stream<UserModel?> get authChanges =>
      firebaseAuth.authStateChanges().map(converStrem);
}

UserModel converStrem(User? user) {
  return UserModel(
    usersifre: user!.uid,
    userMail: user.email,
  );
}
