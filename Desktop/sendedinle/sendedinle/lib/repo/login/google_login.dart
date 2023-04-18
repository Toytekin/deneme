import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String baseFotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/sendedinle-3c8e9.appspot.com/o/snededinle%2Fsendedinle.jpeg?alt=media&token=b9858767-31d2-4545-8fcd-b64c5ae16d47';

  GoogleSignIn googleSignIn = GoogleSignIn();
  //*******************< GİRİŞ >************************ */
  Future<UserModel?> googleGiris() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      var googleAuthh = await googleUser.authentication;
      if (googleAuthh.idToken != null && googleAuthh.accessToken != null) {
        var sonuc = await firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuthh.idToken,
                accessToken: googleAuthh.accessToken));
        User? user = sonuc.user;
        UserModel usermodel = userConvert(user!);
        return usermodel;
      }
    }
    return null;
  }

  Future<void> userKontrolVeKayit({required UserModel userModel}) async {
    var olusanUser = UserModel(
        id: userModel.id,
        name: userModel.mail,
        mail: userModel.mail,
        photoUrl: baseFotoUrl);

    await db.collection('user').doc(olusanUser.id).set(olusanUser.toMap());
  }

  //*******************< ÇIKIŞ >************************ */
  Future<void> googleCikis() async {}
  UserModel userConvert(User user) {
    return UserModel(
        name: '', id: user.uid, mail: user.email.toString(), photoUrl: '');
  }
}
