import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? userMail;
  String? usersifre;
  String not;

  UserModel({required this.userMail, required this.usersifre, this.not = ''});

  static toMap(UserModel user) {
    Map<String, dynamic> userMap = {
      'mail': user.userMail,
      'sifre': user.usersifre,
      'not': user.userMail,
    };
    return userMap;
  }

  factory UserModel.frommap(Map<String, dynamic> map) {
    return UserModel(
      userMail: map['mail'],
      usersifre: map['sifre'],
      not: map['not'],
    );
  }
}
