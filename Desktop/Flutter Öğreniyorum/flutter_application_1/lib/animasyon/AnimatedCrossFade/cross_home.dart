import 'package:flutter/material.dart';
import 'package:flutter_application_1/animasyon/AnimatedCrossFade/body_1.dart';

import 'body2.dart';

class AnimatedCrosScreen extends StatefulWidget {
  const AnimatedCrosScreen({super.key});

  @override
  State<AnimatedCrosScreen> createState() => _AnimatedCrosScreenState();
}

class _AnimatedCrosScreenState extends State<AnimatedCrosScreen> {
  bool tiklandi = false;
  final globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade'),
      ),
      body: AnimatedCrossFade(
          firstChild: const Body1(), //! GELMESİNİ İSTEDİĞİMİZ İLK EKRAN
          secondChild: const Body2(), //! GELMESİNİ İSTEDİĞİMİZ 2. EKRAN
          crossFadeState:
              tiklandi ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: _Duration.yavas), //! GÖSTERİLECEK EKRAN
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            tiklandi =
                !tiklandi; //! DURUMU DEĞİŞTİRMEK İÇİN KULLANILANM DEĞİŞKEN
          });
        },
      ),
    );
  }
}

class _Duration {
  static const yavas = Duration(seconds: 1);
}
