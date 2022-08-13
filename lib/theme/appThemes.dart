import 'package:flutter/material.dart';

class AppThemes {
  static const Color textMessageBubble = Color(0xFF11C730);
  static ThemeData dark = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(160, 51, 50, 50),
      backgroundColor: Color.fromARGB(162, 51, 50, 50),
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white)));
  static ThemeData light = ThemeData(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black)));
}
