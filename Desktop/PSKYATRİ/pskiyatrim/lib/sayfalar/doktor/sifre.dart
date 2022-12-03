import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/giri_mail.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class SifreDegistir extends StatelessWidget {
  DanisanModel user;
  SifreDegistir({super.key, required this.user});

  var dbusers = FirebaseFirestore.instance.collection('psikolog');

  TextEditingController eskiController = TextEditingController();
  TextEditingController yeniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarAdmin(
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: '${user.danAd}  ${user.danSoyad}',
        press: () async {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sifre(),
              const SizedBox(height: 20),
              yenisifre(),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SbtRenkler.instance.anaRenk,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      (MediaQuery.of(context).size.width * 0.8) / 6,
                    ),
                  ),
                  onPressed: () async {
                    if (user.danSifre.toString() ==
                        eskiController.text.toString()) {
                      await dbusers.doc(user.danTC).set(
                          {'sifre': yeniController.text.toString()},
                          SetOptions(merge: true));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const GiriMail(),
                          ),
                          (route) => false);
                    } else {
                      showTopSnackBar(
                        animationDuration: const Duration(milliseconds: 1200),
                        displayDuration: const Duration(milliseconds: 500),
                        context,
                        const CustomSnackBar.info(
                          message:
                              "Eski Şifrenizi Doğru Girdiğinizden Emiin Olun.",
                        ),
                      );
                    }
                  },
                  child: Text(
                    'KAYDET',
                    style: SaaText.sbtStilBeyaz,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> yeniMap(DanisanModel user) {
    Map<String, dynamic> yeniSifre = {
      'ad': user.danAd,
      'soyad': user.danSoyad,
      'tc': user.danTC,
      'mail': user.danMail,
      'not': user.not,
      'sifre': yeniController.text.toString(),
    };
    return yeniSifre;
  }

  SabitTextField yenisifretekrar() {
    return SabitTextField(
        controller: eskiController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Yeni Şifreniz',
        label: 'Şifre');
  }

  SabitTextField yenisifre() {
    return SabitTextField(
        controller: yeniController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Yeni Şifreniz',
        label: 'Şifre');
  }

  SabitTextField sifre() {
    return SabitTextField(
        controller: eskiController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Mevcut Şifreniz',
        label: 'Şifre');
  }
}
