import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haritaapp/a_sayfalar/home.dart';
import 'package:haritaapp/a_sayfalar/patron/p_home.dart';
import 'package:haritaapp/a_sayfalar/user/user_home.dart';
import 'package:haritaapp/konum_controller/konum.dart';
import 'package:haritaapp/model/user.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  //Enlem ve boylam bilgileri
  String lat = '0';
  String lan = '0';
  //Konum paketi çağırma
  LocationHelper? locationData;

  //Konum bilgisini aldığımız alan
  Future<void> konumGetir() async {
    locationData = LocationHelper();
    await locationData?.getLocation();

    if (locationData!.lan == null || locationData!.lat == null) {
      debugPrint('Konum bilgisi gelmiyor');
    } else {
      setState(() {});
      lat = locationData!.lan.toString();
      lan = locationData!.lat.toString();
    }
  }

// Veri tabanı çağırma

  var userBox = Hive.box<User>('kisiDB');

  @override
  void initState() {
    super.initState();
    konumGetir();
  }

  Future<void> kisiOlustur() async {
    var user1 = User(name: 'Ömer KAYA(Gerçek Konum Sahibi)', gidilecekList: []);
    var user2 = User(name: 'Sümeyra KIRTAN', gidilecekList: []);
    var user3 = User(name: 'Ali Yasin AKMEŞE', gidilecekList: []);

    await userBox.put(1, user1);
    await userBox.put(2, user2);
    await userBox.put(3, user3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                kisiOlustur();
              },
              icon: const Icon(Icons.data_thresholding_sharp))
        ],
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'Şube Takip',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width / 2,
                height: Get.width / 2,
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_0izu3yy8.json'),
              ),
              const Text('Konum Bilgileri'),
              Card(
                child: ListTile(
                  title: Text(lat),
                  subtitle: Text(lan),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Sisteme Gir'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            lan: double.parse(lan), lat: double.parse(lat)),
                      ));
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Patron Girişi'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PatronHomeScreen(
                              lan: double.parse(lan), lat: double.parse(lat)),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text('     Ömer KAYA     '),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserHome(
                        userkey: 0,
                        lan: double.parse(lan),
                        lat: double.parse(lat),
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Sümeyra KIRTAN'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserHome(
                        userkey: 1,
                        lan: 37.78736169288452,
                        lat: 38.61578607483222,
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Ali Yasin AKMEŞE'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserHome(
                          userkey: 2,
                          lan: 37.7648594446236,
                          lat: 38.300400323200805),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        width: Get.width / 2 + 20,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                SizedBox(height: 50),
                CircleAvatar(
                  maxRadius: 35,
                  backgroundImage: ExactAssetImage('assets/resim1.jpg'),
                ),
                SizedBox(height: 50),
                Text('Hoca Ahmet Yesevi Üniversitasi',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                SizedBox(height: 20),
                Text('Ömer KAYA'),
                SizedBox(height: 20),
                Text('202132153'),
                SizedBox(height: 20),
                Text('Bilgisayar Mühendisliği Bölümü',
                    style: TextStyle(fontSize: 12)),
                SizedBox(height: 20),
                Text('Proje 2 Dersi'),
                SizedBox(height: 20),
              ],
            ),
            const Text(
              'Doc.Dr.Hakan KUTUCU',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }
}
