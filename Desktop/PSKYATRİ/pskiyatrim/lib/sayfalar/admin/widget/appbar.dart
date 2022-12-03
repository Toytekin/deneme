import 'package:flutter/material.dart';
import 'package:pskiyatrim/sabitler/color.dart';

// ignore: camel_case_types, must_be_immutable
class appbarAdmin extends StatelessWidget with PreferredSizeWidget {
  String appbarTitile;
  VoidCallback press;
  Icon icon;
  Widget appbarWidget;
  Color arkaplanRengi;
  appbarAdmin(
      {super.key,
      required this.appbarTitile,
      required this.press,
      this.arkaplanRengi = Colors.black,
      this.icon = const Icon(Icons.exit_to_app),
      this.appbarWidget = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: SbtRenkler.instance.anaRenk,
      title: Text(
        appbarTitile,
        style: const TextStyle(color: Colors.white),
      ),

      //! Aktion
      actions: [
        Row(
          children: [
            appbarWidget,
            IconButton(
              onPressed: press,
              icon: icon,
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(70);
  }
}
