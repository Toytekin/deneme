import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/musteri/musteri_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:reviews_slider/reviews_slider.dart';

// ignore: must_be_immutable
class MusteriTestGetirEkrani extends StatefulWidget {
  DanisanModel danisanModel;
  TestModel test;

  MusteriTestGetirEkrani(
      {super.key, required this.test, required this.danisanModel, l});

  @override
  State<MusteriTestGetirEkrani> createState() => _MusteriTestGetirEkraniState();
}

class _MusteriTestGetirEkraniState extends State<MusteriTestGetirEkrani> {
  FirebaseFirestore users = FirebaseFirestore.instance;
//tiklanm
  bool aTiklandi = false;
  bool bTiklandi = false;
  bool cTiklandi = false;
  bool dTiklandi = false;
  bool eTiklandi = false;

// Değişkenler
  int aktifSoru = 0;

  late int listeuzunlu;

  String gelenCevap = '';

// Kontroller
  TextEditingController klasikCevapController = TextEditingController();

  // Puanlı
  double slideValue = 0.0;

  GlobalKey key = GlobalKey();

  @override
  build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context);

    return Scaffold(
      key: key,
      // Appbar
      appBar: AppBar(actions: [Text(aktifSoru.toString())]),

      body: Center(
        child: FutureBuilder<List<TestModel>>(
          future: dbProvider.testGetir(widget.danisanModel, widget.test),
          builder: (context, snapshot) {
            // ignore: unnecessary_null_comparison
            if (snapshot.hasData) {
              listeuzunlu = snapshot.data!.length;

              var oAnkiVeri = snapshot.data![aktifSoru];
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
                              elevation: 1,
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
                              elevation: 1,
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
                              elevation: 1,
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
                              elevation: 1,
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
                              elevation: 1,
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
                                await dbProvider.danisanCevapAl(
                                    widget.danisanModel, testModel);

                                if (aktifSoru + 1 < listeuzunlu) {
                                  setState(() {
                                    aktifSoru = aktifSoru + 1;
                                    gelenCevap = '';
                                    tumunuTemizle();
                                  });
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
                    ),
                    const SizedBox(height: 20)
                  ],
                );

                //sds
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
                    klasikTextfiled(),
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
                              await dbProvider.danisanCevapAl(
                                  widget.danisanModel, testModel);

                              if (aktifSoru + 1 < listeuzunlu) {
                                setState(() {
                                  aktifSoru = aktifSoru + 1;
                                  gelenCevap = '';
                                  tumunuTemizle();
                                  klasikCevapController.clear();
                                });
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
                    ReviewSlider(
                        options: const [
                          'Berbat',
                          'Kötü',
                          'İdare Eder',
                          'iyi',
                          'Süper'
                        ],
                        onChange: (int value) {
                          switch (value) {
                            case 0:
                              gelenCevap = 'Berbat';
                              break;
                            case 1:
                              gelenCevap = 'Kötü';
                              break;
                            case 2:
                              gelenCevap = 'İdare Eder';
                              break;
                            case 3:
                              gelenCevap = 'iyi';
                              break;
                            case 4:
                              gelenCevap = 'Süper';
                              break;
                            default:
                          }

                          debugPrint(gelenCevap);
                        }),
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

                              await dbProvider.danisanCevapAl(
                                  widget.danisanModel, testModel);
                              if (aktifSoru + 1 < listeuzunlu) {
                                setState(() {
                                  aktifSoru = aktifSoru + 1;
                                  gelenCevap = '';
                                  tumunuTemizle();
                                });
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
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Padding klasikTextfiled() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SabitTextField(
          controller: klasikCevapController,
          bordercolor: SbtRenkler.instance.anaRenk,
          hinText: 'Lütfen cevanımızı bu alana giriniz',
          label: 'Cevap'),
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
