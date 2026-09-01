import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFFFFFF);
  static const ink = Color(0xFF202124);
  static const dark = Color(0xFF333333);
  static const muted = Color(0xFF858995);
  static const line = Color(0xFFEDEDEF);
  static const soft = Color(0xFFF7F6F8);
  static const blush = Color(0xFFF9EDE7);
  static const coral = Color(0xFFFF536E);
  static const green = Color(0xFF4E958B);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.coral),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.ink,
          elevation: 0,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.soft,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none,
          ),
        ),
      );
}
