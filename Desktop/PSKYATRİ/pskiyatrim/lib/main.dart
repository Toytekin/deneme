import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pskiyatrim/db/firebase/db_firebase.dart';
import 'package:pskiyatrim/db/firebase/db_note.dart';
import 'package:pskiyatrim/db/firebase/veritabani.dart';
import 'package:pskiyatrim/db/locator.dart';
import 'package:pskiyatrim/db/firebase/firebase_options.dart';
import 'package:pskiyatrim/db/model/doktor_tc.dart';
import 'package:pskiyatrim/giri_mail.dart';
import 'package:pskiyatrim/provider/kategori_adi_gonder.dart';
import 'package:pskiyatrim/provider/siklarin_tiklanmasi.dart';
import 'package:pskiyatrim/provider/soru_sayisi.dart';
import 'package:pskiyatrim/provider/test_gonder_provider.dart';
import 'package:pskiyatrim/sabitler/color.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<KategoriAdiGonder>(
            create: (_) => KategoriAdiGonder()),
        ChangeNotifierProvider<SiklarinTiklanmasiProvider>(
            create: (_) => SiklarinTiklanmasiProvider()),
        ChangeNotifierProvider<TestGonderProvider>(
            create: (_) => TestGonderProvider()),
        ChangeNotifierProvider<SoruSayisiProvider>(
            create: (_) => SoruSayisiProvider()),
        Provider<DbFirebase>(create: (_) => DbFirebase()),
        Provider<VeriTabani>(create: (_) => VeriTabani()),
        Provider<DbNote>(create: (_) => DbNote()),
        Provider<DrTc>(create: (_) => DrTc()),
      ],
      child: MaterialApp(
          theme: ThemeData(
              scaffoldBackgroundColor: SbtRenkler.instance.arkaplanBeyaz,
              cardColor: SbtRenkler.instance.anaRenk,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shadowColor: Colors.black,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  backgroundColor: SbtRenkler.instance.anaRenk,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: SbtRenkler.instance.turuncu,
                elevation: 0,
              )),
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: const GiriMail()),
    );
  }
}
