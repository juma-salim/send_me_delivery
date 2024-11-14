import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'OpenSans', fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        fontFamily: 'OpenSans', fontSize: 28, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(
        fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
        fontFamily: 'OpenSans', fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
        fontFamily: 'OpenSans', fontSize: 12, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(
        fontFamily: 'OpenSans', fontSize: 16, fontWeight: FontWeight.normal),
    titleMedium: TextStyle(
        fontFamily: 'OpenSans', fontSize: 14, fontWeight: FontWeight.normal),
    displayLarge: TextStyle(
        fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(
        fontFamily: 'OpenSans', fontSize: 16, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        fontFamily: 'OpenSans', fontSize: 18, fontWeight: FontWeight.bold),
  ),
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    onSurface: Colors.black,
    primary: Colors.orange,
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 240, 140, 9),
    onSecondary: Colors.white,
    tertiary: Colors.orangeAccent,
    error: Colors.red,
    outline: Colors.black,
    inverseSurface: Colors.orange,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    onSurface: Colors.white,
    primary: Color.fromARGB(255, 115, 212, 116),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 13, 100, 17),
    onSecondary: Colors.black,
    tertiary: Colors.green,
    error: Colors.red,
    outline: Colors.white,
    inverseSurface: Colors.orange,
  ),
);
