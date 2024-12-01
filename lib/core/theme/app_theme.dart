import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryColor = Color(0xFF0076c4);
  static const Color secondaryColor = Color(0xFFffdf08);
  static const Color tertiaryColor = Color(0xFF803634);

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
    ),
    primaryColor: primaryColor,
    secondaryHeaderColor: secondaryColor,
  );

  static final ThemeData dark = light.copyWith(
    brightness: Brightness.dark,
    colorScheme: light.colorScheme.copyWith(brightness: Brightness.dark),
  );
}
