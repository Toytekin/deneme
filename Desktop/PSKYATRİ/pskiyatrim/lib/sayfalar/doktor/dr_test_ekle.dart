import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sabitler/text.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/provider/kategori_adi_gonder.dart';
import 'package:pskiyatrim/provider/siklarin_tiklanmasi.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class DrSoruEklemeSayfasi extends StatefulWidget {
  DanisanModel drUser;

  DrSoruEklemeSayfasi({super.key, required this.drUser});

  @override
  State<DrSoruEklemeSayfasi> createState() => _DrSoruEklemeSayfasiState();
}

class _DrSoruEklemeSayfasiState extends State<DrSoruEklemeSayfasi> {
  // Connroller
  TextEditingController soruController = TextEditingController();

  TextEditingController aController = TextEditingController();

  TextEditingController bController = TextEditingController();

  TextEditingController cController = TextEditingController();

  TextEditingController dController = TextEditingController();

  TextEditingController eController = TextEditingController();

  TextEditingController klasikSoruController = TextEditingController();

  // Page controller
  int _cruntIndex = 0;

  int soruSayisi = 0;

  PageController pageController = PageController();

  String dogruseceenek = '';

  @override
  Widget build(BuildContext context) {
    final ktgriProvider =
        Provider.of<KategoriAdiGonder>(context, listen: false);
    final siklarProvider =
        Provider.of<SiklarinTiklanmasiProvider>(context, listen: true);
    final dbProvider = Provider.of<VeriTabani>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appbar(ktgriProvider, context, siklarProvider),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => _cruntIndex = index);
          },
          children: <Widget>[
            CoktanSecme(siklarProvider, ktgriProvider, dbProvider),
            klasikSoru(ktgriProvider, dbProvider, siklarProvider),
            puanlmaliSoru(ktgriProvider, dbProvider, siklarProvider),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigatorBaR(),
    );
  }

  appbarAdmin appbar(KategoriAdiGonder ktgriProvider, BuildContext context,
      SiklarinTiklanmasiProvider siklarProvider) {
    return appbarAdmin(
      icon: const Icon(
        Icons.save,
        color: Colors.black,
        size: 35,
      ),
      arkaplanRengi: Colors.deepOrange,
      appbarTitile: ktgriProvider.kategoriAdi(),
      press: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Uyarı'),
          content: const Text('Test Ekleme İşlemi Sonlandırılsın mı?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                showTopSnackBar(
                  animationDuration: const Duration(milliseconds: 1200),
                  displayDuration: const Duration(milliseconds: 500),
                  context,
                  const CustomSnackBar.success(
                    message: " Kaydedildi",
                  ),
                );

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) =>
                          DoktorHomeSayfasi(druser: widget.drUser),
                    ),
                    (route) => false);
                siklarProvider.soruSayisi = 0;
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      appbarWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Soru : ${siklarProvider.soruSayisiAl().toString()}',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Padding puanlmaliSoru(KategoriAdiGonder ktgriProvider, VeriTabani dbProvider,
      SiklarinTiklanmasiProvider siklarProvider) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          puanlamaliSoruEklemeTexT(),
          const SizedBox(height: 15),
          puanlamaliTextField(),
          const SizedBox(height: 15),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.6,
                  (MediaQuery.of(context).size.width * 0.8) / 6,
                ),
              ),
              onPressed: () {
                if (klasikSoruController.text.isNotEmpty) {
                  var id = const Uuid().v1();
                  TestModel testModel = TestModel(
                      kategori: ktgriProvider.kategoriAdi(),
                      gonderenDrTc: widget.drUser.danTC.toString(),
                      soru: klasikSoruController.text.toString(),
                      aSikki: '',
                      bSikki: '',
                      cSikki: '',
                      dSikki: '',
                      eSikki: '',
                      cevap: '',
                      gelenCevap: '',
                      tip: 'p',
                      testCozenID: '',
                      soruIdm: id);

                  dbProvider.testEkle(testModel, widget.drUser);
                  siklarProvider.soruArttir();

                  klasikSoruController.clear();
                } else {}
              },
              child: Text(
                'KAYDET',
                style: SaaText.sbtStilBeyaz,
              ))
        ],
      ),
    );
  }

  SabitTextField puanlamaliTextField() {
    return SabitTextField(
        minSize: 4,
        maxSize: 5,
        controller: klasikSoruController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Sorunuzu Bu Alana Yazın',
        label: 'soru');
  }

  Text puanlamaliSoruEklemeTexT() {
    return Text(
      'Puanlamalı Soru Eklme Alanı',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
              offset: const Offset(0.0, 10.0),
              blurRadius: 8.0,
              color: SbtRenkler.instance.anaRenk),
          Shadow(
              offset: const Offset(0.0, 0.0),
              blurRadius: 20.0,
              color: SbtRenkler.instance.anaRenk),
        ],
      ),
    );
  }

  Padding klasikSoru(KategoriAdiGonder ktgriProvider, VeriTabani dbProvider,
      SiklarinTiklanmasiProvider siklarProvider) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          klasikSoruEklemeAlaniText(),
          const SizedBox(height: 15),
          SabitTextField(
              minSize: 4,
              maxSize: 5,
              controller: klasikSoruController,
              bordercolor: SbtRenkler.instance.anaRenk,
              hinText: 'Sorunuzu Bu Alana Yazın',
              label: 'soru'),
          const SizedBox(height: 20),
          klasikKaydetButtonu(ktgriProvider, dbProvider, siklarProvider)
        ],
      ),
    );
  }

  Text klasikSoruEklemeAlaniText() {
    return Text(
      'Klasik Soru Eklme Alanı',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
              offset: const Offset(0.0, 10.0),
              blurRadius: 8.0,
              color: SbtRenkler.instance.anaRenk),
          Shadow(
              offset: const Offset(0.0, 0.0),
              blurRadius: 20.0,
              color: SbtRenkler.instance.anaRenk),
        ],
      ),
    );
  }

  ElevatedButton klasikKaydetButtonu(KategoriAdiGonder ktgriProvider,
      VeriTabani dbProvider, SiklarinTiklanmasiProvider siklarProvider) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.6,
            (MediaQuery.of(context).size.width * 0.8) / 6,
          ),
        ),
        onPressed: () {
          if (klasikSoruController.text.isNotEmpty) {
            var id = const Uuid().v1();

            TestModel testModel = TestModel(
                kategori: ktgriProvider.kategoriAdi(),
                gonderenDrTc: widget.drUser.danTC.toString(),
                soru: klasikSoruController.text.toString(),
                aSikki: '',
                bSikki: '',
                cSikki: '',
                dSikki: '',
                eSikki: '',
                cevap: '',
                gelenCevap: '',
                tip: 'k',
                testCozenID: '',
                soruIdm: id);

            dbProvider.testEkle(testModel, widget.drUser);
            siklarProvider.soruArttir();

            klasikSoruController.clear();
          } else {}
        },
        child: Text(
          'KAYDET',
          style: SaaText.sbtStilBeyaz,
        ));
  }

  // ignore: non_constant_identifier_names
  Padding CoktanSecme(SiklarinTiklanmasiProvider siklarProvider,
      KategoriAdiGonder ktgriProvider, VeriTabani dbProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          soruAlani(),
          const SizedBox(height: 20),
          sikA(),
          const SizedBox(height: 5),
          sikB(),
          const SizedBox(height: 5),
          sikC(),
          const SizedBox(height: 5),
          sikD(),
          const SizedBox(height: 5),
          sikE(),
          const SizedBox(height: 20),
          dogruSecenekler(siklarProvider),
          const SizedBox(height: 20),
          kaydetButtonu(ktgriProvider, dbProvider, siklarProvider)
        ],
      ),
    );
  }

  ElevatedButton kaydetButtonu(KategoriAdiGonder ktgriProvider,
      VeriTabani dbProvider, SiklarinTiklanmasiProvider siklarProvider) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.6,
            (MediaQuery.of(context).size.width * 0.8) / 6,
          ),
        ),
        onPressed: () {
          var id = const Uuid().v1();

          if (aController.text.isNotEmpty &&
              bController.text.isNotEmpty &&
              cController.text.isNotEmpty &&
              dController.text.isNotEmpty &&
              eController.text.isNotEmpty) {
            var data = TestModel(
              kategori: ktgriProvider.kategoriAdi(),
              gonderenDrTc: widget.drUser.danTC.toString(),
              soru: soruController.text.toString(),
              aSikki: aController.text.toString(),
              bSikki: bController.text.toString(),
              cSikki: cController.text.toString(),
              dSikki: dController.text.toString(),
              eSikki: eController.text.toString(),
              cevap: dogruseceenek,
              gelenCevap: '',
              tip: 'c',
              testCozenID: '',
              soruIdm: id,
            );
            dbProvider.testEkle(data, widget.drUser);
            siklarProvider.soruArttir();
            siklarProvider.tumunuTemizle();
            controllerClear();
          } else {}
        },
        child: Text(
          'KAYDET',
          style: SaaText.sbtStilBeyaz,
        ));
  }

  Row dogruSecenekler(SiklarinTiklanmasiProvider siklarProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: siklarProvider.aTiklamaSonuc() == true
                    ? Colors.green
                    : SbtRenkler.instance.anaRenk),
            onPressed: () {
              siklarProvider.atikla();
              dogruseceenek = aController.text.toString();
            },
            child: const Text('A')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: siklarProvider.bTiklamaSonuc() == true
                    ? Colors.green
                    : SbtRenkler.instance.anaRenk),
            onPressed: () {
              siklarProvider.btikla();
              dogruseceenek = bController.text.toString();
            },
            child: const Text('B')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: siklarProvider.cTiklamaSonuc() == true
                    ? Colors.green
                    : SbtRenkler.instance.anaRenk),
            onPressed: () {
              siklarProvider.ctikla();
              dogruseceenek = cController.text.toString();
            },
            child: const Text('C')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: siklarProvider.dTiklamaSonuc() == true
                    ? Colors.green
                    : SbtRenkler.instance.anaRenk),
            onPressed: () {
              dogruseceenek = dController.text.toString();
              siklarProvider.dtikla();
            },
            child: const Text('D')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: siklarProvider.eTiklamaSonuc() == true
                    ? Colors.green
                    : SbtRenkler.instance.anaRenk),
            onPressed: () {
              siklarProvider.etikla();
              dogruseceenek = eController.text.toString();
            },
            child: const Text('E')),
      ],
    );
  }

  SabitTextField sikE() {
    return SabitTextField(
        controller: eController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'E Seçeneği',
        label: 'E');
  }

  SabitTextField sikD() {
    return SabitTextField(
        controller: dController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'D Seçeneği',
        label: 'D');
  }

  SabitTextField sikC() {
    return SabitTextField(
        controller: cController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'C Seçeneği',
        label: 'C');
  }

  SabitTextField sikB() {
    return SabitTextField(
        controller: bController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'B Seçeneği',
        label: 'B');
  }

  SabitTextField sikA() {
    return SabitTextField(
        controller: aController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'A Seçeneği',
        label: 'A');
  }

  SabitTextField soruAlani() {
    return SabitTextField(
        minSize: 5,
        maxSize: 6,
        controller: soruController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Sorunuzu Bu Alana Yazın',
        label: 'Soru');
  }

  controllerClear() {
    soruController.clear();
    aController.clear();
    bController.clear();
    cController.clear();
    dController.clear();
    eController.clear();
  }

  BottomNavyBar bottomNavigatorBaR() {
    return BottomNavyBar(
      backgroundColor: Colors.white,
      iconSize: 25,
      showElevation: true,
      selectedIndex: _cruntIndex,
      onItemSelected: (index) {
        setState(() => _cruntIndex = index);
        pageController.jumpToPage(index);
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            activeColor: SbtRenkler.instance.anaRenk,
            inactiveColor: Colors.grey,
            title: const Text(
              'Çoktan Seçmeli',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            icon: const Icon(Icons.home)),
        BottomNavyBarItem(
            activeColor: SbtRenkler.instance.anaRenk,
            inactiveColor: Colors.grey,
            title: const Text(
              'Klasik',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            icon: const Icon(Icons.apps)),
        BottomNavyBarItem(
            activeColor: SbtRenkler.instance.anaRenk,
            inactiveColor: Colors.grey,
            title: const Text(
              'Puanlamalı',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            icon: const Icon(Icons.chat_bubble)),
      ],
    );
  }
}
