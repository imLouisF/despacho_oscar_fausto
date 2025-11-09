/// App Theme — Phase 8.3
///
/// Comprehensive theme system for Purple Jurídico with sophisticated
/// "Dark Mode Jurídico" that conveys authority, calmness, and elegance.
///
/// **Design Philosophy:**
/// - Light Mode: Professional, clean, approachable
/// - Dark Mode: Elegant, calm, serious with corporate-yet-human feel
///
/// **Visual Keywords:**
/// - Depth, Balance, Precision, Trust
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
///   themeMode: ThemeMode.system,
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../ui_components/ui_components_index.dart';

/// Global theme configuration for Purple Jurídico.
///
/// Provides dual theme support (light/dark) with:
/// - Sophisticated "Dark Mode Jurídico" palette
/// - Cupertino-Material hybrid components
/// - Consistent typography and spacing
/// - Purple-Indigo brand gradient integration
///
/// **Phase 8.3 Enhancements:**
/// - Refined dark mode with depth and elegance
/// - Contrast ratios ≥4.5:1 for all text
/// - Smooth theme transitions
/// - Professional LegalTech aesthetic
class AppTheme {
  AppTheme._(); // Private constructor

  // ─────────────────────────── Light Theme ───────────────────────────

  /// Light theme configuration for Purple Jurídico.
  ///
  /// Professional, clean, and approachable design suitable for
  /// daytime use and high-brightness environments.
  static ThemeData get lightTheme {
    return ThemeData(
      // Core brightness
      brightness: Brightness.light,
      useMaterial3: true,

      // Primary colors
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      primaryColorDark: AppColors.primaryDark,

      // Scaffold and backgrounds
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.surface,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceElevated,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface.withOpacity(0.8),
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        displayMedium: AppTypography.displayMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        displaySmall: AppTypography.displaySmall.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineLarge: AppTypography.headlineLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTypography.headlineMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineSmall: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        titleMedium: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        titleSmall: AppTypography.titleSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.textPrimary,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),

      // Cupertino overrides
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColors.textPrimary,
        ),
      ),
    );
  }

  // ─────────────────────────── Dark Theme (Jurídico) ───────────────────────────

  /// Dark theme configuration for Purple Jurídico.
  ///
  /// **Phase 8.3: "Dark Mode Jurídico"**
  /// Sophisticated dark theme that conveys:
  /// - Authority and professionalism
  /// - Calmness and elegance
  /// - Corporate-yet-human feel
  /// - Trust and precision
  ///
  /// **Color Strategy:**
  /// - Background: #0E0E13 (neutral deep base)
  /// - Surface: #1E1E2F (elevated cards/sheets)
  /// - Text: #E0E0E0 (high contrast, 15.8:1 ratio)
  /// - Accent: Refined purple gradient (60% brightness)
  ///
  /// **Contrast Compliance:**
  /// All text meets WCAG AA standards (≥4.5:1) for readability.
  static ThemeData get darkTheme {
    return ThemeData(
      // Core brightness
      brightness: Brightness.dark,
      useMaterial3: true,

      // Primary colors
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      primaryColorDark: AppColors.primaryDark,

      // Scaffold and backgrounds
      scaffoldBackgroundColor: AppColors.backgroundDark,
      canvasColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        surfaceContainerHighest: AppColors.surfaceElevatedDark,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark.withOpacity(0.8),
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.cardDark,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      // Text theme (optimized for dark backgrounds)
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: AppTypography.displayMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: AppTypography.displaySmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: AppTypography.headlineLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: AppTypography.headlineMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleSmall: AppTypography.titleSmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDark,
        size: 24,
      ),

      // Cupertino overrides
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          primaryColor: AppColors.textPrimaryDark,
        ),
      ),
    );
  }

  // ─────────────────────────── Helper Methods ───────────────────────────

  /// Returns appropriate text color based on brightness.
  static Color getTextColor(Brightness brightness) {
    return brightness == Brightness.light
        ? AppColors.textPrimary
        : AppColors.textPrimaryDark;
  }

  /// Returns appropriate surface color based on brightness.
  static Color getSurfaceColor(Brightness brightness) {
    return brightness == Brightness.light
        ? AppColors.surface
        : AppColors.surfaceDark;
  }

  /// Returns appropriate background color based on brightness.
  static Color getBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light
        ? AppColors.background
        : AppColors.backgroundDark;
  }

  /// Returns appropriate brand gradient based on brightness.
  static LinearGradient getBrandGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? AppColors.brandGradient
        : AppColors.brandGradientDark;
  }

  // ───────────────────────────  Phase 9: A/B Theme Variants ───────────────────────────

  /// Corporate Theme Variant — Phase 9
  ///
  /// **Design Philosophy:**
  /// - Formal and subdued palette
  /// - Static gradient (no motion)
  /// - Professional, conservative aesthetic
  /// - Reduced saturation for corporate feel
  ///
  /// **Color Strategy:**
  /// - Gradient: #6A1B9A → #4527A0 (low saturation)
  /// - Subtle, professional appearance
  /// - Maintains WCAG AA compliance
  static ThemeData get corporateLight {
    return lightTheme.copyWith(
      primaryColor: const Color(0xFF6A1B9A),
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: const Color(0xFF6A1B9A),
        secondary: const Color(0xFF4527A0),
      ),
    );
  }

  /// Corporate Dark Theme Variant
  static ThemeData get corporateDark {
    return darkTheme.copyWith(
      primaryColor: const Color(0xFF6A1B9A),
      colorScheme: darkTheme.colorScheme.copyWith(
        primary: const Color(0xFF6A1B9A),
        secondary: const Color(0xFF4527A0),
      ),
    );
  }

  /// Social Theme Variant — Phase 9
  ///
  /// **Design Philosophy:**
  /// - Vivid, gradient-based palette
  /// - Motion-enhanced (shimmer animations)
  /// - Modern, engaging aesthetic
  /// - Full saturation Purple Jurídico brand
  ///
  /// **Color Strategy:**
  /// - Gradient: #7E57C2 → #512DA8 (vivid)
  /// - Enhanced visual presence
  /// - Maintains WCAG AA compliance
  static ThemeData get socialLight {
    return lightTheme.copyWith(
      primaryColor: const Color(0xFF7E57C2),
      colorScheme: lightTheme.colorScheme.copyWith(
        primary: const Color(0xFF7E57C2),
        secondary: const Color(0xFF512DA8),
      ),
    );
  }

  /// Social Dark Theme Variant
  static ThemeData get socialDark {
    return darkTheme.copyWith(
      primaryColor: const Color(0xFF7E57C2),
      colorScheme: darkTheme.colorScheme.copyWith(
        primary: const Color(0xFF7E57C2),
        secondary: const Color(0xFF512DA8),
      ),
    );
  }

  // ───────────────────────────  Variant Getters ───────────────────────────

  /// Returns corporate theme variant (light + dark)
  static AppThemeVariantPair get corporate => AppThemeVariantPair(
        light: corporateLight,
        dark: corporateDark,
      );

  /// Returns social theme variant (light + dark)
  static AppThemeVariantPair get social => AppThemeVariantPair(
        light: socialLight,
        dark: socialDark,
      );
}

/// Theme variant pair (light + dark) for A/B testing.
///
/// **Phase 9 Helper Class:**
/// Groups light and dark themes together for easy variant switching.
class AppThemeVariantPair {
  final ThemeData light;
  final ThemeData dark;

  const AppThemeVariantPair({
    required this.light,
    required this.dark,
  });
}
