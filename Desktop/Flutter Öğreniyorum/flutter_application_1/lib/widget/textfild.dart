import 'package:flutter/material.dart';

class SabtTextFild extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  SabtTextFild({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 3,
              ),
            ),
            border: const OutlineInputBorder(
                gapPadding: 100,
                borderRadius: BorderRadius.all(Radius.circular(12))),

            ///
            ///
            ///
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.all(50),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 3,
              ),
            ),
            fillColor: Colors.yellow,
            filled: true,
            label: Text(hintText),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle:
                const TextStyle(color: Colors.purple, fontSize: 20)),
        cursorColor: Colors.teal,
        cursorHeight: 40,
        cursorWidth: 10,
        cursorRadius: const Radius.circular(25),
        maxLength: 50,
        maxLines: 10,
        minLines: 2,
      ),
    );
  }
}
