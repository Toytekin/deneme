class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.photoUrl,
  });

  String id;
  String name;
  String mail;
  String photoUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mail': mail,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        mail = map['mail'],
        name = map['name'],
        photoUrl = map['photoUrl'] ?? '';
}
