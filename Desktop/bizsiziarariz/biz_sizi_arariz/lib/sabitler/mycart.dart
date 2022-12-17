import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCart extends StatelessWidget {
  String kartText;

  MyCart({super.key, required this.kartText});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 3.55,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kartText,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.headline1!.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
