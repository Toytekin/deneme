import 'package:flutter/material.dart';

import '../../enum_yapisi/enum_ile_image_path.dart';

class Body1 extends StatelessWidget {
  const Body1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('HOGVARTS'),
        Image.asset(Resimler.hogvarts.path()),
      ],
    );
  }
}
