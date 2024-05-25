import 'package:ads/core/constant/color.dart';
import 'package:flutter/material.dart';

class RandevuText extends StatelessWidget {
  const RandevuText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Randevu Oluşturma Ekranı',
      style: TextStyle(
        color: SbtColors.yaziRenk,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class RandevuTextSub extends StatelessWidget {
  const RandevuTextSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '(Bir Akademisyen Seç)',
      style: TextStyle(
        color: SbtColors.yaziRenk,
        fontSize: 12,
      ),
    );
  }
}
