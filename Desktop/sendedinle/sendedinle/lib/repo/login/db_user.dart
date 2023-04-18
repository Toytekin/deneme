import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/user_model.dart';

class DbUser {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> saveUser(UserModel userModel) async {
    await db.collection('user').doc(userModel.id).set(userModel.toMap());
    return true;
  }

  Future<UserModel> yeniUser(UserModel userModel) async {
    var gelenData = await db.collection('user').doc(userModel.id).get();
    var mapData = gelenData.data();

    if (mapData != null) {
      var data = UserModel(
        id: userModel.id,
        name: mapData["name"],
        mail: mapData["mail"],
        photoUrl: mapData["photoUrl"],
      );
      return data;
    } else {
      return userModel;
    }
  }
}
