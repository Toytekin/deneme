class PostLikeModel {
  String likeid;
  String postID;
  String userID;
  bool begendim;
  PostLikeModel({
    required this.likeid,
    required this.postID,
    required this.userID,
    required this.begendim,
  });

  PostLikeModel.fromMap(Map<String, dynamic> map)
      : likeid = map['likeid'],
        postID = map['postID'],
        userID = map['userID'],
        begendim = map['begendim'];

  Map<String, dynamic> toMap() {
    return {
      "likeid": likeid,
      "postID": postID,
      "userID": userID,
      "begendim": begendim,
    };
  }
}
