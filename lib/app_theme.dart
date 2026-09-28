import 'package:flutter/material.dart';

class AppTheme {
  // Warna utama ITNP
  static const Color primary = Color(0xFFFF6600);
  static const Color secondary = Color(0xFFFFBE32);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textDark = Color(0xFF333333);
  static const Color textGrey = Color(0xFF888888);

  static ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        primaryColor: primary,
        scaffoldBackgroundColor: background,
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: secondary,
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
