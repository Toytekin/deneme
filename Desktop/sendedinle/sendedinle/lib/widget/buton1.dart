import 'package:flutter/material.dart';
import 'package:myapp/repo/btn/btn_cubit.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomButton2 extends StatefulWidget {
  Function() onTop;

  double heigt;
  double width;
  Color butonColor;
  Widget widget1;
  Widget widget2;

  CustomButton2({
    super.key,
    required this.onTop,
    this.heigt = 100,
    this.width = 200,
    this.butonColor = Colors.grey,
    required this.widget1,
    required this.widget2,
  });

  @override
  State<CustomButton2> createState() => _CustomButton2State();
}

class _CustomButton2State extends State<CustomButton2> {
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
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
              ),
              color:
                  btnProvider.tiklama2 == false ? Colors.white : Colors.black,
            ),
            child: btnProvider.tiklama2 == false
                ? widget.widget1
                : widget.widget2));
  }
}
