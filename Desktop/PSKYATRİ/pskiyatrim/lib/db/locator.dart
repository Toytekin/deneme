import 'package:get_it/get_it.dart';
import 'package:pskiyatrim/db/firebase/db_firebase.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DbFirebase);
}
