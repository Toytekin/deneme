import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/cozulen_test_gosterme.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_dn_notlar.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_test_gonder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DanisanDetay extends StatefulWidget {
  DanisanModel danisanModel;
  DanisanModel druser;

  DanisanDetay({super.key, required this.danisanModel, required this.druser});

  @override
  State<DanisanDetay> createState() => _DanisanDetayState();
}

class _DanisanDetayState extends State<DanisanDetay> {
  @override
  Widget build(BuildContext context) {
    //Veritabanı
    var dbProvider = Provider.of<VeriTabani>(context, listen: false);

    var provider = Provider.of<VeriTabani>(context);
    return Scaffold(
      appBar: appbar(context, dbProvider),
      body: Column(
        children: [
          //! Kişi Bİlgileri
          Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      '${widget.danisanModel.danAd} ${widget.danisanModel.danSoyad}',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.danisanModel.danTel.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              danisanTelefonAramasi();
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.deepOrange,
                              size: 23,
                            )),
                      ],
                    ),
                    //! NOTLAR KISMI
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Notlar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DrDanisanNotlarSayfasi(
                                    danisanModel: widget.danisanModel,
                                    druser: widget.druser),
                              ));
                            },
                            icon: const Icon(
                              Icons.note_add,
                              color: Colors.deepOrange,
                              size: 23,
                            )),
                      ],
                    ),
                  ],
                ),
              )),
          //! Yapılan Terstler
          Expanded(
            child: FutureBuilder<List<TestModel>>(
              future: provider.danisanKategoriGetir(widget.druser),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var oankiVeri = snapshot.data![index];

                      if (oankiVeri.testCozenID ==
                          widget.danisanModel.danTC.toString()) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CozulenTestGosterme(
                                  danisanModel: widget.danisanModel,
                                  test: oankiVeri),
                            ));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(oankiVeri.kategori),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SbtRenkler.instance.anaRenk,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DrTestGonder(
                danisanModel: widget.danisanModel, druser: widget.druser),
          ));
        },
        child: const Icon(Icons.send),
      ),
    );
  }

  appbarAdmin appbar(BuildContext context, VeriTabani dbProvider) {
    return appbarAdmin(
      arkaplanRengi: Colors.deepOrange,
      appbarTitile:
          '${widget.danisanModel.danAd}  ${widget.danisanModel.danSoyad}',
      press: () {
        Navigator.of(context).pop();
      },
      appbarWidget: IconButton(
          onPressed: () {
            //! Sİlme işklemi

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                    '${widget.danisanModel.danAd!} ${widget.danisanModel.danSoyad}'),
                content: const Text('Silinme işlemini onaylıyor musun ?'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () {
                      ///! Silme
                      dbProvider.userDanisanDelete(widget.danisanModel);
                      showTopSnackBar(
                        animationDuration: const Duration(milliseconds: 1200),
                        displayDuration: const Duration(milliseconds: 500),
                        context,
                        const CustomSnackBar.success(
                          message: "Kişi Silindi",
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              DoktorHomeSayfasi(druser: widget.druser)));
                    },
                    child: const Text(' SİL   '),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('VAZGEÇ'),
                  )
                ],
              ),
            );
          },
          icon: const Icon(Icons.delete)),
    );
  }

  Future<void> danisanTelefonAramasi() async {
    // ignore: no_leading_underscores_for_local_identifiers
    String _url = 'tel:${widget.danisanModel.danTel}';

    final url = Uri.parse(_url);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw 'Geçersiz';
    }
  }
}
