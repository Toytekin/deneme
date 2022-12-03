import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_tc.dart';
import 'package:pskiyatrim/sabitler/resimyolu.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/danisan_detay.dart';

// ignore: must_be_immutable
class DrDanisalarSayfasi extends StatelessWidget {
  DanisanModel druser;
  DrDanisalarSayfasi({super.key, required this.druser});

  CollectionReference dbusers = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context, listen: false);
    var dbProviderDr = Provider.of<DrTc>(context, listen: false);

    return Scaffold(
        appBar: appbarAdmin(
          arkaplanRengi: Colors.deepOrange,
          appbarTitile: 'DANIŞANLAR',
          press: () {
            Navigator.of(context).pop();
          },
        ),
        body: FutureBuilder<List<DanisanModel>>(
          future: dbProvider.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DanisanModel>? tumKullanicilar = snapshot.data;

              return ListView.builder(
                itemCount: tumKullanicilar?.length,
                itemBuilder: (context, index) {
                  DanisanModel oAnkiUser = tumKullanicilar![index];
                  if (oAnkiUser.drTC == dbProviderDr.tcAl()) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DanisanDetay(
                            danisanModel: oAnkiUser,
                            druser: druser,
                          ),
                        ));
                      },
                      child: Card(
                        child: ListTile(
                          // ignore: prefer_interpolation_to_compose_strings
                          title: Text(
                            '${oAnkiUser.danAd} ${oAnkiUser.danSoyad}',
                          ),
                          subtitle: Text(oAnkiUser.danTC.toString()),
                          leading: CircleAvatar(
                            child: Image.asset(ResimYolu.instance.user),
                          ),
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
        ));
  }
}
