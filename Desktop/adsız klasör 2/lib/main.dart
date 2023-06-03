import 'package:flutter/material.dart';
import 'package:haritaapp/a_sayfalar/giris_ekrani.dart';
import 'package:haritaapp/model/konum_model.dart';
import 'package:haritaapp/model/user.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  //Veri Tabanı
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(KonumModelAdapter());

  await Hive.openBox<User>('kisiDB');

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      title: 'Material App',
      home: const GirisEkrani(),
    );
  }
}


//KEY== Google map hizmetleri için kullanılan key
// AIzaSyDDYbhUBtp6W7RpaWnn_Lelx3UNq__1tDs

// AIzaSyDDYbhUBtp6W7RpaWnn_Lelx3UNq__1tDs
// AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU


//veritabanı işlemini sor unutma