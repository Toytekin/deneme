import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/sayfalar/doktor/profil_yazi.dart';

// ignore: must_be_immutable
class ProfilDenemeSayfasi extends StatefulWidget {
  DoktorModel druser;
  DanisanModel danisanModelDr;

  ProfilDenemeSayfasi(
      {super.key, required this.druser, required this.danisanModelDr});

  @override
  State<ProfilDenemeSayfasi> createState() => _ProfilDenemeSayfasiState();
}

class _ProfilDenemeSayfasiState extends State<ProfilDenemeSayfasi> {
  //! DEĞİŞKENLER
  // ignore: unused_local_variable
  String resimurl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
  String? gelenResim;

  final ImagePicker picker = ImagePicker();

  // ignore: unused_element
  galeridenYukle() async {
    resmiUrlyeAl(Reference ref) async {
      try {
        setState(() {});
        gelenResim = (await ref.getDownloadURL()).toString();
      } catch (e) {
        Navigator.of(context).pop();
      }
    }

    // ignore: unused_local_variable
    XFile? alinanDosya = await picker.pickImage(source: ImageSource.gallery);

    if (alinanDosya != null) {
      setState(() {
        File yuklenecekDosya = File(alinanDosya.path);
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(widget.druser.danTC.toString())
            .child('/some-image.jpg');

        // ignore: unused_local_variable
        UploadTask yuklemeGorevi = ref.putFile(yuklenecekDosya);
        resmiUrlyeAl(ref);
      });
    }

    //else buraya yazabilirsin
  }

  veriCek() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(widget.druser.danTC.toString())
        .child('/some-image.jpg');
    try {
      gelenResim = (await ref.getDownloadURL()).toString();
      setState(() {});
    } catch (e) {
      gelenResim = resimurl;
    }
  }

  @override
  void initState() {
    super.initState();
    veriCek();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<VeriTabani>(context);
    return FutureBuilder(
      future: db.doktorSiviGetir(widget.druser.danTC.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Material(
              child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            profilResmi(),
                            Positioned(
                              left: 11,
                              top: 50,
                              child: tiklama(),
                            ),
                          ],
                        ),
                      ),
                      doktorSiviYazisi(context, snapshot),
                      const SizedBox(height: 40),
                      // RANDEVU DEFTERİ
                      alttakiButonlar(context),
                      const SizedBox(height: 8)
                    ],
                  ),
                ),
              ),
            ),
          ));
        } else {
          return Container();
        }
      },
    );
  }

  Padding alttakiButonlar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          randevuDefteri(),
          bosluk(),
          duzenleButonu(context),
        ],
      ),
    );
  }

  Column duzenleButonu(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => ProfilYazi(
                          danisanModel: widget.danisanModelDr,
                        )),
              );
            },
            child: const Text('Düzenle'))
      ],
    );
  }

  SizedBox bosluk() {
    return const SizedBox(
      height: 50,
      child: VerticalDivider(
        color: Color(0xFF9A9A9A),
      ),
    );
  }

  Column randevuDefteri() {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Randevu Defteri'))
      ],
    );
  }

  Padding doktorSiviYazisi(
      BuildContext context, AsyncSnapshot<DoktorModel> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.6,
        child: ListView(
          shrinkWrap: true,
          children: [
            //! Dokotor SİVİ
            Text(
              snapshot.data!.yazi.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Row tiklama() {
    return Row(
      children: [
        //? ********************************<<RESİM ALANI>>******************************************
        InkWell(
          onTap: () {
            galeridenYukle();
            // ignore: use_build_context_synchronously

            setState(() {});
          },
          child: resimCekmeProfil(),
        ),
        const SizedBox(width: 20),
        AdSoyad()
      ],
    );
  }

  CircleAvatar resimCekmeProfil() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: gelenResim == null
          ? NetworkImage(resimurl)
          : NetworkImage(gelenResim!),
    );
  }

  ClipPath profilResmi() {
    return ClipPath(
      clipper: AvatarClipper(),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column AdSoyad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr.${widget.danisanModelDr.danAd} ${widget.danisanModelDr.danSoyad}',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 28),
        const SizedBox(height: 8)
      ],
    );
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
