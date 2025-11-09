import 'package:flutter/material.dart';
import '../../utils/constants.dart';

/// AppTypography - Complete typography system for Despacho Jurídico
/// 
/// Follows "Apple meets LegalTech" aesthetic with clean, readable hierarchy.
/// Uses Inter font family with SF Pro Display fallback for maximum elegance.
/// 
/// Design Principles:
/// - Visual hierarchy through weight and size
/// - Clean rhythm with subtle line height and letter spacing
/// - Semantic naming following Material 3 conventions
/// - Modular and easily extensible
/// 
/// Usage:
/// ```dart
/// Text('Title', style: AppTypography.headlineLarge)
/// Text('Subtitle', style: AppTypography.bodyMedium)
/// ```
/// 
/// To extend:
/// Add new semantic helpers using existing base styles:
/// ```dart
/// static TextStyle get cardTitle => titleMedium.copyWith(color: kPrimaryColor);
/// ```
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  /// Base font family with fallback
  static const String _fontFamily = 'Inter';
  static const List<String> _fontFamilyFallback = ['SF Pro Display', 'Roboto'];

  // ==================== Display Styles ====================
  // Large, bold text for hero sections and major headlines
  // Weight: w600 for impact while maintaining elegance

  /// Display Large - Hero text, major headlines
  /// Use for: Splash screens, welcome messages, major section headers
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.2,
    letterSpacing: -0.5,
  );

  /// Display Medium - Large headlines
  /// Use for: Screen titles, prominent cards
  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.25,
    letterSpacing: -0.25,
  );

  /// Display Small - Moderate headlines
  /// Use for: Section headers, card titles
  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.3,
    letterSpacing: 0,
  );

  // ==================== Headline Styles ====================
  // Primary text hierarchy for screen sections and important content
  // Weight: w600 for titles, maintaining clean readability

  /// Headline Large - Major section headers
  /// Use for: Screen section titles, dialog headers
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.35,
    letterSpacing: 0,
  );

  /// Headline Medium - Standard headers
  /// Use for: List section headers, card titles
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.4,
    letterSpacing: 0.15,
  );

  /// Headline Small - Small headers
  /// Use for: Subsection titles, prominent list items
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.45,
    letterSpacing: 0.15,
  );

  // ==================== Title Styles ====================
  // Medium emphasis text for component titles and labels
  // Weight: w600 for clear hierarchy

  /// Title Large - Large component titles
  /// Use for: AppBar titles, dialog titles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.4,
    letterSpacing: 0.15,
  );

  /// Title Medium - Standard component titles
  /// Use for: Card titles, list item primary text
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Title Small - Small component titles
  /// Use for: Small card titles, dense list items
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: kTextColor,
    height: 1.5,
    letterSpacing: 0.1,
  );

  // ==================== Body Styles ====================
  // Primary text for content and reading
  // Weight: w400 for optimal readability

  /// Body Large - Large body text
  /// Use for: Important paragraphs, primary content
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: kTextColor,
    height: 1.6,
    letterSpacing: 0.5,
  );

  /// Body Medium - Standard body text
  /// Use for: Main content, descriptions, paragraphs
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kTextColor,
    height: 1.6,
    letterSpacing: 0.25,
  );

  /// Body Small - Small body text
  /// Use for: Supporting text, secondary information
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kSubtitleColor,
    height: 1.6,
    letterSpacing: 0.4,
  );

  // ==================== Label Styles ====================
  // Text for buttons, tabs, and UI labels
  // Weight: w500 for clarity in interactive elements

  /// Label Large - Large button text
  /// Use for: Primary buttons, prominent CTAs
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.4,
    letterSpacing: 0.1,
  );

  /// Label Medium - Standard label text
  /// Use for: Buttons, tabs, chips
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kTextColor,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Label Small - Small label text
  /// Use for: Small buttons, tags, captions
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: kSubtitleColor,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ==================== Semantic Helpers ====================
  // Pre-configured styles for common use cases
  // Extend this section as needed for specific components

  /// Button text style
  /// Use for: All button labels with consistent styling
  static TextStyle get button => labelLarge.copyWith(
        letterSpacing: 0.5,
        fontWeight: FontWeight.w600,
      );

  /// Card title style
  /// Use for: Card headers and titles
  static TextStyle get cardTitle => titleMedium.copyWith(
        color: kTextColor,
        height: 1.4,
      );

  /// Card subtitle style
  /// Use for: Card descriptions and secondary information
  static TextStyle get cardSubtitle => bodySmall.copyWith(
        color: kSubtitleColor,
      );

  /// AppBar title style
  /// Use for: Top navigation bar titles
  static TextStyle get appBarTitle => titleLarge.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      );

  /// Caption style
  /// Use for: Image captions, footnotes, timestamps
  static TextStyle get caption => labelSmall.copyWith(
        color: kSubtitleColor,
        fontWeight: FontWeight.w400,
      );

  /// Link style
  /// Use for: Hyperlinks and interactive text
  static TextStyle get link => bodyMedium.copyWith(
        color: kPrimaryColor,
        decoration: TextDecoration.underline,
      );

  /// Error text style
  /// Use for: Error messages and validation feedback
  static TextStyle get error => bodySmall.copyWith(
        color: Colors.red,
      );

  // ==================== TextTheme Converter ====================
  // Converts AppTypography to Material TextTheme for seamless integration

  /// Converts AppTypography to Material 3 TextTheme
  /// Use this to apply the typography system to the app theme
  /// 
  /// Example:
  /// ```dart
  /// ThemeData(
  ///   textTheme: AppTypography.toTextTheme(),
  /// )
  /// ```
  static TextTheme toTextTheme() => TextTheme(
        // Display styles
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,

        // Headline styles
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,

        // Title styles
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,

        // Body styles
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,

        // Label styles
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
