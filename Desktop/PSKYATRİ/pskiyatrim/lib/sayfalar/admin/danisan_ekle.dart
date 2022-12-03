import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DanisanEkleSayfasi extends StatelessWidget {
  DanisanModel drUser;
  DanisanEkleSayfasi({super.key, required this.drUser});

  CollectionReference dbusers = FirebaseFirestore.instance.collection('users');

  TextEditingController adController = TextEditingController();
  TextEditingController soyadController = TextEditingController();
  TextEditingController tcController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController kisanotController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: appbarAdmin(
            appbarTitile: 'Danışan Ekle',
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
                notText(),
                const SizedBox(height: 10),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> userMap = {
                            'ad': adController.text.toString(),
                            'soyad': soyadController.text.toString(),
                            'tc': tcController.text.toString(),
                            'mail': mailController.text.toString(),
                            'not': kisanotController.text.toString(),
                            'sifre': tcController.text.toString(),
                            'dr': drUser.danTC.toString(),
                            'danTel': telefonController.text.toString()
                          };

                          if (adController.text.isNotEmpty &&
                              soyadController.text.isNotEmpty &&
                              tcController.text.isNotEmpty &&
                              mailController.text.isNotEmpty &&
                              tcController.text.length == 11 &&
                              telefonController.text.length == 11) {
                            Navigator.of(context).pop();
                            showTopSnackBar(
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              displayDuration:
                                  const Duration(milliseconds: 500),
                              context,
                              const CustomSnackBar.success(
                                message: "Kişi Kaydedildi",
                              ),
                            );
                            await dbusers
                                .doc(tcController.text.toString())
                                .set(userMap);
                            controllerClear();
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

  TextField telText() {
    return TextField(
      maxLength: 11,
      keyboardType: TextInputType.number,
      controller: telefonController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: SbtRenkler.instance.anaRenk),
          ),
          label: const Text('TEL'),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 10, color: SbtRenkler.instance.anaRenk),
          ),
          hintText: 'Telefon Numarasını Yazın'),
    );
  }

  SabitTextField notText() {
    return SabitTextField(
      controller: kisanotController,
      bordercolor: SbtRenkler.instance.anaRenk,
      hinText: 'Kısa bir not ...',
      label: 'Not',
      minSize: 3,
      maxSize: 4,
    );
  }

  SabitTextField mailText() {
    return SabitTextField(
        controller: mailController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Mail',
        label: 'Mail');
  }

  TextField tcText() {
    return TextField(
      maxLength: 11,
      keyboardType: TextInputType.number,
      controller: tcController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: SbtRenkler.instance.anaRenk),
          ),
          label: const Text('TC'),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 10, color: SbtRenkler.instance.anaRenk),
          ),
          hintText: 'TC Giriniz'),
    );
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
    kisanotController.clear();
  }
}
