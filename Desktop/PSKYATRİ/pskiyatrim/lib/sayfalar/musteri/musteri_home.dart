import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/test_model.dart';
import 'package:pskiyatrim/giri_mail.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/sayfalar/musteri/musteri_test_goster.dart';

// ignore: must_be_immutable
class MusteriHomeSayfasi extends StatefulWidget {
  DanisanModel danisanModel;
  MusteriHomeSayfasi({super.key, required this.danisanModel, l});

  @override
  State<MusteriHomeSayfasi> createState() => _MusteriHomeSayfasiState();
}

class _MusteriHomeSayfasiState extends State<MusteriHomeSayfasi> {
  FirebaseFirestore users = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<VeriTabani>(context, listen: true);

    return Scaffold(
      appBar: appbarDanisan(context),
      body: Center(
          child: Column(
        children: [
          // Card(
          //     margin: const EdgeInsets.all(8),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Text(
          //             '${widget.danisanModel.danAd} ${widget.danisanModel.danSoyad}',
          //             style: const TextStyle(color: Colors.white, fontSize: 22),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Text(
          //                 widget.danisanModel.danTel.toString(),
          //                 style: const TextStyle(
          //                     color: Colors.white, fontSize: 16),
          //               ),
          //               IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(
          //                     Icons.phone,
          //                     color: Colors.deepOrange,
          //                     size: 23,
          //                   )),
          //             ],
          //           ),
          //           //! NOTLAR KISMI
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               const Text(
          //                 'Notlar',
          //                 style: TextStyle(color: Colors.white, fontSize: 16),
          //               ),
          //               IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(
          //                     Icons.note_add,
          //                     color: Colors.deepOrange,
          //                     size: 23,
          //                   )),
          //             ],
          //           ),
          //         ],
          //       ),
          //     )),

          Expanded(
            child: FutureBuilder<List<TestModel>>(
              future: db.danisanTestGetir(widget.danisanModel),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      TestModel oankiVeri = snapshot.data![index];

                      return InkWell(
                        onTap: () async {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MusteriTestGetirEkrani(
                                    danisanModel: widget.danisanModel,
                                    test: oankiVeri,
                                  )));
                        },
                        child: Card(
                            child: ListTile(
                                title: Text(
                          oankiVeri.kategori,
                        ))),
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
          )
        ],
      )),
    );
  }

  appbarAdmin appbarDanisan(BuildContext context) {
    return appbarAdmin(
      arkaplanRengi: Colors.lightGreen,
      appbarTitile: widget.danisanModel.danAd.toString(),
      press: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const GiriMail(),
        ));
      },
    );
  }
}
