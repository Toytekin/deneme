import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';

mixin ConverUser {
  UserModel userConvert(UserCredential userCredential) {
    return UserModel(
      name: '',
      id: userCredential.user!.uid,
      mail: userCredential.user!.email.toString(),
      photoUrl: '',
    );
  }
}
