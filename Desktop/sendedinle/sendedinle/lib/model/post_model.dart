import 'package:myapp/model/yorum_model.dart';

class PostModel {
  PostModel(
      {required this.postID,
      required this.userName,
      required this.postUserID,
      required this.postLikeID,
      required this.title,
      required this.url,
      required this.photoUrl,
      required this.olusturmaTarihi,
      required this.begeniSayisi,
      required this.userProfilPhoto,
      required this.yorumlar});
  String postID;
  String userName;
  String postUserID;
  String postLikeID;
  String userProfilPhoto;
  String title;
  DateTime olusturmaTarihi;
  String url;
  String photoUrl;
  int begeniSayisi;
  List<YorumModel>? yorumlar;

  Map<String, dynamic> toMap() {
    return {
      "postID": postID,
      "postUserID": postUserID,
      "userName": userName,
      "postLikeID": postLikeID,
      "title": title,
      "olusturmaTarihi": olusturmaTarihi,
      "url": url,
      "begeniSayisi": begeniSayisi,
      "photoUrl": photoUrl,
      "userProfilPhoto": userProfilPhoto,
      "yorumlar":
          yorumlar != null ? yorumlar!.map((e) => e.toMap()).toList() : []
    };
  }

  PostModel.fromMap(Map<String, dynamic> map)
      : postID = map['postID'],
        postUserID = map['postUserID'],
        postLikeID = map['postLikeID'],
        userName = map['userName'],
        title = map['title'],
        url = map["url"],
        photoUrl = map["photoUrl"],
        yorumlar = map["yorumlar"],
        begeniSayisi = map["begeniSayisi"],
        userProfilPhoto = map["userProfilPhoto"],
        olusturmaTarihi = map["olusturmaTarihi"];
}
