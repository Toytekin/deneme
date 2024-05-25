import 'package:ads/core/constant/color.dart';
import 'package:ads/core/page/login/a_login.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: SbtColors.anaRenk,
            titleTextStyle: TextStyle(color: SbtColors.yaziRenk)),
        scaffoldBackgroundColor: SbtColors.anaRenk,
      ),
      title: 'Material App',
      home: const LoginScreen(),
    );
  }
}
