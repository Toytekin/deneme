import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/db_note.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/note_model.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sayfalar/doktor/danisan_detay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class DrDanNoteEklemeEkrani extends StatefulWidget {
  DanisanModel danisanModel;
  DanisanModel druser;
  DrDanNoteEklemeEkrani(
      {super.key, required this.danisanModel, required this.druser});

  @override
  State<DrDanNoteEklemeEkrani> createState() => _DrDanNoteEklemeEkraniState();
}

class _DrDanNoteEklemeEkraniState extends State<DrDanNoteEklemeEkrani> {
  var baslikController = TextEditingController();

  var noteController = TextEditingController();

  //Tarih

  DateTime now = DateTime.now();

  //Opasity
  double _opasity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _opasity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DbNote>(context);

    initializeDateFormatting();

    DateTime now = DateTime.now();
    var formatter = DateFormat("dd-MM-yyyy'--'HH:mm'", 'tr');
    String nowFormatted = formatter.format(now);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbarim(context),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedOpacity(
            opacity: _opasity,
            duration: const Duration(seconds: 1),
            child: ListView(
              reverse: true,
              children: [
                const SizedBox(height: 15),
                Note(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Baslik(),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              baslikController.text = nowFormatted;
                            });
                          },
                          icon: const Icon(Icons.calendar_month)),
                    )
                  ],
                ),
                lotti(context),
                kaydetButonu(db, context)
              ],
            ),
          ),
        ),
      )),
    );
  }

  SizedBox lotti(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.height * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Lottie.asset('assets/noting.zip'));
  }

  Row kaydetButonu(DbNote db, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              if (baslikController.text.isNotEmpty &&
                  noteController.text.isNotEmpty) {
                String noteID = const Uuid().v1();

                NoteModel data = NoteModel(
                    noteID: noteID,
                    drTC: widget.druser.danTC.toString(),
                    danisanTC: widget.danisanModel.danTC.toString(),
                    noteBasligi: baslikController.text.toString(),
                    note: noteController.text.toString());

                db.DbNoteEkle(data, widget.danisanModel);
                noteController.clear();
                baslikController.clear();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => DanisanDetay(
                      danisanModel: widget.danisanModel, druser: widget.druser),
                ));
              } else {
                showTopSnackBar(
                  animationDuration: const Duration(milliseconds: 1200),
                  displayDuration: const Duration(milliseconds: 500),
                  context,
                  const CustomSnackBar.info(
                    message: " Başlık ve Notunuzu girmediniz",
                  ),
                );
              }
            },
            child: const Text('KAYDET'))
      ],
    );
  }

  // ignore: non_constant_identifier_names
  SabitTextField Baslik() {
    return SabitTextField(
        keybordTyp: TextInputType.multiline,
        controller: baslikController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Note Başlığını Giriniz',
        label: 'Başlık');
  }

  // ignore: non_constant_identifier_names
  SabitTextField Note() {
    return SabitTextField(
        keybordTyp: TextInputType.multiline,
        maxSize: 10,
        minSize: 6,
        controller: noteController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Notunuzu  Giriniz',
        label: 'Note');
  }

  appbarAdmin appbarim(BuildContext context) {
    return appbarAdmin(
      arkaplanRengi: Colors.deepOrange,
      appbarTitile: 'Note Ekleme Alanı',
      press: () {
        Navigator.of(context).pop();
      },
    );
  }
}
