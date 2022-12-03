import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';

// ignore: must_be_immutable
class TestlerimSayfasi extends StatelessWidget {
  DanisanModel druser;
  TestlerimSayfasi({super.key, required this.druser});

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<VeriTabani>(context, listen: false);
    return Scaffold(
        appBar: appbarAdmin(
          arkaplanRengi: druser.danTC.toString() == '15499302306'
              ? Colors.black
              : Colors.deepOrange,
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
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        // ignore: prefer_interpolation_to_compose_strings
                        title: Text(
                          '${oAnkiUser.danAd} ${oAnkiUser.danSoyad}',
                        ),
                        subtitle: Text(oAnkiUser.danTC.toString()),
                        leading: const CircleAvatar(),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
