import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.grey,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),

      // Primary Colors
      primaryColor: Colors.black,
      primarySwatch: Colors.grey,

      // Scaffold Background
      scaffoldBackgroundColor: Colors.white,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),

      // Text Themes
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: Colors.black, fontSize: 22),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: BorderSide(color: Colors.black),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.black12, width: 1),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.black26,
        thickness: 1,
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: Colors.black,
      ),

      // Brightness
      brightness: Brightness.light,
    );
  }

  // Dark Theme Variant
  static ThemeData get darkTheme {
    return ThemeData(
      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.grey,
        surface: Colors.black87,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
      ),

      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),

      // Text Themes
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: Colors.white, fontSize: 22),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
