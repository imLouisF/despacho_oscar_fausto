import 'package:flutter/material.dart';

/// AppTheme - Complete theme system for Despacho Jurídico
/// Uses Deep Purple Jurídico color palette with gradients and shadows
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ==================== Color Palette ====================
  
  /// Primary brand color - Deep purple
  static const Color primary = Color(0xFF5B4B8A);
  
  /// Secondary color - Lighter purple
  static const Color secondary = Color(0xFF7F6BB3);
  
  /// Accent color - Soft purple
  static const Color accent = Color(0xFFB8A8E5);
  
  /// Background color - Very light purple tint
  static const Color background = Color(0xFFF9F8FF);
  
  /// Surface color - Semi-transparent white
  static final Color surface = Colors.white.withValues(alpha: 0.8);
  
  /// Error color - Red accent
  static const Color error = Colors.redAccent;

  // ==================== Gradient System ====================
  
  /// Deep purple diagonal gradient (primary to secondary)
  static const LinearGradient deepPurpleGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==================== Shadow System ====================
  
  /// Light shadow - Subtle elevation
  static const BoxShadow lightShadow = BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    color: Colors.black12,
  );
  
  /// Medium shadow - Standard elevation
  static const BoxShadow mediumShadow = BoxShadow(
    offset: Offset(0, 3),
    blurRadius: 6,
    color: Colors.black26,
  );

  // ==================== Border Radius ====================
  
  /// Default border radius
  static const double defaultRadius = 16.0;

  // ==================== Light Theme ====================
  
  /// Main light theme configuration
  static ThemeData lightTheme = ThemeData(
    // Use Material 3
    useMaterial3: true,
    
    // Color scheme
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black87,
      onError: Colors.white,
    ),
    
    // Scaffold background
    scaffoldBackgroundColor: background,
    
    // Primary colors
    primaryColor: primary,
    
    // Font family
    fontFamily: 'Roboto',
    
    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    
    // Bottom Navigation Bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // Card theme
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: BorderSide(color: primary.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
        borderSide: const BorderSide(color: error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    
    // Text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.black54,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    
    // Icon theme
    iconTheme: const IconThemeData(
      color: primary,
      size: 24,
    ),
    
    // Divider theme
    dividerTheme: DividerThemeData(
      color: primary.withValues(alpha: 0.2),
      thickness: 1,
      space: 1,
    ),
  );
}
