import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../modeller/kelime_model.dart';
import '../../sabitler/mycart.dart';
import '../alici/karti_goster.dart';
import '../basla.dart';

// ignore: must_be_immutable
class AdayHomeSAyfasi extends StatefulWidget {
  String meslekAdi;
  AdayHomeSAyfasi({super.key, required this.meslekAdi});

  @override
  State<AdayHomeSAyfasi> createState() => _AdayHomeSAyfasiState();
}

class _AdayHomeSAyfasiState extends State<AdayHomeSAyfasi> {
  List<Kelimeler>? tumMeslekler;

//
  final String _puanText = 'Puan';
  @override
  void initState() {
    datayiAl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Oyundan çıkmak istediğine eminmisin?'),
              actions: [
                //! Hayır
                ElevatedButton(
                  child: Text(
                    'Hayır',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

                ElevatedButton(
                  child: Text(
                    'Evet',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const BaslaSayfasi(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      KartiGoster(yaziText: tumMeslekler![index].kelime),
                ));
              },
              child: tumMeslekler != null
                  ? MyCart(
                      kartText: tumMeslekler![index].kelime,
                    )
                  : const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  AppBar appBarrim() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        widget.meslekAdi,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1?.color,
        ),
      ),
    );
  }

  Future<void> datayiAl() async {
    final String response =
        await rootBundle.loadString('asset/json/feature.json');
    final data = await json.decode(response);
    tumMeslekler = (data as List)
        .map((meslekMap) => Kelimeler.fromMap(meslekMap))
        .toList();
    tumMeslekler!.shuffle();
    setState(() {});
  }
}
