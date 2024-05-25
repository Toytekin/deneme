import 'package:flutter/material.dart';

class SecilenAkad extends StatelessWidget {
  final String userName;
  const SecilenAkad({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Seçilen Akademisyen: '),
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
