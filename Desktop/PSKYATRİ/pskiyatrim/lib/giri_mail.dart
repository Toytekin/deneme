import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_tc.dart';
import 'package:pskiyatrim/sabitler/text.dart';
import 'package:pskiyatrim/sayfalar/admin/admin_home.dart';
import 'package:pskiyatrim/sabitler/color.dart';
import 'package:pskiyatrim/sabitler/text_field.dart';
import 'package:pskiyatrim/sayfalar/doktor/doctor_home.dart';
import 'package:pskiyatrim/sayfalar/musteri/musteri_home.dart';

// ignore: must_be_immutable
class GiriMail extends StatefulWidget {
  const GiriMail({super.key});

  @override
  State<GiriMail> createState() => _GiriMailState();
}

class _GiriMailState extends State<GiriMail> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Controller
  TextEditingController mailController = TextEditingController();

  TextEditingController sifreController = TextEditingController();

  // Opocity
  double _opcity = 0;

  // Gİriş kontrolü

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _opcity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var dbProvider = Provider.of<DrTc>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opcity,
            duration: const Duration(seconds: 1),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  lottie(context),
                  Mail(),
                  const SizedBox(height: 20),
                  Sifre(),
                  const SizedBox(height: 20),
                  girisButton(context, dbProvider),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  SizedBox lottie(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        child: Lottie.asset('assets/lotti.zip'));
  }

  ElevatedButton girisButton(BuildContext context, DrTc dbProvider) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 144, 164, 249),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.6,
            (MediaQuery.of(context).size.width * 0.8) / 6,
          ),
        ),
        onPressed: () async {
          // ADMİM  KONTROLÜ

          var admin = db.collection('admin').doc('admin').snapshots();
          admin.listen((event) {
            Map<String, dynamic>? datam = event.data();
            var user = DanisanModel.frommap(datam!);

            if (datam['mail'] == mailController.text.toString() &&
                datam['sifre'] == sifreController.text.toString()) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AdminHomePage(
                  user: user,
                ),
              ));
            } else {}
          });
          // DOKTOR  KONTROLÜ

          var dr = db.collection('psikolog').snapshots();
          dr.listen((event) {
            var drQury = event.docs;
            for (var element in drQury) {
              var drrr = element.data();
              var user = DanisanModel.frommap(drrr);
              if (drrr['mail'] == mailController.text.toString() &&
                  drrr['sifre'] == sifreController.text.toString()) {
                dbProvider.tcVer(user.danTC.toString());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DoktorHomeSayfasi(druser: user),
                ));
              }
            }
          });

          // DAIŞAN  KONTROLÜ

          var musteri = db.collection('users').snapshots();
          musteri.listen((event) {
            var drQury = event.docs;
            for (var element in drQury) {
              var drrr = element.data();
              var user = DanisanModel.frommap(drrr);
              if (drrr['mail'] == mailController.text.toString() &&
                  drrr['sifre'] == sifreController.text.toString()) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MusteriHomeSayfasi(danisanModel: user),
                ));
              }
            }
          });
        },
        child: Text(
          'Giriş',
          style: SaaText.sbtStilBeyaz,
        ));
  }

  // ignore: non_constant_identifier_names
  TextField Sifre() {
    return TextField(
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      controller: sifreController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: SbtRenkler.instance.anaRenk),
          ),
          label: const Text(
            'Sifre',
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 10, color: SbtRenkler.instance.anaRenk),
          ),
          hintText: 'Şifrenizi girin'),
    );
  }

  // ignore: non_constant_identifier_names
  SabitTextField Mail() {
    return SabitTextField(
        keybordTyp: TextInputType.emailAddress,
        controller: mailController,
        bordercolor: SbtRenkler.instance.anaRenk,
        hinText: 'Mailinizi Girin',
        label: 'Mail');
  }
}
