import 'package:ads/core/constant/color.dart';
import 'package:flutter/material.dart';

class SbtTextStyle {
  var normalStyle = TextStyle(color: SbtColors.yaziRenk, fontSize: 18);
  var normalStyleBold = const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  //

  var largeStyle = TextStyle(color: SbtColors.yaziRenk, fontSize: 20);
  var largeStyleBold = TextStyle(
      color: SbtColors.yaziRenk, fontSize: 20, fontWeight: FontWeight.bold);
  var largeStyleBoldSiyah = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  //

  var midumStyle = const TextStyle(color: Colors.black, fontSize: 15);
  var midumStyleBold = TextStyle(
      color: SbtColors.yaziRenk, fontSize: 15, fontWeight: FontWeight.bold);
}
