import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';

// ignore: must_be_immutable
class ProfilYazi extends StatelessWidget {
  DanisanModel danisanModel;
  ProfilYazi({super.key, required this.danisanModel});

  var yaziController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<VeriTabani>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              yaziAlani(),
              ElevatedButton(
                  onPressed: () {
                    var doktorModelData = DoktorModel(
                      danAdSoyad:
                          '${danisanModel.danAd}  ${danisanModel.danSoyad}',
                      danTC: danisanModel.danTC,
                      yazi: yaziController.text.toString(),
                    );
                    db.doktorSiviEkle(doktorModelData);
                    yaziController.clear();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          DoktorHomeSayfasi(druser: danisanModel),
                    ));
                  },
                  child: const Text('KAYDET'))
            ],
          ),
        ),
      )),
    );
  }

  SabitTextField yaziAlani() {
    return SabitTextField(
        keybordTyp: TextInputType.multiline,
        maxSize: 10,
        minSize: 6,
        controller: yaziController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Yazı Alanı',
        label: 'Text');
  }
}
