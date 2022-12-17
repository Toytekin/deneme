import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NormalYazi extends StatelessWidget {
  String yazi;
  NormalYazi({super.key, required this.yazi});

  @override
  Widget build(BuildContext context) {
    return Text(
      yazi,
      style: TextStyle(
          fontSize: 20, color: Theme.of(context).textTheme.headline1!.color),
    );
  }
}
