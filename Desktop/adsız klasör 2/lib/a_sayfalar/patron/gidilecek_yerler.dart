import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haritaapp/a_sayfalar/giris_ekrani.dart';
import 'package:hive/hive.dart';
import '../../model/konum_model.dart';
import '../../model/user.dart';

// ignore: must_be_immutable
class GidilecekYerler extends StatefulWidget {
  double lat;
  double lan;
  int userkey;
  User user;
  GidilecekYerler({
    super.key,
    required this.lan,
    required this.lat,
    required this.userkey,
    required this.user,
  });

  @override
  State<GidilecekYerler> createState() => _GidilecekYerlerState();
}

class _GidilecekYerlerState extends State<GidilecekYerler> {
  //1.Şube bilgileri
  static const LatLng sube1 = LatLng(
    38.2752733905549,
    37.76447777726941,
  );

  //2.Şube bilgileri
  static const LatLng sube2 = LatLng(
    38.27475840645285,
    37.7631885751995,
  );
  //3.Şube bilgileri
  static const LatLng sube3 = LatLng(
    37.762501557023526,
    38.27711875025392,
  );
  //4.Şube bilgileri
  static const LatLng sube4 = LatLng(
    38.28017646835984,
    37.76276449065947,
  );
//5.Şube bilgileri
  static const LatLng sube5 = LatLng(
    37.76401977384448,
    38.280509062259085,
  );
//6.Şube bilgileri
  static const LatLng sube6 = LatLng(
    37.76496122225211,
    38.279736586106004,
  );
  //7.Şube bilgileri
  static const LatLng sube7 = LatLng(
    37.764986666637355,
    38.27718312326667,
  ); //kahta ,
  //8.Şube bilgileri
  static const LatLng sube8 = LatLng(
    37.7951209,
    38.6105707,
  );
  //9.Şube bilgileri
  static const LatLng sube9 = LatLng(
    37.7996382,
    38.6188157,
  );
  //10.Şube bilgileri
  static const LatLng sube10 = LatLng(
    37.7912903,
    38.6322274,
  );

  //!  //1.Şube bilgileri
  static const LatLng sube11 = LatLng(
    37.7652808,
    38.2727324,
  );

  //2.Şube bilgileri
  static const LatLng sube12 = LatLng(
    37.7628096,
    38.2741782,
  );
  //3.Şube bilgileri
  static const LatLng sube13 = LatLng(
    37.7607196,
    38.2509744,
  );
  //4.Şube bilgileri
  static const LatLng sube14 = LatLng(
    37.7577433,
    38.2742209,
  );
//5.Şube bilgileri
  static const LatLng sube15 = LatLng(
    37.756994,
    38.2732165,
  );
//6.Şube bilgileri
  static const LatLng sube16 = LatLng(
    37.7550367,
    38.2644882,
  );
  //7.Şube bilgileri
  static const LatLng sube17 = LatLng(
    37.7830836,
    38.5855726,
  ); //kahta ,
  //8.Şube bilgileri
  static const LatLng sube18 = LatLng(
    37.7951209,
    38.6105707,
  );
  //9.Şube bilgileri
  static const LatLng sube19 = LatLng(
    37.7996382,
    38.6188157,
  );
  //10.Şube bilgileri
  static const LatLng sube20 = LatLng(
    37.7912903,
    38.6322274,
  );

  // ignore: non_constant_identifier_names
  final String api_key = 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU';

  List<LatLng> gidilecekYerler = [];

// Anlık konum dewğişimi izleme

  @override
  void initState() {
    super.initState();
    kisileriGetir();

    gidilecekYerler.add(sube1);
    gidilecekYerler.add(sube2);
    gidilecekYerler.add(sube3);
    gidilecekYerler.add(sube4);
    gidilecekYerler.add(sube5);
    gidilecekYerler.add(sube6);
    gidilecekYerler.add(sube7);
    gidilecekYerler.add(sube8);
    gidilecekYerler.add(sube9);
    gidilecekYerler.add(sube10);
    gidilecekYerler.add(sube11);
    gidilecekYerler.add(sube12);
    gidilecekYerler.add(sube13);
    gidilecekYerler.add(sube14);
    gidilecekYerler.add(sube15);
    gidilecekYerler.add(sube16);
    gidilecekYerler.add(sube17);
    gidilecekYerler.add(sube18);
    gidilecekYerler.add(sube19);
    gidilecekYerler.add(sube20);
  }

  List<KonumModel> gidilecekList = [];
  List<User> allUser = [];

  var userBox = Hive.box<User>('kisiDB');
  void kisileriGetir() {
    userBox.values.forEach((element) {
      allUser.add(element);
    });
    gidilecekList = allUser[widget.userkey].gidilecekList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(gidilecekList.length.toString()),
        ),
        body: gidilecekYerler.isNotEmpty
            ? ListView.builder(
                itemCount: gidilecekYerler.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    onTap: () async {
                      //Kşiye rotasyon tanımlaması yap
                      var yeniYer = KonumModel(
                          lan: gidilecekYerler[index].longitude,
                          lat: gidilecekYerler[index].latitude);

                      gidilecekList.add(yeniYer);

                      var userUpdate = User(
                          name: widget.user.name, gidilecekList: gidilecekList);

                      await userBox.put(widget.userkey, userUpdate);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GirisEkrani(),
                      ));
                    },
                    title: Text('Şube ${index + 1}'),
                  ));
                },
              )
            : Container());
  }
}
