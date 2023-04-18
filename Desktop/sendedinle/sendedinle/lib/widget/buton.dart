import 'package:flutter/material.dart';
import 'package:myapp/repo/btn/btn_cubit.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomButton1 extends StatefulWidget {
  Function() onTop;

  double heigt;
  double width;
  Color butonColor;
  Widget widget1;
  Widget widget2;

  CustomButton1({
    super.key,
    required this.onTop,
    this.heigt = 100,
    this.width = 200,
    this.butonColor = Colors.grey,
    required this.widget1,
    required this.widget2,
  });

  @override
  State<CustomButton1> createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  @override
  Widget build(BuildContext context) {
    var btnProvider = Provider.of<BtnTiklama>(context);

    return InkWell(
        onTap: widget.onTop,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.heigt,
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
              ),
              color: widget.butonColor,
              boxShadow: btnProvider.tiklama == false
                  ? []
                  : [
                      const BoxShadow(
                          color: Colors.black,
                          offset: Offset(6, 6),
                          blurRadius: 1,
                          spreadRadius: 3),
                      const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, -2),
                          blurRadius: 8,
                          spreadRadius: 1),
                    ],
            ),
            child: btnProvider.tiklama == false
                ? widget.widget1
                : widget.widget2));
  }
}
