import 'package:flutter/material.dart';
import 'package:flutter_application_1/enum_yapisi/enum_ile_image_path.dart';
import 'package:flutter_application_1/enum_yapisi/extension_sinif.dart';
import 'package:flutter_application_1/enum_yapisi/sinif.dart';

class EnumScreen extends StatefulWidget {
  const EnumScreen({super.key});

  @override
  State<EnumScreen> createState() => _EnumScreenState();
}

class _EnumScreenState extends State<EnumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enum Yapısı'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: renkleriGetir(Renkler.LACIVERT), //! enum kullanimi
          ),
          Text('beş'.kareAl) //! extensin kullanbimi,

          ,
          Text(litreyeGoreFiyatlandir(Litrelendirme.uc)),
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(Resimler.herry.path()),
          )
        ],
      )),
    );
  }
}
