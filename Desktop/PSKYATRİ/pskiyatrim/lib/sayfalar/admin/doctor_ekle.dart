import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/sayfalar/admin/admin_home.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DoctorEkleSayfasi extends StatelessWidget {
  DanisanModel dr;
  DoctorEkleSayfasi({super.key, required this.dr});

  CollectionReference dbusers =
      FirebaseFirestore.instance.collection('psikolog');

  TextEditingController adController = TextEditingController();
  TextEditingController soyadController = TextEditingController();
  TextEditingController tcController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<VeriTabani>(context);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: appbarAdmin(
            appbarTitile: 'Doktor Ekle',
            press: () {
              Navigator.of(context).pop();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                adText(),
                const SizedBox(height: 10),
                soyadText(),
                const SizedBox(height: 10),
                tcText(),
                const SizedBox(height: 10),
                mailText(),
                const SizedBox(height: 10),
                telText(),
                const SizedBox(height: 10),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          var eklenecekUser = DanisanModel(
                              danAd: adController.text.toString(),
                              danSoyad: soyadController.text.toString(),
                              danTC: tcController.text.toString(),
                              danMail: mailController.text.toString(),
                              not: 'dr',
                              danTel: telefonController.text.toString(),
                              danSifre: tcController.text.toString(),
                              drTC: 'dr');
                          var doktorModel = DoktorModel(
                            danAdSoyad:
                                '${adController.text.toString()} ${soyadController.text.toString()}',
                            danTC: tcController.text.toString(),
                            yazi: 'Henüz Sivi Girilmedi',
                          );

                          if (adController.text.isNotEmpty &&
                              soyadController.text.isNotEmpty &&
                              tcController.text.isNotEmpty &&
                              mailController.text.isNotEmpty) {
                            dbusers
                                .doc(tcController.text.toString())
                                .set(DanisanModel.toMap(eklenecekUser));
                            db.doktorSiviEkle(doktorModel);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => AdminHomePage(user: dr),
                            ));
                          } else {
                            showTopSnackBar(
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              displayDuration:
                                  const Duration(milliseconds: 500),
                              context,
                              const CustomSnackBar.info(
                                message:
                                    "Tüm Alanları Doldurduktan Sonra Tekrar Deneyin",
                              ),
                            );
                          }
                        },
                        child: const Text('KAYDET')))
              ],
            ),
          )),
    );
  }

  SabitTextField telText() {
    return SabitTextField(
        controller: telefonController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Telefon Numarası',
        label: 'Tel');
  }

  SabitTextField mailText() {
    return SabitTextField(
        controller: mailController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Mail',
        label: 'Mail');
  }

  SabitTextField tcText() {
    return SabitTextField(
        controller: tcController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'TC Kimlik Numarası',
        label: 'TC');
  }

  SabitTextField soyadText() {
    return SabitTextField(
        controller: soyadController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Soyad',
        label: 'Soyad');
  }

  SabitTextField adText() {
    return SabitTextField(
        controller: adController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Ad',
        label: 'Ad');
  }

  void controllerClear() {
    adController.clear();
    soyadController.clear();
    tcController.clear();
    mailController.clear();
  }
}
