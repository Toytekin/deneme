import 'package:flutter/material.dart';

final ThemeData beyazTema = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    focusColor: Colors.purpleAccent,
    primaryColor: const Color(0xffe91e63),
    primaryColorDark: const Color(0xffc2185b),
    scaffoldBackgroundColor: const Color(0xfffffff8),
    bottomAppBarColor: const Color.fromARGB(255, 174, 174, 171),
    cardColor: const Color(0xfffffff8),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xfffffff8),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xfffffff8),
    ),
    textTheme: const TextTheme(
        headline1: TextStyle(
      color: Colors.black,
      fontSize: 10,
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    )));

final ThemeData kirmiziTema = ThemeData(
    focusColor: Colors.purpleAccent,
    primarySwatch: Colors.red,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xffEF9F9F),
    ),
    primaryColor: const Color(0xffe91e63),
    primaryColorDark: const Color(0xffc2185b),
    scaffoldBackgroundColor: const Color(0xffEF9F9F),
    bottomAppBarColor: const Color(0xffffffff),
    cardColor: const Color(0xffF47C7C),
    textTheme: const TextTheme(
        headline1: TextStyle(
      color: Colors.black,
      fontSize: 10,
    )));

final ThemeData sariTema = ThemeData(
    focusColor: Colors.purpleAccent,
    primarySwatch: Colors.amber,
    primaryColor: const Color.fromARGB(255, 194, 190, 191),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xffFDFDBD),
    ),
    scaffoldBackgroundColor: const Color(0xffFDFDBD),
    bottomAppBarColor: const Color(0xffffffff),
    cardColor: const Color(0xffFED049),
    textTheme: const TextTheme(
        headline1: TextStyle(
      color: Colors.black,
      fontSize: 20,
    )));

final ThemeData kahverengiTema = ThemeData(
  focusColor: Colors.white,
  primarySwatch: Colors.brown,
  scaffoldBackgroundColor: const Color(0xff9E7676),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xff9E7676),
  ),
  bottomAppBarColor: const Color(0xff9E7676),
  cardColor: const Color(0xff815B5B),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
);
final ThemeData maviTema = ThemeData(
    sliderTheme: const SliderThemeData(activeTickMarkColor: Colors.red),
    focusColor: Colors.white,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xff607EAA),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xff607EAA),
    ),
    bottomAppBarColor: const Color(0xff9E7676),
    cardColor: Colors.indigo,
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xffC4DDFF),
        fontSize: 20,
      ),
    ));
