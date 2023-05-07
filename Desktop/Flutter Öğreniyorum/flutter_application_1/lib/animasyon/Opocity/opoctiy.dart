import 'package:flutter/material.dart';

class OpocityScreen extends StatefulWidget {
  const OpocityScreen({super.key});

  @override
  State<OpocityScreen> createState() => _OpocityScreenState();
}

class _OpocityScreenState extends State<OpocityScreen> {
  bool _isOpocity = false;

  opocitChance() {
    setState(() {
      _isOpocity = !_isOpocity; //! oposity değerini terse çevir
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.green,
              child: ListTile(
                title: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity:
                        _isOpocity //! bool yun değişkenimize göre opocityi ayarla
                            ? 0
                            : 1,
                    child: const Text('Deneem Yazisi')),
                trailing: IconButton(
                    onPressed: () {
                      opocitChance(); //! oposity metodu aktifleştir
                    },
                    icon: const Icon(Icons.change_circle)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
