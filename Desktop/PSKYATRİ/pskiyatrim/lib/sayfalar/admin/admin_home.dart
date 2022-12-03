import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/giri_mail.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sayfalar/admin/doctor_ekle.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class AdminHomePage extends StatefulWidget {
  DanisanModel user;
  AdminHomePage({super.key, required this.user});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Resim
  String? gelenResim;
  String resimurl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(' Admin Paneli'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const GiriMail(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.home_filled))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<DanisanModel>>(
          future: dbProvider.getAllDoktor(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // ignore: no_leading_underscores_for_local_identifiers
              List<DanisanModel>? _tumDoktorlar = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: _tumDoktorlar!.length,
                  itemBuilder: (context, index) {
                    var gelenDoktor = _tumDoktorlar[index];

                    return InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: diyalogAdSoyad(gelenDoktor),
                              content: diyalogSilinsinmi(),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange),
                                  onPressed: () async {
                                    await dbProvider
                                        .doktorHerseySil(gelenDoktor);
                                    setState(() {});
                                    // ignore: use_build_context_synchronously
                                    diyalogSilindiMesaji(context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) =>
                                          AdminHomePage(user: widget.user),
                                    ));
                                  },
                                  child: const Text(' SİL   '),
                                ),
                                diyalogVazgec(context)
                              ],
                            );
                          },
                        );
                      },
                      child: cardAdSoyad(gelenDoktor),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: ekleme(context),
    );
  }

  Card cardAdSoyad(DanisanModel gelenDoktor) {
    return Card(
      child: ListTile(
        title: Text(
          '${gelenDoktor.danAd} ${gelenDoktor.danSoyad}',
        ),
      ),
    );
  }

  FloatingActionButton ekleme(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.black,
      elevation: 10,
      shape: StadiumBorder(
          side: BorderSide(color: SbtRenkler.instance.griAlternatif, width: 4)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorEkleSayfasi(dr: widget.user),
        ));
      },
      backgroundColor: SbtRenkler.instance.arkaplanBeyaz,
      child: Icon(
        Icons.person_add,
        color: SbtRenkler.instance.anaRenk,
      ),
    );
  }

  void diyalogSilindiMesaji(BuildContext context) {
    return showTopSnackBar(
      animationDuration: const Duration(milliseconds: 1200),
      displayDuration: const Duration(milliseconds: 500),
      context,
      const CustomSnackBar.success(
        message: "Kişi Silindi",
      ),
    );
  }

  ElevatedButton diyalogVazgec(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('VAZGEÇ'),
    );
  }

  Text diyalogSilinsinmi() {
    return const Text('Silinme işlemini onaylıyor musun ?');
  }

  Text diyalogAdSoyad(DanisanModel gelenDoktor) {
    return Text(' ${gelenDoktor.danAd} ${gelenDoktor.danSoyad} ');
  }
}
