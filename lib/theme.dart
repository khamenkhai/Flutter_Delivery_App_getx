import 'package:flutter/material.dart';

class AppTheme {
  AppTheme() {
    print("theme init function running!");
  }

  static ThemeData lightGreenTheme = ThemeData(
    useMaterial3: false,
    primaryColor: Colors.lightGreen,
    primarySwatch: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.07,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(buttonColor: Colors.lightGreen),
    fontFamily: "inter",
  );

  // static ThemeData blueTheme = ThemeData(
  //   useMaterial3: false,
  //   primaryColor: Colors.lightBlue,
  //   primarySwatch: Colors.blue,
  //   scaffoldBackgroundColor: Color(0xFFF5F5F5),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     foregroundColor: Colors.black,
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.lightBlue,
  //   ),
  //   fontFamily: "inter",
  // );
}