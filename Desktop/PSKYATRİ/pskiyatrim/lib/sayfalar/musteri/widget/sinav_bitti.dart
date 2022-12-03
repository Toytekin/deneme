import 'package:flutter/material.dart';
import 'package:pskiyatrim/db/model/danisan_model.dart';
import 'package:pskiyatrim/db/model/doktor_model.dart';
import 'package:pskiyatrim/sayfalar/musteri/musteri_home.dart';

// ignore: must_be_immutable
class SinavBitti extends StatelessWidget {
  DanisanModel danisanModel;
  DoktorModel doktorModel;
  SinavBitti(
      {super.key, required this.danisanModel, required this.doktorModel});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Testi Tamamlandı'),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MusteriHomeSayfasi(
                      danisanModel: danisanModel,
                    ),
                  ),
                  (route) => false);
            },
            child: const Text('Tamam'))
      ],
    ));
  }
}
