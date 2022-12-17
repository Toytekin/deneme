import 'package:biz_sizi_arariz/sabitler/renkler.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KartiGoster extends StatelessWidget {
  String yaziText;
  KartiGoster({super.key, required this.yaziText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler().anaRenk,
      body: Center(
        child: Text(
          yaziText,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Renkler().yazi.withOpacity(0.3),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
