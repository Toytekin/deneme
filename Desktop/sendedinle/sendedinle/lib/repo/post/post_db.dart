import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/model/post_like_model.dart';
import 'package:myapp/model/post_model.dart';
import 'package:myapp/model/user_model.dart';

import '../../model/yorum_model.dart';

class PostDB {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebase = FirebaseStorage.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String?> muzikSave(
      File file, String userID, String muzikPath, String klasorId) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('muzikPath')
          .child(firebaseAuth.currentUser!.uid)
          .child(klasorId)
          .child(muzikPath);
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageReference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<String?> muzikKapakResmi(File file, String klasorId) async {
    var yol = firebase
        .ref()
        .child('muzikPath')
        .child(firebaseAuth.currentUser!.uid)
        .child(klasorId)
        .child('resim');

    await yol.putFile(file);
    String url = await yol.getDownloadURL();
    return url;
  }

  Future<PostModel> returnPostModel(
      String userID,
      String postLikeID,
      String postID,
      String userName,
      String title,
      String indirmeUrl,
      String photoUrl,
      String userProfilPhotoUrl,
      DateTime dateTime,
      int begeniSayisi,
      List<YorumModel>? yorumlar) async {
    var data = PostModel(
        userName: userName,
        postID: postID,
        postLikeID: postLikeID,
        postUserID: userID,
        title: title,
        url: indirmeUrl,
        userProfilPhoto: userProfilPhotoUrl,
        photoUrl: photoUrl,
        olusturmaTarihi: dateTime,
        begeniSayisi: begeniSayisi,
        yorumlar: yorumlar);
    return data;
  }

  Future<bool> saveMuzikStrore(PostModel postModel) async {
    await db
        .collection('tmpostlar')
        .doc(postModel.postID)
        .set(postModel.toMap());
    return true;
  }

  Future<bool> begeniGetir(String postID, String userID) async {
    var data = await db
        .collection('postLike')
        .doc(postID)
        .collection('bb')
        .doc(userID)
        .get();
    var data1 = data.data();
    if (data1 != null) {
      var begeniDurum = data1['begendim'];

      if (begeniDurum != null && begeniDurum == bool) {
        return begeniDurum;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<List<UserModel>> tumBegenileriGetir(String postID) async {
    List<UserModel> allUser = [];

    var userData = await db.collection('user').get();
    var userSnap = userData.docs;

    //
    var dataLike =
        await db.collection('postLike').doc(postID).collection('bb').get();

    var listLikesData = dataLike.docs;

    for (var likeUserID in listLikesData) {
      var data = likeUserID.data();
      var durum = data['begendim'];
      var tekLikeUserID =
          data['userID']; // postlike veri tabanındaki beğenen kişinin ID si

      for (var element in userSnap) {
        var userdatam = element.data();
        var tekUser = userdatam['id'];

        if (tekLikeUserID == tekUser && durum == true) {
          UserModel modelUser = UserModel.fromMap(userdatam);
          allUser.add(modelUser);
        }
      }
    }
    return allUser;
  }

//************************< Y O R U M >*********************** */
  Future<void> postYorumEkleme(String postID, YorumModel yorumModel) async {
    final documentReference =
        FirebaseFirestore.instance.collection('tmpostlar').doc(postID);

    await documentReference.update({
      'yorumlar': FieldValue.arrayUnion([yorumModel.toMap()]),
    });
  }

  Future<List<YorumModel>?> yorumlariGetir(String postID) async {
    List<YorumModel> yorumLisem = [];
    var documentReference = await FirebaseFirestore.instance
        .collection('tmpostlar')
        .doc(postID)
        .get();
    var data = documentReference.data();
    if (data != null) {
      var yorumList = data['yorumlar'];
      for (var element in yorumList) {
        YorumModel yorumModel = YorumModel.fromMap(element);
        yorumLisem.add(yorumModel);
      }
      return yorumLisem;
    } else {
      return null;
    }
  }

  Future<void> begenDefault(PostLikeModel postLikeModel) async {
    await db
        .collection('postLike')
        .doc(postLikeModel.postID)
        .collection('bb')
        .doc(postLikeModel.userID)
        .set(postLikeModel.toMap());
  }

  Future<void> begenArttirAzalt(
      PostLikeModel postLikeModel, bool begeniBool) async {
    var poslartRef = db
        .collection('postLike')
        .doc(postLikeModel.postID)
        .collection('bb')
        .doc(postLikeModel.userID);
    var postRef = db.collection('tmpostlar').doc(postLikeModel.postID);
    //
    if (begeniBool == true) {
      await postRef.update({'begeniSayisi': FieldValue.increment(1)});
      await poslartRef.set(postLikeModel.toMap());
    } else {
      await poslartRef.set(postLikeModel.toMap());
      await postRef.update({'begeniSayisi': FieldValue.increment(-1)});
    }
  }

  Future<List<PostModel>?> tumPoslariGetir() async {
    List<PostModel> poslar = [];
    var data = await db.collection('tmpostlar').get();
    for (QueryDocumentSnapshot documentSnapshot in data.docs) {
      Map<String, dynamic> data2 =
          documentSnapshot.data() as Map<String, dynamic>;
      PostModel postModel = PostModel.fromMap(data2);
      poslar.add(postModel);
    }
    return poslar;
  }

  Future<List<UserModel>> tumUserlariGetir() async {
    List<UserModel> user = [];
    var data = await db.collection('user').get();
    for (QueryDocumentSnapshot documentSnapshot in data.docs) {
      Map<String, dynamic> data2 =
          documentSnapshot.data() as Map<String, dynamic>;
      UserModel postModel = UserModel.fromMap(data2);
      user.add(postModel);
    }
    return user;
  }
}
