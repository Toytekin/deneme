import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/db_note.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/note_model.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/danisan_detay.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_dn_note_duzenle.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class DrDanNoteDetay extends StatelessWidget {
  NoteModel noteModel;
  DanisanModel druser;
  DanisanModel danisanModel;
  DrDanNoteDetay(
      {super.key,
      required this.noteModel,
      required this.druser,
      required this.danisanModel});

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DbNote>(context);
    return Scaffold(
      appBar: appbarAdmin(
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: noteModel.noteBasligi,
        press: () {
          Navigator.of(context).pop();
        },
        appbarWidget: IconButton(
            onPressed: () {
              Silme(context, db);
            },
            icon: const Icon(Icons.delete)),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                color: const Color.fromARGB(62, 244, 180, 3),
                child: ListTile(
                  trailing: NoteDuzenleme(context),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(noteModel.noteBasligi),
                  ),
                  subtitle: Text(noteModel.note),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  // ignore: non_constant_identifier_names
  IconButton NoteDuzenleme(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DrDanNoteDuzenlemeSayfasi(
              noteModel: noteModel,
              danisanModel: danisanModel,
              drModel: druser),
        ));
      },
      icon: const Icon(Icons.create),
      color: Colors.deepOrange,
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> Silme(BuildContext context, DbNote db) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(noteModel.noteBasligi),
        content: const Text('Silinme işlemini onaylıyor musun ?'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            onPressed: () {
//? *********************<< S İ L M E >>***************************************
              db.noteSil(danisanModel, noteModel);

              showTopSnackBar(
                animationDuration: const Duration(milliseconds: 1200),
                displayDuration: const Duration(milliseconds: 500),
                context,
                const CustomSnackBar.success(
                  message: "Note Silindi",
                ),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => DanisanDetay(
                          danisanModel: danisanModel,
                          druser: druser,
                        )),
              );
            },
            child: const Text(' SİL   '),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('VAZGEÇ'),
          )
        ],
      ),
    );
  }
}
