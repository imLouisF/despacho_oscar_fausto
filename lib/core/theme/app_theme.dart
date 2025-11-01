import 'package:flutter/material.dart';

/// Application theme configuration
/// Defines colors, fonts, and component styles
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme configuration for the app
  static ThemeData lightTheme = ThemeData(
    // Primary color palette
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    
    // Accent and secondary colors
    colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
      secondary: Colors.deepPurpleAccent,
      surface: Colors.white,
    ),
    
    // Background color
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    
    // Font family
    fontFamily: 'Roboto',
    
    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    
    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    
    // Card theme
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.deepPurple,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}