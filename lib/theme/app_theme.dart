import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color.fromRGBO(101, 39, 105, 1);
  static const Color bg = Color(0xFFF7F3F6);
  static const Color textDark = Color(0xFF2D232B);
  static const Color textMuted = Color(0xFF7C6F77);
  static const Color hint = Color(0xFF9A8F97);
  static const Color border = Color(0xFFE7DAE3);

  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
    );
  }
}