import 'package:biz_sizi_arariz/provider/puan.dart';
import 'package:biz_sizi_arariz/sayfalar/basla.dart';
import 'package:biz_sizi_arariz/theme/temalar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('temasec');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PuanArttirProvider>(
        create: (_) => PuanArttirProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List temalar = [
    beyazTema,
    kirmiziTema,
    kahverengiTema,
    sariTema,
    maviTema,
  ];

  var boxTema = Hive.box('temasec');

  int? seciliTema;

  @override
  void initState() {
    super.initState();

    for (var element in boxTema.values) {
      if (element != null) {
        seciliTema = element;
      } else {
        seciliTema = 3;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: seciliTema != null ? temalar[seciliTema!] : temalar[0],
      debugShowCheckedModeBanner: false,
      title: 'Material App',


      home: const BaslaSayfasi(),
    );
  }
}
