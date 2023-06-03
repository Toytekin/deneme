import 'package:haritaapp/model/konum_model.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<KonumModel> gidilecekList;

  User({required this.name, required this.gidilecekList});
}
