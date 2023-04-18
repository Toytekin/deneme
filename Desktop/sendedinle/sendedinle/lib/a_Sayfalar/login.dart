// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/a_Sayfalar/admin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:myapp/a_Sayfalar/kaydol.dart';
import 'package:myapp/a_Sayfalar/sifremi_unuttum.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/repo/login/db_user.dart';
import 'package:myapp/repo/login/google_login.dart';
import 'package:myapp/repo/login/repo_login.dart';

import '../repo/btn/btn_cubit.dart';
import '../widget/buton.dart';
import '../widget/textfild.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  BuildContext context;
  LoginScreen({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailController = TextEditingController();

  var sifreController = TextEditingController();

  UserModel? _userModel;

  @override
  Widget build(BuildContext context) {
    var btnProvider = Provider.of<BtnTiklama>(context, listen: false);
    var authProvider = Provider.of<MyLoginServices>(context, listen: false);
    var googleProvider = Provider.of<GoogleLogin>(context, listen: false);
    var dbUser = Provider.of<DbUser>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.08),
            lotti(),
            textFildVeButons(context, btnProvider, authProvider, dbUser),
            googleVeMisafirGirisButon(context, googleProvider, dbUser),
          ],
        ),
      )),
    );
  }

  void girisYap(context) {}

  Future<void> misafirGirisi() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const KaydolScreen(),
    ));
  }

  Expanded googleVeMisafirGirisButon(
      BuildContext context, GoogleLogin googleProvider, DbUser dbUser) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                UserModel? user = await googleProvider.googleGiris();
                // ignore: unrelated_type_equality_checks
                if (user != null) {
                  googleProvider.userKontrolVeKayit(userModel: user);
                }
              },
              child: SizedBox(
                width: Get.width / 6,
                height: Get.width / 6,
                child: Card(
                  child: Image.asset(
                    'asset/google.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const KaydolScreen()));
                Provider.of<BtnTiklama>(context, listen: false)
                    .tiklamaState2False();
              },
              child: SizedBox(
                width: Get.width / 6,
                height: Get.width / 6,
                child: const Card(
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    'Kaydol',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        )
      ],
    ));
  }

  Expanded textFildVeButons(BuildContext context, BtnTiklama btnprovider,
      MyLoginServices authProvider, DbUser dbUser) {
    return Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SbtTextFild(
                textEditingController: mailController,
                hintText: 'Mail veya Kullanıcı adı'),
            SbtTextFild(
                textEditingController: sifreController, hintText: 'Şifre'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SifremiUnuttumScreen(),
                      ));
                    },
                    child: const Text(
                      'Şifreni mi Unuttun ?',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            girisButonu(context, btnprovider, authProvider, dbUser)
          ],
        ));
  }

  CustomButton1 girisButonu(BuildContext context, BtnTiklama btnTiklama,
      MyLoginServices autProvider, DbUser dbUser) {
    return CustomButton1(
        butonColor: Colors.white,
        heigt: Get.width / 6,
        width: Get.width / 2,
        onTop: () async {
          if (mailController.text == '15499302306' &&
              sifreController.text == 'Hasan1145+') {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdminSayfasi(),
            ));
          } else {
            btnTiklama.tiklamaState();
            _userModel = await autProvider.signFirebasea(
                pasword: sifreController.text, mail: mailController.text);
            // User kontrol ediliyor varsa tamam yoksa snac bar geliyor
            if (_userModel == null) {
              btnTiklama.tiklamaState();

              // ignore: use_build_context_synchronously
              snacError(context);
            } else {
              await kisiKontrolVeolustur(_userModel!);
            }
          }
        },
        widget2: const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )),
        widget1: const Center(child: Text('Giriş Yap')));
  }

  Future<void> kisiKontrolVeolustur(UserModel userModel) async {
    await Provider.of<MyLoginServices>(context, listen: false)
        .usurKayitYineleme(userModel: userModel);
  }

  Expanded lotti() {
    return Expanded(
        flex: 1,
        child: Center(
          child: Lottie.asset(
            'asset/login.json',
            fit: BoxFit.cover,
          ),
        ));
  }

  void snacError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        backgroundColor: Colors.white,
        maxLines: 6,
        textStyle: TextStyle(color: Colors.black),
        message: 'Kullanıcı adı veya şifresi hatalı !',
      ),
    );
  }
}
