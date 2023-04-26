import 'package:flutter/material.dart';

const primaryColor = Color(0xff082659);
const secondaryColor = Color(0xff51eec2);
const backgroundColor = Color.fromRGBO(249, 246, 238, 1);
const labelColor = Color.fromRGBO(224, 224, 224, 1);

final appTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: labelColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        prefixIconColor: Colors.black));
