import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/giri_mail.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/admin_cart.dart';
import 'package:pskiyatrim/sayfalar/admin/widget/appbar.dart';
import 'package:pskiyatrim/sabitler/resimyolu.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_danisan_ekle.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_danisanlarim.dart';
import 'package:pskiyatrim/sayfalar/doktor/dr_kategori_ekle.dart';
import 'package:pskiyatrim/sayfalar/doktor/profile_deneme.dart';
import 'package:pskiyatrim/sayfalar/doktor/sifre.dart';
import 'package:pskiyatrim/sayfalar/doktor/testlerim.dart';

// ignore: must_be_immutable
class DoktorHomeSayfasi extends StatefulWidget {
  DanisanModel druser;
  DoktorHomeSayfasi({super.key, required this.druser});

  @override
  State<DoktorHomeSayfasi> createState() => _DoktorHomeSayfasiState();
}

class _DoktorHomeSayfasiState extends State<DoktorHomeSayfasi> {
  @override
  Widget build(BuildContext context) {
    var db = Provider.of<VeriTabani>(context);

    return Scaffold(
      appBar: appbarAdmin(
        appbarWidget: sifreDegistirme(context),
        arkaplanRengi: Colors.deepOrange,
        appbarTitile: '${widget.druser.danAd}  ${widget.druser.danSoyad}',
        press: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const GiriMail(),
              ),
              (route) => false);
        },
      ),
      body: Center(
        child: ListView(
          children: [
            //! TEST EKLE
            AdminCart(
                leadingIcon: Image.asset(
                  ResimYolu.instance.testekle,
                  width: 80,
                  height: 80,
                ),
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrKategoriEkle(drUser: widget.druser),
                  ));
                },
                arkaRenk: Colors.grey,
                text: 'Test Ekle'),
            //! DANIŞANLARIM
            AdminCart(
                leadingIcon: Image.asset(
                  ResimYolu.instance.danisanlar,
                  width: 80,
                  height: 80,
                ),
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrDanisalarSayfasi(
                      druser: widget.druser,
                    ),
                  ));
                },
                arkaRenk: Colors.green,
                text: 'DANIŞANLARIM'),

            //! PROFİL
            AdminCart(
                leadingIcon: Image.asset(
                  ResimYolu.instance.user,
                  width: 80,
                  height: 80,
                ),
                press: () async {
                  DoktorModel doktorSivi =
                      await db.doktorSiviGetir(widget.druser.danTC.toString());

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilDenemeSayfasi(
                        druser: doktorSivi, danisanModelDr: widget.druser),
                  ));
                },
                arkaRenk: Colors.amber,
                text: 'PROFİL'),

            //! TESTLERİM
            AdminCart(
                leadingIcon: Image.asset(
                  ResimYolu.instance.quiz,
                  width: 80,
                  height: 80,
                ),
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrTestlerimSayfasi(
                      drUser: widget.druser,
                    ),
                  ));
                },
                arkaRenk: const Color.fromARGB(162, 0, 118, 245),
                text: 'TESTLERİM'),
            //! DANIŞAN EKLE
            AdminCart(
                leadingIcon: Image.asset(
                  ResimYolu.instance.danisanekle,
                  width: 80,
                  height: 80,
                ),
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrDanisanEkle(
                      drUser: widget.druser,
                    ),
                  ));
                },
                arkaRenk: Colors.red,
                text: 'Danışan Ekle'),
          ],
        ),
      ),
    );
  }

  IconButton sifreDegistirme(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SifreDegistir(user: widget.druser),
          ));
        },
        icon: const Icon(Icons.password_sharp));
  }
}
