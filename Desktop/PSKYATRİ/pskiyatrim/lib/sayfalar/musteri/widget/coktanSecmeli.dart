import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/provider/siklarin_tiklanmasi.dart';
import 'package:pskiyatrim/provider/soru_sayisi.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class CoktanSecmeli extends StatelessWidget {
  DanisanModel danisanModel;
  TestModel test;
  CoktanSecmeli({
    super.key,
    required this.test,
    required this.danisanModel,
  });
// Değişkenler
  int soruSayisi = 0;
  late int listeuzunlu;
  String gelenCevap = '';
  @override
  Widget build(BuildContext context) {
    // Providerlar
    final dbProvider = Provider.of<VeriTabani>(context);
    final siklarProvider =
        Provider.of<SiklarinTiklanmasiProvider>(context, listen: true);
    final soruSayisiProvider =
        Provider.of<SoruSayisiProvider>(context, listen: true);
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width - 20,
          height: 200,
          child: Center(child: Text(test.soru)),
        ),
        const SizedBox(height: 10),
        //! A şıkkı tıklama
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: siklarProvider.aTiklamaSonuc() == true
                      ? Colors.green
                      : SbtRenkler.instance.anaRenk),
              onPressed: () {
                siklarProvider.atikla();
                gelenCevap = test.aSikki;
              },
              child: Text(test.aSikki)),
        ),
        //! B şıkkı tıklama

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: siklarProvider.bTiklamaSonuc() == true
                      ? Colors.green
                      : SbtRenkler.instance.anaRenk),
              onPressed: () {
                siklarProvider.btikla();
                gelenCevap = test.bSikki;
              },
              child: Text(test.bSikki)),
        ),
        //! C şıkkı tıklama

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: siklarProvider.cTiklamaSonuc() == true
                      ? Colors.green
                      : SbtRenkler.instance.anaRenk),
              onPressed: () {
                siklarProvider.ctikla();
                gelenCevap = test.cSikki;
              },
              child: Text(test.cSikki)),
        ),
        //! D şıkkı tıklama

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: siklarProvider.dTiklamaSonuc() == true
                      ? Colors.green
                      : SbtRenkler.instance.anaRenk),
              onPressed: () {
                siklarProvider.dtikla();
                gelenCevap = test.dSikki;
              },
              child: Text(test.dSikki)),
        ),
        //! E şıkkı tıklama

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: siklarProvider.eTiklamaSonuc() == true
                      ? Colors.green
                      : SbtRenkler.instance.anaRenk),
              onPressed: () {
                siklarProvider.etikla();
                gelenCevap = test.eSikki;
              },
              child: Text(test.eSikki)),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            width: 20,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
                onPressed: () async {
                  if (gelenCevap == '') {
                    showTopSnackBar(
                      animationDuration: const Duration(milliseconds: 1200),
                      displayDuration: const Duration(milliseconds: 500),
                      context,
                      const CustomSnackBar.info(
                        message: "Cevap Vermediniz Sanırım !",
                      ),
                    );
                  } else {
                    var testModel = TestModel(
                        kategori: test.kategori,
                        gonderenDrTc: test.gonderenDrTc,
                        soru: test.soru,
                        aSikki: test.aSikki,
                        bSikki: test.bSikki,
                        cSikki: test.cSikki,
                        dSikki: test.dSikki,
                        eSikki: test.eSikki,
                        cevap: test.cevap,
                        gelenCevap: gelenCevap,
                        tip: test.tip,
                        testCozenID: test.testCozenID,
                        soruIdm: test.soruIdm);
                    await dbProvider.danisanCevapAl(danisanModel, testModel);
                    // ignore: use_build_context_synchronously
                    showTopSnackBar(
                      animationDuration: const Duration(milliseconds: 1200),
                      displayDuration: const Duration(milliseconds: 500),
                      context,
                      const CustomSnackBar.success(
                        message: " Kaydedildi",
                      ),
                    );

                    soruSayisiProvider.cevapVer();
                  }
                },
                child: const Text('KAYDET')),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Container SoruAlani(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width - 20,
      height: 200,
      child: Center(child: Text(test.soru)),
    );
  }
}
