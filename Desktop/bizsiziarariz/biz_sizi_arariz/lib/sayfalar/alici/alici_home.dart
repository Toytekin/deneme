import 'dart:convert';
import 'package:biz_sizi_arariz/modeller/kelime_model.dart';
import 'package:biz_sizi_arariz/provider/puan.dart';
import 'package:biz_sizi_arariz/sabitler/mycart.dart';
import 'package:biz_sizi_arariz/sabitler/yazi.dart';
import 'package:biz_sizi_arariz/sayfalar/basla.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'karti_goster.dart';

// ignore: must_be_immutable
class AliciHomeSayfasi extends StatefulWidget {
  String meslekAdi;
  AliciHomeSayfasi({super.key, required this.meslekAdi});

  @override
  State<AliciHomeSayfasi> createState() => _AliciHomeSayfasiState();
}

class _AliciHomeSayfasiState extends State<AliciHomeSayfasi> {
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
    var provider = Provider.of<PuanArttirProvider>(context, listen: true);
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
          appBar: appBarrim(provider),
          body: ListView.builder(
            itemCount: 4,
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
          floatingActionButton: floatinButtonlar(provider)),
    );
  }

  Row floatinButtonlar(PuanArttirProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        cikarButton(provider),
        const SizedBox(width: 50),
        ekleButton(provider),
      ],
    );
  }

  FloatingActionButton ekleButton(PuanArttirProvider provider) {
    return FloatingActionButton(
      backgroundColor: Colors.green.withOpacity(0.7),
      heroTag: 'cikar',
      child: const Icon(Icons.add),
      onPressed: () {
        provider.puanVer();
      },
    );
  }

  FloatingActionButton cikarButton(PuanArttirProvider provider) {
    return FloatingActionButton(
      heroTag: 'arti',
      backgroundColor: Colors.red.withOpacity(0.5),
      child: const Text(
        '-',
        style: TextStyle(fontSize: 30),
      ),
      onPressed: () {
        provider.puanAl();
      },
    );
  }

  AppBar appBarrim(PuanArttirProvider provider) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        widget.meslekAdi,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1?.color,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NormalYazi(yazi: _puanText),
            const SizedBox(width: 20),
            NormalYazi(yazi: provider.count.toString()),
            const SizedBox(width: 20),
          ],
        ),
      ],
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
