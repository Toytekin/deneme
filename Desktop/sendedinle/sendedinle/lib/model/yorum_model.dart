import 'package:cloud_firestore/cloud_firestore.dart';

class YorumModel {
  String userID;
  String yorumID;
  String yorum;
  String usrPhotoUrl;
  Timestamp yorumTarih;
  YorumModel(
      {required this.userID,
      required this.yorumID,
      required this.yorum,
      required this.yorumTarih,
      required this.usrPhotoUrl});
  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "yorumID": yorumID,
      "yorum": yorum,
      "yorumTarih": yorumTarih,
      "usrPhotoUrl": usrPhotoUrl,
    };
  }

  YorumModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        yorumID = map['yorumID'],
        yorum = map['yorum'],
        yorumTarih = map["yorumTarih"],
        usrPhotoUrl = map["usrPhotoUrl"];
}
