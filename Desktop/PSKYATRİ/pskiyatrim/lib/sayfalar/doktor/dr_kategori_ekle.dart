import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/sabitler/text.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/provider/kategori_adi_gonder.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_test_ekle.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DrKategoriEkle extends StatelessWidget {
  DanisanModel drUser;
  DrKategoriEkle({super.key, required this.drUser});

  // TEXTEDİTİNG CONTROLLER
  TextEditingController t1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    KategoriAdiGonder ktgriProvider =
        Provider.of<KategoriAdiGonder>(context, listen: false);
    return Scaffold(
      appBar: appbarAdmin(
          arkaplanRengi: Colors.deepOrange,
          appbarTitile: 'Kategori Ekle',
          press: () => Navigator.of(context).pop()),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kategoriAdiText(),
              const SizedBox(height: 15),
              kaydetButtonu(context, ktgriProvider)
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton kaydetButtonu(
      BuildContext context, KategoriAdiGonder ktgriProvider) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.6,
            (MediaQuery.of(context).size.width * 0.8) / 6,
          ),
        ),
        onPressed: () {
          if (t1.text.isEmpty || t1.text.length < 6) {
            snakBar(context);
          } else {
            ktgriProvider.kategoriAl(t1.text.toString());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DrSoruEklemeSayfasi(drUser: drUser),
            ));
          }
        },
        child: Text(
          'Kaydet',
          style: SaaText.sbtStilBeyaz,
        ));
  }

  void snakBar(BuildContext context) {
    return showTopSnackBar(
      animationDuration: const Duration(milliseconds: 1200),
      displayDuration: const Duration(milliseconds: 500),
      context,
      const CustomSnackBar.info(
        message: "En az 6 karakter girdiğine emin ol.",
      ),
    );
  }

  SabitTextField kategoriAdiText() {
    return SabitTextField(
        controller: t1,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Kategori Adını Girin',
        label: 'Kategori');
  }
}
