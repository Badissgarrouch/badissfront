import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF455A64),
      secondary: Color(0xFF607D8B),
      surface: Colors.white,
      background: Color(0xFFECEFF1),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF37474F),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF546E7A),
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Color(0xFF78909C),
      ),
    ),
  );
}