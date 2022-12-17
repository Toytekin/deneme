import 'dart:convert';

import 'package:biz_sizi_arariz/modeller/meslek_model.dart';
import 'package:biz_sizi_arariz/sabitler/renkler.dart';
import 'package:biz_sizi_arariz/sabitler/yazi.dart';
import 'package:biz_sizi_arariz/sayfalar/meslek_hikayesi.dart';
import 'package:flutter/material.dart';

class MesleklerSayfasi extends StatefulWidget {
  const MesleklerSayfasi({super.key});

  @override
  State<MesleklerSayfasi> createState() => _MesleklerSayfasiState();
}

class _MesleklerSayfasiState extends State<MesleklerSayfasi> {
  late List<Meslekler> tumMeslekler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          automaticallyImplyLeading: false,
          title: Text(
            'Meslekler',
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1?.color),
          ),
        ),
        body: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('asset/json/meslekler.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var myData = jsonDecode(snapshot.data.toString());
              tumMeslekler = (myData as List)
                  .map((meslekMap) => Meslekler.fromMap(meslekMap))
                  .toList();

              return listvivbuilder();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  ListView listvivbuilder() {
    return ListView.builder(
      itemCount: tumMeslekler.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MeslekHikayesiSayfasi(
                meslkeHikayesi: tumMeslekler[index].hikaye.toString(),
                meslek: tumMeslekler[index].adi.toString(),
              ),
            ));
          },
          child: Card(
            elevation: 5,
            child: ListTile(
              title: NormalYazi(yazi: tumMeslekler[index].adi.toString()),
            ),
          ),
        );
      },
    );
  }
}
