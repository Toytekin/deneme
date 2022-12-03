import 'package:pskiyatrim/db/model/user_model.dart';

abstract class CoreAuth {
  Future<UserModel> googleGiris();
  Future googleCikis();
  Stream<UserModel?> get authChanges;
}
