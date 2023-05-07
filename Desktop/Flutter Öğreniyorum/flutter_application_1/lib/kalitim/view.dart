import 'package:flutter/material.dart';
import 'package:flutter_application_1/kalitim/kalitim.dart';
import 'package:flutter_application_1/widget/textfild.dart';

class AbstracClassKullanimi extends StatefulWidget {
  const AbstracClassKullanimi({super.key});

  @override
  State<AbstracClassKullanimi> createState() => _AbstracClassKullanimiState();
}

class _AbstracClassKullanimiState extends State<AbstracClassKullanimi> {
  var adController = TextEditingController();
  var soyadController = TextEditingController();
  var sifreController = TextEditingController();

  var sinifObjem = Sinif1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            SabtTextFild(
              controller: adController,
              hintText: 'Ad',
            ),
            SabtTextFild(
              controller: soyadController,
              hintText: 'Soyad',
            ),
            SabtTextFild(
              controller: sifreController,
              hintText: 'Şifre',
            ),
            ElevatedButton(
              child: const Text('Kontol et'),
              onPressed: () async {
                if (adController.text.isNotEmpty &&
                    soyadController.text.isNotEmpty &&
                    sifreController.text.isNotEmpty) {
                  var olusanUser = await sinifObjem.girisYap(adController.text,
                      soyadController.text, sifreController.text);

                  var adminDurumu = await sinifObjem.adminMi(olusanUser!);

                  debugPrint(olusanUser.ad.toString());
                  debugPrint(olusanUser.soyad.toString());
                  debugPrint(olusanUser.sifre.toString());
                  debugPrint('Bu Kişi Admimn mi: $adminDurumu');
                } else {
                  debugPrint('Tüm alasnlar dolumuı?');
                }
              },
            )
          ],
        ));
  }
}
