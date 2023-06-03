import 'package:flutter/material.dart';
import 'package:haritaapp/a_sayfalar/deneme.dart';
import 'package:haritaapp/a_sayfalar/giris_ekrani.dart';
import 'package:hive/hive.dart';

import '../../model/konum_model.dart';
import '../../model/user.dart';

class UserHome extends StatefulWidget {
  double lan;
  double lat;
  int userkey;
  UserHome({
    super.key,
    required this.userkey,
    required this.lan,
    required this.lat,
  });

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void initState() {
    super.initState();
    userAl();
    yerGetir();
  }

  User? data;

  List<KonumModel> gidilecekList = [];
  List<User> allUser = [];
  var userBox = Hive.box<User>('kisiDB');

  void userAl() {
    userBox.values.forEach((element) {
      allUser.add(element);
    });
  }

  Future<void> yerGetir() async {
    data = (userBox.getAt(widget.userkey))!;
    gidilecekList = data!.gidilecekList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tamamalanacak Hedefler'),
        ),
        body: gidilecekList.isNotEmpty
            ? ListView.builder(
                itemCount: gidilecekList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onLongPress: () async {
                        gidilecekList.removeAt(index);
                        var userUpdate = User(
                            name: data!.name, gidilecekList: gidilecekList);
                        await userBox.put(widget.userkey, userUpdate);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GirisEkrani(),
                        ));
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DenemeSayfasi(
                            lan: widget.lan,
                            lat: widget.lat,
                            gLan: gidilecekList[index].lan,
                            gLat: gidilecekList[index].lat,
                          ),
                        ));
                      },
                      title: Text(gidilecekList[index].lan.toString()),
                      subtitle: Text(gidilecekList[index].lat.toString()),
                      trailing: const Icon(Icons.map),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('Görev ataması yapılmadı'),
              ));
  }
}
