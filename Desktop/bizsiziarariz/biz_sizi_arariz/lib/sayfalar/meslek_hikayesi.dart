import 'package:biz_sizi_arariz/sabitler/renkler.dart';
import 'package:biz_sizi_arariz/sabitler/yazi.dart';
import 'package:biz_sizi_arariz/sayfalar/aday/aday_home.dart';
import 'package:biz_sizi_arariz/sayfalar/alici/alici_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MeslekHikayesiSayfasi extends StatelessWidget {
  String meslkeHikayesi;
  String meslek;
  MeslekHikayesiSayfasi(
      {super.key, required this.meslkeHikayesi, required this.meslek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meslek,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1?.color,
          ),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                hikaye(),
              ],
            ),
          ),
          Container(child: buttonlar(context)),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }

  Row buttonlar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [adayButton(context), aliciButton(context)],
    );
  }

  ElevatedButton aliciButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
      ),
      child: NormalYazi(yazi: 'ALICI'),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AliciHomeSayfasi(
            meslekAdi: meslek,
          ),
        ));
      },
    );
  }

  ElevatedButton adayButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
      ),
      child: NormalYazi(yazi: 'ADAY'),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdayHomeSAyfasi(meslekAdi: meslek),
        ));
      },
    );
  }

  hikaye() {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: NormalYazi(yazi: meslkeHikayesi),
        ),
      ),
    );
  }
}
