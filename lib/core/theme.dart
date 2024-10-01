import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF6C2F80);

final ThemeData themeData = ThemeData(
  fontFamily: "IBMSans",
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )
      ),
      backgroundColor: MaterialStatePropertyAll(
        primaryColor
      ),
      foregroundColor: const MaterialStatePropertyAll(
        Colors.white
      ),
      
    )
  )
);