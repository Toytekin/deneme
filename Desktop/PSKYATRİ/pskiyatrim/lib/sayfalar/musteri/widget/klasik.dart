import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/provider/soru_sayisi.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../sabitler/color.dart';

// ignore: must_be_immutable
class KlasikWidget extends StatelessWidget {
  DanisanModel danisanModel;
  TestModel test;
  KlasikWidget({
    super.key,
    required this.test,
    required this.danisanModel,
  });
  String gelenCevap = '';

  TextEditingController t1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<VeriTabani>(context);
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SabitTextField(
              controller: t1,
              bordercolor: SbtRenkler.instance.anaRenk,
              hinText: 'Lütfen cevanımızı bu alana giriniz',
              label: 'Cevap'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () async {
                gelenCevap = t1.text.toString();
                if (gelenCevap == '') {
                  showTopSnackBar(
                    animationDuration: const Duration(milliseconds: 1200),
                    displayDuration: const Duration(milliseconds: 500),
                    context,
                    const CustomSnackBar.info(
                      message: " Cevap Vermediniz Sanırım !",
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
                  await soruSayisiProvider.cevapVer();
                  // ignore: use_build_context_synchronously
                  showTopSnackBar(
                    animationDuration: const Duration(milliseconds: 1200),
                    displayDuration: const Duration(milliseconds: 500),
                    context,
                    const CustomSnackBar.success(
                      message: " Kaydedildi",
                    ),
                  );
                  dbProvider.danisanCevapAl(danisanModel, testModel);
                }
              },
              child: const Text('KAYDET')),
        ),
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
