import 'package:biz_sizi_arariz/sabitler/yazi.dart';
import 'package:biz_sizi_arariz/sayfalar/meslekler.dart';
import 'package:biz_sizi_arariz/sayfalar/tema_degistir.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BaslaSayfasi extends StatefulWidget {
  const BaslaSayfasi({super.key});

  @override
  State<BaslaSayfasi> createState() => _BaslaSayfasiState();
}

class _BaslaSayfasiState extends State<BaslaSayfasi> {
  final String _lottie = 'asset/json/lottiek.json';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Biz Sizi Ararız ',
          style: TextStyle(color: Theme.of(context).textTheme.headline1?.color),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TemaDegistirmeSayfasi(),
                ));
              },
              icon: const Icon(Icons.settings, color: Colors.black))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(_lottie),
            ),
            const SizedBox(
              height: 100,
            ),
            SafeArea(
              child: ElevatedButton(
                //! TR-ENG
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
                child: NormalYazi(
                  yazi: 'BAŞLA',
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MesleklerSayfasi(),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
