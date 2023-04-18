import '../../model/user_model.dart';

abstract class BaseAuth {
  // ignore: non_constant_identifier_names
  Future<UserModel?> creatAnonimUser(
      {required String pasword, required String mail});
  Future<void> signOuth();
  Stream<UserModel?> get screeChance;
}
