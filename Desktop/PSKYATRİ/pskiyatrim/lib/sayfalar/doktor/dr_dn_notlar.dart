import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/db_note.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_dn_note_detay.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_dn_note_ekle.dart';

import '../../db/model/note_model.dart';

// ignore: must_be_immutable
class DrDanisanNotlarSayfasi extends StatelessWidget {
  DanisanModel danisanModel;
  DanisanModel druser;
  DrDanisanNotlarSayfasi(
      {super.key, required this.danisanModel, required this.druser});

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DbNote>(context);
    return Scaffold(
      appBar: appbarAdmin(
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: danisanModel.danTC.toString(),
        press: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoktorHomeSayfasi(druser: druser),
          ));
        },
      ),
      body: FutureBuilder<List<NoteModel>>(
        future: db.notlariGetir(danisanModel),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NoteModel>? data = snapshot.data;
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DrDanNoteDetay(
                          noteModel: data[index],
                          druser: druser,
                          danisanModel: danisanModel),
                    ));
                  },
                  child: Card(
                      child: ListTile(
                    title: Text(data![index].noteBasligi),
                  )),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: floatinNoteEkle(context),
    );
  }

  FloatingActionButton floatinNoteEkle(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              DrDanNoteEklemeEkrani(danisanModel: danisanModel, druser: druser),
        ));
      },
      backgroundColor: SbtRenkler.instance.anaRenk,
      child: const Icon(Icons.add),
    );
  }
}
