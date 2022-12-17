import 'package:biz_sizi_arariz/theme/temalar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TemaDegistirmeSayfasi extends StatefulWidget {
  const TemaDegistirmeSayfasi({super.key});

  static const menuItems = <String>[
    'Beyaz',
    'Kırmızı',
    'Sarı',
    'Kahverengi',
    'Mavi'
  ];

  @override
  State<TemaDegistirmeSayfasi> createState() => _TemaDegistirmeSayfasiState();
}

class _TemaDegistirmeSayfasiState extends State<TemaDegistirmeSayfasi> {
  var boxTema = Hive.box('temasec');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).textTheme.headline1?.color,
              ))
        ],
        title: Text(
          'Tema Değiştir',
          style: TextStyle(color: Theme.of(context).textTheme.headline1?.color),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: decorasyon(),
              hint: hintText(),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: chanceIslemi,
            ),
          ),
        ],
      )),
    );
  }

  void chanceIslemi(_) async {
    if (_ == 'Beyaz') {
      await boxTema.put('tema', 0);
      Get.changeTheme(beyazTema);
    } else if (_ == 'Kırmızı') {
      await boxTema.put('tema', 1);
      Get.changeTheme(kirmiziTema);
    } else if (_ == 'Kahverengi') {
      await boxTema.put('tema', 2);
      Get.changeTheme(kahverengiTema);
    } else if (_ == 'Sarı') {
      await boxTema.put('tema', 3);
      Get.changeTheme(sariTema);
    } else if (_ == 'Mavi') {
      await boxTema.put('tema', 4);
      Get.changeTheme(maviTema);
    }
  }

  List<String> get items {
    return <String>[
      'Beyaz',
      'Kırmızı',
      'Sarı',
      'Kahverengi',
      'Mavi',
    ];
  }

  Text hintText() {
    return const Text('Tema', style: TextStyle(fontSize: 22));
  }

  InputDecoration decorasyon() {
    return const InputDecoration(
      prefixIcon: Icon(Icons.palette, size: 30),
    );
  }

  Text temadegistir(BuildContext context) {
    return Text(
      ' Tema Seç',
      style: stil(context),
    );
  }

  TextStyle stil(BuildContext context) {
    return TextStyle(
        fontSize: 22, color: Theme.of(context).textTheme.headline1?.color);
  }
}
