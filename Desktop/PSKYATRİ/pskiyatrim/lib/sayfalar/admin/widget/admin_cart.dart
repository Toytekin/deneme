import 'package:flutter/material.dart';
import 'package:pskiyatrim/sabitler/color.dart';

// ignore: must_be_immutable
class AdminCart extends StatelessWidget {
  VoidCallback press;
  Color arkaRenk;
  String text;
  Color yaziRenk;
  double fontSize;
  Widget leadingIcon;
  AdminCart(
      {Key? key,
      required this.press,
      required this.arkaRenk,
      required this.text,
      required this.leadingIcon,
      this.yaziRenk = Colors.white70,
      this.fontSize = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        shadowColor: Colors.black,
        elevation: 0,
        color: SbtRenkler.instance.anaRenk,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  leadingIcon,
                  Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: fontSize),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 50,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
