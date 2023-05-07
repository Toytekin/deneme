import 'package:flutter/material.dart';

import '../../enum_yapisi/enum_ile_image_path.dart';

class Body2 extends StatelessWidget {
  const Body2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hermony'),
          Image.asset(Resimler.hermony.path()),
        ],
      ),
    );
  }
}
