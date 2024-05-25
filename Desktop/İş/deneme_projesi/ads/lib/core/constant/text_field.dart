import 'package:ads/core/constant/color.dart';
import 'package:flutter/material.dart';

class SbtTextField extends StatelessWidget {
  Widget icon;
  final TextEditingController controller;
  final String label;
  final bool sifrelimi;
  SbtTextField({
    super.key,
    required this.controller,
    required this.label,
    this.sifrelimi = false,
    this.icon = const Icon(Icons.add),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          style: TextStyle(color: SbtColors.yaziRenk),
          // Bu özellik metni gizler
          obscureText: sifrelimi,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: Colors.white,
            labelText: label,
            labelStyle: TextStyle(color: SbtColors.yaziRenk), // Etiket rengi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: SbtColors.yaziRenk), // Aktif olduğunda sınır rengi
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: SbtColors.yaziRenk), // Pasif olduğunda sınır rengi
            ),
          ),
        ));
  }
}

class SbtTextFieldMesaj extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool sifrelimi;
  Widget icon;
  SbtTextFieldMesaj({
    super.key,
    required this.controller,
    required this.label,
    this.icon = const Icon(Icons.add),
    this.sifrelimi = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLines: 8,
          style: TextStyle(color: SbtColors.yaziRenk),
          // Bu özellik metni gizler
          obscureText: sifrelimi,
          controller: controller,
          decoration: InputDecoration(
            prefixIconColor: Colors.white,
            prefixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(color: SbtColors.yaziRenk), // Etiket rengi
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: SbtColors.yaziRenk), // Aktif olduğunda sınır rengi
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: SbtColors.yaziRenk), // Pasif olduğunda sınır rengi
            ),
          ),
        ));
  }
}
