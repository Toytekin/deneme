import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/musteri/musteri_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DenemeMusteri extends StatefulWidget {
  DanisanModel danisanModel;
  TestModel test;
  DoktorModel doktorModel;
  DenemeMusteri(
      {super.key,
      required this.test,
      required this.danisanModel,
      required this.doktorModel});

  @override
  State<DenemeMusteri> createState() => _DenemeMusteriState();
}

class _DenemeMusteriState extends State<DenemeMusteri> {
  FirebaseFirestore users = FirebaseFirestore.instance;
//tiklanm
  bool aTiklandi = false;
  bool bTiklandi = false;
  bool cTiklandi = false;
  bool dTiklandi = false;
  bool eTiklandi = false;

// Değişkenler
  int soruSayisi = 0;

  late int listeuzunlu;

  String gelenCevap = '';
  List<TestModel> tumKullanicilar = [];

// Kontroller
  TextEditingController klasikCevapController = TextEditingController();

  // Puanlı
  double slideValue = 0.0;

  @override
  build(BuildContext context) {
    final dbProvider = Provider.of<VeriTabani>(context);

    return Scaffold(
      // Appbar
      appBar: AppBar(actions: [
        Text(gelenCevap.toString()),
        Text(soruSayisi.toString()),
      ]),

      body: Center(
        child: FutureBuilder<List<TestModel>>(
          future: dbProvider.testGetir(widget.danisanModel, widget.test),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              listeuzunlu = snapshot.data!.length;

              if (soruSayisi > listeuzunlu) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MusteriHomeSayfasi(
                    danisanModel: widget.danisanModel,
                  ),
                ));
              }
              var oAnkiVeri = snapshot.data![soruSayisi];
              //? ******************************************

              //! çoktan seçmeli
              if (oAnkiVeri.tip == 'c') {
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
                      child: Center(child: Text(oAnkiVeri.soru)),
                    ),
                    const SizedBox(height: 10),
                    //! A şıkkı tıklama
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: aTiklamaSonuc() == true
                                  ? Colors.green
                                  : SbtRenkler.instance.anaRenk),
                          onPressed: () {
                            gelenCevap = oAnkiVeri.aSikki;
                            atikla();
                          },
                          child: Text(oAnkiVeri.aSikki)),
                    ),
                    //! B şıkkı tıklama

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: bTiklamaSonuc() == true
                                  ? Colors.green
                                  : SbtRenkler.instance.anaRenk),
                          onPressed: () {
                            gelenCevap = oAnkiVeri.bSikki;

                            btikla();
                          },
                          child: Text(oAnkiVeri.bSikki)),
                    ),
                    //! C şıkkı tıklama

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: cTiklamaSonuc() == true
                                  ? Colors.green
                                  : SbtRenkler.instance.anaRenk),
                          onPressed: () {
                            gelenCevap = oAnkiVeri.cSikki;

                            ctikla();
                          },
                          child: Text(oAnkiVeri.cSikki)),
                    ),
                    //! D şıkkı tıklama

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: dTiklamaSonuc() == true
                                  ? Colors.green
                                  : SbtRenkler.instance.anaRenk),
                          onPressed: () {
                            gelenCevap = oAnkiVeri.dSikki;

                            dtikla();
                          },
                          child: Text(oAnkiVeri.dSikki)),
                    ),
                    //! E şıkkı tıklama

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: eTiklamaSonuc() == true
                                  ? Colors.green
                                  : SbtRenkler.instance.anaRenk),
                          onPressed: () {
                            gelenCevap = oAnkiVeri.eSikki;

                            etikla();
                          },
                          child: Text(oAnkiVeri.eSikki)),
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
                                  animationDuration:
                                      const Duration(milliseconds: 1200),
                                  displayDuration:
                                      const Duration(milliseconds: 500),
                                  context,
                                  const CustomSnackBar.info(
                                    message: "Cevap Vermediniz Sanırım !",
                                  ),
                                );
                              } else {
                                var testModel = TestModel(
                                    kategori: oAnkiVeri.kategori,
                                    gonderenDrTc: oAnkiVeri.gonderenDrTc,
                                    soru: oAnkiVeri.soru,
                                    aSikki: oAnkiVeri.aSikki,
                                    bSikki: oAnkiVeri.bSikki,
                                    cSikki: oAnkiVeri.cSikki,
                                    dSikki: oAnkiVeri.dSikki,
                                    eSikki: oAnkiVeri.eSikki,
                                    cevap: oAnkiVeri.cevap,
                                    gelenCevap: gelenCevap,
                                    tip: oAnkiVeri.tip,
                                    testCozenID: oAnkiVeri.testCozenID,
                                    soruIdm: oAnkiVeri.soruIdm);

                                dbProvider.danisanCevapAl(
                                    widget.danisanModel, testModel);

                                //Burayı Düşüm
                                if (soruSayisi + 1 < listeuzunlu - 1) {
                                  setState(() {});
                                  soruSayisi = soruSayisi + 1;
                                  tumunuTemizle();
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MusteriHomeSayfasi(
                                      danisanModel: widget.danisanModel,
                                    ),
                                  ));
                                }
                                //
                              }
                            },
                            child: const Text('KAYDET')),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                );
              }
              //? ******************************************

              //! klasik seçmeli

              else if (oAnkiVeri.tip == 'k') {
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
                      child: Center(child: Text(oAnkiVeri.soru)),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SabitTextField(
                          controller: klasikCevapController,
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
                            gelenCevap = klasikCevapController.text.toString();
                            if (gelenCevap == '') {
                              showTopSnackBar(
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                displayDuration:
                                    const Duration(milliseconds: 500),
                                context,
                                const CustomSnackBar.info(
                                  message: " Cevap Vermediniz Sanırım !",
                                ),
                              );
                            } else {
                              var testModel = TestModel(
                                  kategori: oAnkiVeri.kategori,
                                  gonderenDrTc: oAnkiVeri.gonderenDrTc,
                                  soru: oAnkiVeri.soru,
                                  aSikki: oAnkiVeri.aSikki,
                                  bSikki: oAnkiVeri.bSikki,
                                  cSikki: oAnkiVeri.cSikki,
                                  dSikki: oAnkiVeri.dSikki,
                                  eSikki: oAnkiVeri.eSikki,
                                  cevap: oAnkiVeri.cevap,
                                  gelenCevap: gelenCevap,
                                  tip: oAnkiVeri.tip,
                                  testCozenID: oAnkiVeri.testCozenID,
                                  soruIdm: oAnkiVeri.soruIdm);
                              dbProvider.danisanCevapAl(
                                  widget.danisanModel, testModel);
                              if (soruSayisi + 1 < listeuzunlu - 1) {
                                setState(() {});
                                soruSayisi = soruSayisi + 1;
                                tumunuTemizle();
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MusteriHomeSayfasi(
                                    danisanModel: widget.danisanModel,
                                  ),
                                ));
                              }
                            }
                          },
                          child: const Text('KAYDET')),
                    ),
                  ],
                );
              }
              //? ******************************************
              //! puanlamali seçmeli
              else if (oAnkiVeri.tip == 'p') {
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
                      child: Center(child: Text(oAnkiVeri.soru)),
                    ),
                    const SizedBox(height: 10),
                    Slider(
                      activeColor: Colors.green,
                      max: 100.0,
                      divisions: 10,
                      label: '$slideValue',
                      value: slideValue,
                      onChanged: (value) {
                        //Değişkene aktar
                        setState(() {
                          gelenCevap = value.toString();
                          slideValue = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 50),
                            backgroundColor: Colors.deepOrange,
                          ),
                          onPressed: () async {
                            if (gelenCevap == '') {
                              showTopSnackBar(
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                displayDuration:
                                    const Duration(milliseconds: 500),
                                context,
                                const CustomSnackBar.info(
                                  message: " Cevap Vermediniz Sanırım",
                                ),
                              );
                            } else {
                              var testModel = TestModel(
                                  kategori: oAnkiVeri.kategori,
                                  gonderenDrTc: oAnkiVeri.gonderenDrTc,
                                  soru: oAnkiVeri.soru,
                                  aSikki: oAnkiVeri.aSikki,
                                  bSikki: oAnkiVeri.bSikki,
                                  cSikki: oAnkiVeri.cSikki,
                                  dSikki: oAnkiVeri.dSikki,
                                  eSikki: oAnkiVeri.eSikki,
                                  cevap: oAnkiVeri.cevap,
                                  gelenCevap: gelenCevap,
                                  tip: oAnkiVeri.tip,
                                  testCozenID: oAnkiVeri.testCozenID,
                                  soruIdm: oAnkiVeri.soruIdm);

                              dbProvider.danisanCevapAl(
                                  widget.danisanModel, testModel);
                              if (soruSayisi + 1 < listeuzunlu - 1) {
                                setState(() {});
                                soruSayisi = soruSayisi + 1;
                                tumunuTemizle();
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MusteriHomeSayfasi(
                                    danisanModel: widget.danisanModel,
                                  ),
                                ));
                              }
                            }
                          },
                          child: const Text('KAYDET')),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  tumunuTemizle() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
  }

  bool aTiklamaSonuc() {
    return aTiklandi;
  }

  bool bTiklamaSonuc() {
    return bTiklandi;
  }

  bool cTiklamaSonuc() {
    return cTiklandi;
  }

  bool dTiklamaSonuc() {
    return dTiklandi;
  }

  bool eTiklamaSonuc() {
    return eTiklandi;
  }

  atikla() {
    // ignore: unused_local_variable
    aTiklandi = true;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
    setState(() {});
  }

  btikla() {
    aTiklandi = false;
    bTiklandi = true;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = false;
    setState(() {});
  }

  ctikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = true;
    dTiklandi = false;
    eTiklandi = false;
    setState(() {});
  }

  dtikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = true;
    eTiklandi = false;
    setState(() {});
  }

  etikla() {
    aTiklandi = false;
    bTiklandi = false;
    cTiklandi = false;
    dTiklandi = false;
    eTiklandi = true;
    setState(() {});
  }
}
