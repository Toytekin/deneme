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

// ignore: must_be_immutable
class DrDanNoteDuzenlemeSayfasi extends StatefulWidget {
  NoteModel noteModel;
  DanisanModel danisanModel;
  DanisanModel drModel;

  DrDanNoteDuzenlemeSayfasi(
      {super.key,
      required this.noteModel,
      required this.danisanModel,
      required this.drModel});

  @override
  State<DrDanNoteDuzenlemeSayfasi> createState() =>
      _DrDanNoteDuzenlemeSayfasiState();
}

class _DrDanNoteDuzenlemeSayfasiState extends State<DrDanNoteDuzenlemeSayfasi> {
  var baslikController = TextEditingController();

  var noteController = TextEditingController();

  final String _lottieURL =
      'https://assets3.lottiefiles.com/packages/lf20_nk7rih3w.json';

  @override
  void initState() {
    super.initState();
    baslikController.text = widget.noteModel.noteBasligi;
    noteController.text = widget.noteModel.note;
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
          child: ListView(
            reverse: true,
            children: [
              const SizedBox(height: 15),
              Note(),
              const SizedBox(height: 15),
              baslikRow(nowFormatted),
              lottie(context),
              kaydetButtonu(db, context)
            ],
          ),
        ),
      )),
    );
  }

  Row kaydetButtonu(DbNote db, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              if (baslikController.text.isNotEmpty &&
                  noteController.text.isNotEmpty) {
                String noteID = widget.noteModel.noteID;

                NoteModel data = NoteModel(
                    noteID: noteID,
                    drTC: widget.noteModel.drTC,
                    danisanTC: widget.noteModel.danisanTC,
                    noteBasligi: baslikController.text.toString(),
                    note: noteController.text.toString());

                db.DbNoteEkle(data, widget.danisanModel);
                noteController.clear();
                baslikController.clear();
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DanisanDetay(
                      danisanModel: widget.danisanModel,
                      druser: widget.drModel),
                ));
              } else {
                snakbar(context);
              }
            },
            child: const Text('KAYDET'))
      ],
    );
  }

  void snakbar(BuildContext context) {
    return showTopSnackBar(
      animationDuration: const Duration(milliseconds: 1200),
      displayDuration: const Duration(milliseconds: 500),
      context,
      const CustomSnackBar.info(
        message: " Başlık ve Notunuzu girmediniz",
      ),
    );
  }

  SizedBox lottie(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.height * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Lottie.network(
          _lottieURL,
        ));
  }

  Row baslikRow(String nowFormatted) {
    return Row(
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
    );
  }

  // ignore: non_constant_identifier_names
  SabitTextField Baslik() {
    return SabitTextField(
        controller: baslikController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Note Başlığını Giriniz',
        label: 'Başlık');
  }

  // ignore: non_constant_identifier_names
  SabitTextField Note() {
    return SabitTextField(
        minSize: 5,
        maxSize: 10,
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
