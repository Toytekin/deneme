import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DrTestGonder extends StatelessWidget {
  DanisanModel danisanModel;
  DanisanModel druser;
  DrTestGonder({
    super.key,
    required this.danisanModel,
    required this.druser,
  });

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context, listen: false);

    var provider = Provider.of<VeriTabani>(context);
    return Scaffold(
      appBar: appbarAdmin(
        appbarWidget: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DoktorHomeSayfasi(druser: druser),
              ));
            },
            icon: const Icon(Icons.home)),
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: druser.danAd.toString(),
        press: () {
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<List<TestModel>>(
        future: provider.kategoriGetir(druser),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var oankiVeri = snapshot.data![index];
                return InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Test Gönderilsin mi?'),
                        content: Text(oankiVeri.kategori.toString()),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              var kisiTest = TestModel(
                                  kategori: oankiVeri.kategori,
                                  gonderenDrTc: druser.danTC.toString(),
                                  soru: oankiVeri.soru,
                                  aSikki: oankiVeri.aSikki,
                                  bSikki: oankiVeri.bSikki,
                                  cSikki: oankiVeri.cSikki,
                                  dSikki: oankiVeri.dSikki,
                                  eSikki: oankiVeri.eSikki,
                                  cevap: oankiVeri.cevap,
                                  gelenCevap: oankiVeri.gelenCevap,
                                  tip: oankiVeri.tip,
                                  testCozenID: danisanModel.danTC.toString(),
                                  soruIdm: oankiVeri.soruIdm);
                              dbProvider.danisanTestGonder(
                                  kisiTest, danisanModel);
                              showTopSnackBar(
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                displayDuration:
                                    const Duration(milliseconds: 500),
                                context,
                                const CustomSnackBar.success(
                                  message: " Kaydedildi",
                                ),
                              );

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoktorHomeSayfasi(druser: druser),
                                  ),
                                  (route) => false);
                            },
                            child: const Text('EVET'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(oankiVeri.kategori),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
