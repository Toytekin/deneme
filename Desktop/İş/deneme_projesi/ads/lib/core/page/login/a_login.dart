import 'package:ads/core/constant/color.dart';
import 'package:ads/core/constant/text_field.dart';
import 'package:ads/core/page/login/b_save.dart';
import 'package:ads/core/page/splash/splash.dart';
import 'package:ads/core/page/student/giris_ogrenci.dart';
import 'package:ads/core/page/akademisyen/d_g_akd.dart';
import 'package:ads/core/services/save_user.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mailController = TextEditingController();
  var sifreController = TextEditingController();

  var frAuth = FrSaveUser();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 46, 27, 154), // İlk renk
            Color.fromARGB(255, 222, 205, 161), // İkinci renk
          ],
        ),
      ),
      child: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Logo
              SizedBox(
                width: size.height * 0.4,
                height: size.height * 0.4,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ARS',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.09),
                      ),
                      const Text(
                        '(Akademisyen Randevu Sistemi)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              SbtTextField(
                controller: mailController,
                label: 'Mail',
                icon: const Icon(Icons.mail),
              ),
              SbtTextField(
                controller: sifreController,
                label: 'Şifre',
                sifrelimi: true,
                icon: const Icon(Icons.password),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserSaveScreen()),
                        );
                      },
                      child: Text(
                        'Kaydol',
                        style: TextStyle(color: SbtColors.yaziRenk),
                      ))
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (mailController.text.isNotEmpty &&
                        sifreController.text.isNotEmpty) {
                      var data = await frAuth.getUserByEmail(
                          mailController.text, sifreController.text);

                      //User varmı yok mu
                      if (data != null) {
                        //Öğrencimi Akademisyenmi
                        if (data.ogrenciMi == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(
                                  sayfa: OgrenciGiris(userModel: data)),
                            ),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(
                                  sayfa: AkademisyenScreen(userModel: data)),
                            ),
                          );
                        }
                      } else {
                        showTopSnackBar(
                          // ignore: use_build_context_synchronously
                          Overlay.of(context),
                          const CustomSnackBar.info(
                            message: "Kullanıcı bulunamadı",
                          ),
                        );
                      }
                    } else {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.info(
                          message:
                              "Tüm alanları doldurduğunuza emin olduktan sonra tekrar deneyin.",
                        ),
                      );
                    }
                  },
                  child: const Text('Giriş'))
            ],
          ),
        ),
      )),
    ));
  }
}
