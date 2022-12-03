import 'package:flutter/material.dart';
import 'package:pskiyatrim/sabitler/text.dart';

// ignore: must_be_immutable
class SabitTextField extends StatelessWidget {
  TextEditingController controller;
  Color bordercolor;
  String label;
  String hinText;
  int maxSize;
  int minSize;
  TextInputType keybordTyp;
  SabitTextField(
      {super.key,
      required this.controller,
      required this.bordercolor,
      required this.hinText,
      required this.label,
      this.maxSize = 2,
      this.minSize = 1,
      this.keybordTyp = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keybordTyp,
      maxLines: maxSize,
      minLines: minSize,
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: bordercolor),
          ),
          label: Text(
            label,
            style: SaaText.sbtStilSiyah,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 10, color: bordercolor),
          ),
          hintText: hinText),
    );
  }
}
