import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SbtTextFild extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  SbtTextFild({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SbtTextFild2 extends StatelessWidget {
  TextEditingController textEditingController;
  bool sifremi;
  String hintText;
  SbtTextFild2(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.sifremi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: sifremi == false ? false : true,
        style: const TextStyle(color: Colors.white),
        controller: textEditingController,
        decoration: InputDecoration(
          counterStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.white,
          focusColor: Colors.white,
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 5)),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SbtTextFild3 extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;
  SbtTextFild3({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: 15,
        controller: textEditingController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
