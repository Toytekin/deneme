import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/repo/login/repo_login.dart';
import 'package:myapp/widget/buton1.dart';
import 'package:myapp/widget/textfild.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../repo/btn/btn_cubit.dart';
import '../repo/login/db_user.dart';

// ignore: must_be_immutable
class KaydolScreen extends StatefulWidget {
  const KaydolScreen({super.key});

  @override
  State<KaydolScreen> createState() => _KaydolScreenState();
}

class _KaydolScreenState extends State<KaydolScreen> {
  var mailController = TextEditingController();

  var sifreController = TextEditingController();

  var sifreTekrariController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel? _errorMessage;

  @override
  Widget build(BuildContext context) {
    var dbUser = Provider.of<DbUser>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_BEELk7wPJW.json'),
            ),
            SbtTextFild2(
                sifremi: false,
                textEditingController: mailController,
                hintText: ' Mail '),
            SbtTextFild2(
                sifremi: true,
                textEditingController: sifreController,
                hintText: 'Şifre '),
            SbtTextFild2(
                sifremi: true,
                textEditingController: sifreTekrariController,
                hintText: 'Şifre Tekrarı'),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: CustomButton2(
                  heigt: Get.width / 6,
                  width: Get.width / 4,
                  onTop: () {
                    butonKaydolTiklama(dbUser);
                  },
                  widget1: const Center(
                      child: Text(
                    'Kaydol',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  )),
                  widget2: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  butonKaydolTiklama(DbUser dbUser) async {
    Provider.of<BtnTiklama>(context, listen: false).tiklamaState2();
    // ? TEXTFİLD KONTROLÜ
    if (sifreController.text == sifreTekrariController.text &&
        sifreController.text.isNotEmpty &&
        mailController.text.isNotEmpty) {
      //! FİREBASE  KONTROLÜ => O L U Ş  T U R M A
      await kisiKontrolVeolustur(dbUser);
      // KİŞİ OLUŞTURULUSA YANİ VERİ TABANINDA YOKSA
      // ERROR MESAJI null GELECEK.
      // VE NULL GELİRSE BAŞARILI GİRİŞ SNACBARI GELECCEK
      if (_errorMessage == null) {
        // ignore: use_build_context_synchronously
        //snacBarError(context);
      } else {
        // ignore: use_build_context_synchronously
        // Provider.of<BtnTiklama>(context, listen: false).tiklamaState2();
      }
    } else {
      snacBar(context);
      Provider.of<BtnTiklama>(context, listen: false).tiklamaState2();
    }
    //setState(() {});
  }

  Future<void> kisiKontrolVeolustur(DbUser dbUser) async {
    UserModel? errorMessage =
        await Provider.of<MyLoginServices>(context, listen: false)
            .userKontrolVeKayit(
                pasword: sifreController.text, mail: mailController.text);

    _errorMessage = errorMessage;
  }

  void snacBar(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        backgroundColor: Colors.white,
        maxLines: 6,
        textStyle: TextStyle(color: Colors.black),
        message:
            'Tüm alanları doldurduğuna ve şifreni en az 6 karakter girdiğine emin olduktaan sonra tekrar dene',
      ),
    );
  }

  void snacBarError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        backgroundColor: Colors.white,
        maxLines: 6,
        textStyle: TextStyle(color: Colors.black),
        message:
            'Bu mail zaten kullanılmış durumda. Lütfen  başka bir mail ile tekrar deneyin.',
      ),
    );
  }

  void snacBarSucces(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        backgroundColor: Colors.green,
        maxLines: 6,
        textStyle: TextStyle(color: Colors.black),
        message: 'Başarılı',
      ),
    );
  }
}
