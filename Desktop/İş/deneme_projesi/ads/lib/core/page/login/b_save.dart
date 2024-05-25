import 'package:ads/core/constant/color.dart';
import 'package:ads/core/constant/text_field.dart';
import 'package:ads/core/models/usermodel.dart';
import 'package:ads/core/page/login/a_login.dart';
import 'package:ads/core/page/splash/splash.dart';
import 'package:ads/core/services/login.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UserSaveScreen extends StatefulWidget {
  const UserSaveScreen({super.key});

  @override
  State<UserSaveScreen> createState() => _UserSaveScreenState();
}

class _UserSaveScreenState extends State<UserSaveScreen> {
  var adController = TextEditingController();
  var mailController = TextEditingController();
  var sifreController = TextEditingController();
  var tekrarSifreController = TextEditingController();

  bool ogrenciMi = true;

  var frLogin = FrLogin();

  // Seçenek listesi
  final List<String> _options = [
    'Yönetim Bilişim Sistemleri',
    'Bilgisayar Programcılığı',
    'Grafik Tasarım',
    'Yazılım Mühendisliği',
    'Uluslararası İlişkiler',
    'İç Mimarlık',
  ];

  // Seçilen değeri tutan değişken
  String? _selectedOption;

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: SbtColors.yaziRenk,
                        )),
                  ],
                ),
                SizedBox(
                  width: size.height * 0.33,
                  height: size.height * 0.33,
                  child: Icon(
                    Icons.recent_actors_outlined,
                    size: size.height * 0.18,
                    color: Colors.white,
                  ),
                ),
                SbtTextField(
                    controller: adController,
                    label: 'Ad Soyad',
                    icon: const Icon(Icons.person)),
                SbtTextField(
                  controller: mailController,
                  label: 'Mail',
                  icon: const Icon(Icons.mail),
                ),
                SbtTextField(
                    controller: sifreController,
                    label: 'Şifre',
                    sifrelimi: true,
                    icon: const Icon(Icons.password)),
                SbtTextField(
                    controller: tekrarSifreController,
                    label: 'Tekrar Şifre',
                    sifrelimi: true,
                    icon: const Icon(Icons.password)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      hint: const Text(
                        'Bölüm Seçin',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: _selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      },
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (adController.text.isNotEmpty &&
                          mailController.text.isNotEmpty &&
                          sifreController.text.isNotEmpty &&
                          tekrarSifreController.text.isNotEmpty &&
                          _selectedOption!.isNotEmpty) {
                        if (sifreController.text ==
                                tekrarSifreController.text &&
                            sifreController.text.length > 6) {
                          var userModel = UserModel(
                            userName: adController.text,
                            userID: '',
                            userMail: mailController.text,
                            userSifre: sifreController.text,
                            ogrnciBolum: _selectedOption.toString(),
                            ogrenciMi: true,
                          );
                          await frLogin.kaydet(userModel);
                          adController.clear();
                          mailController.clear();
                          sifreController.clear();
                          tekrarSifreController.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SplashScreen(sayfa: LoginScreen())),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  "Lütfen şifrenizi 7 karakter ve iki alanada aynı şifre olacak şekilde güncelleyin ",
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
                    child: const Text('Kaydol'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
