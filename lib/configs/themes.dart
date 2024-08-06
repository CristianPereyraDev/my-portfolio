import 'package:flutter/material.dart';

final themeDark = ThemeData.from(
  colorScheme: const ColorScheme.dark(
    primary: Color.fromRGBO(194, 208, 44, 1.0),
    secondary: Color.fromRGBO(176, 115, 96, 1.0),
    surface: Color.fromRGBO(53, 53, 53, 1.0),
    onSurface: Color.fromRGBO(212, 212, 212, 1.0),
    inverseSurface: Color.fromRGBO(131, 131, 131, 1),
  ),
).copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(28, 28, 28, 1.0),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(46, 46, 46, 1),
    elevation: 4.0,
    shadowColor: Colors.black,
    surfaceTintColor: Colors.transparent,
  ),
);
