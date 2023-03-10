import 'package:flutter/material.dart';

class ThemeManager {
  static String appName = "Shop App";
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;
  static Color lightAccent = const Color(0xFFD17E50);
  static Color darkAccent = Colors.blueAccent;
  static Color lightBG = Colors.grey.shade50;
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    scaffoldBackgroundColor: lightPrimary,
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Colors.grey[600],
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.grey[600], fontSize: 22.0, fontWeight: FontWeight.w800),
      subtitle1: TextStyle(
          color: Colors.grey[700], fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          color: Colors.grey[500], fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          color: Colors.grey[500], fontSize: 14.0, fontWeight: FontWeight.w400),
      button: TextStyle(
          color: lightBG, fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      height: 50.0,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
