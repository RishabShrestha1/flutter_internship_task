import 'package:flutter/material.dart';

ThemeData mytheme = ThemeData(
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color.fromARGB(255, 133, 139, 226),
    secondary: Color.fromARGB(255, 144, 202, 249),
    inversePrimary: Colors.white,
  ),
  cardTheme: const CardTheme(
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
);
