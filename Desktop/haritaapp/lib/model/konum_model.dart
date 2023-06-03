import 'package:hive/hive.dart';

part 'konum_model.g.dart';

@HiveType(typeId: 2)
class KonumModel {
  @HiveField(5)
  double lan;
  @HiveField(6)
  double lat;
  KonumModel({required this.lan, required this.lat});
}
