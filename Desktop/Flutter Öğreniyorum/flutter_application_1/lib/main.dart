import 'package:flutter/material.dart';
import 'package:flutter_application_1/animasyon/Opocity/opoctiy.dart';
import 'package:flutter_application_1/kalitim/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      //home: OpocityScreen(),
      home: AbstracClassKullanimi(),
    );
  }
}
