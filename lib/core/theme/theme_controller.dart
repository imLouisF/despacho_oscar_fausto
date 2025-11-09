/// Theme Controller — Phase 9
///
/// Manages dual visual perception system (Corporate vs Social).
/// Provides live theme variant switching with persistence.
///
/// **Variants:**
/// - Corporate: Formal, subdued palette, static gradient
/// - Social: Vivid, gradient-based, motion-enhanced
///
/// Example:
/// ```dart
/// final controller = ThemeModeController();
/// await controller.initialize();
/// controller.toggleThemeVariant();
/// ```
library;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme variant options for A/B visual perception testing.
enum AppThemeVariant {
  /// Corporate theme: formal, subdued, static
  corporate,

  /// Social theme: vivid, gradient-based, motion-enhanced
  social,
}

/// Controller for managing theme variant state and persistence.
///
/// **Phase 9 Features:**
/// - Dual theme variant system (Corporate/Social)
/// - Live switching with animation support
/// - SharedPreferences persistence
/// - ChangeNotifier for reactive UI updates
///
/// **Usage:**
/// ```dart
/// // Initialize
/// final controller = ThemeModeController();
/// await controller.initialize();
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Variant: ${controller.currentVariant.value}');
/// });
///
/// // Toggle variant
/// controller.toggleThemeVariant();
/// ```
class ThemeModeController extends ChangeNotifier {
  /// Storage key for theme variant preference
  static const String _storageKey = 'theme_variant';

  /// Current theme variant notifier
  final ValueNotifier<AppThemeVariant> currentVariant;

  /// Creates a theme controller with default social variant
  ThemeModeController({
    AppThemeVariant initialVariant = AppThemeVariant.social,
  }) : currentVariant = ValueNotifier<AppThemeVariant>(initialVariant);

  /// Initializes controller and loads persisted variant preference.
  ///
  /// Should be called once at app startup before building UI.
  /// Defaults to AppThemeVariant.social if no saved preference exists.
  ///
  /// **Returns:** Future that completes when initialization is done.
  Future<void> initialize() async {
    if (kDebugMode) {
      print('[AppTheme] Initializing ThemeModeController...');
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedVariant = prefs.getString(_storageKey);

      if (savedVariant != null) {
        // Parse saved variant
        final variant = AppThemeVariant.values.firstWhere(
          (v) => v.toString() == savedVariant,
          orElse: () => AppThemeVariant.social,
        );

        currentVariant.value = variant;
        notifyListeners();

        if (kDebugMode) {
          print('[AppTheme] ✓ Loaded saved variant: ${_variantName(variant)}');
        }
      } else {
        if (kDebugMode) {
          print('[AppTheme] ✓ No saved variant, using default: Social Professional');
        }
      }

      if (kDebugMode) {
        print('[AppTheme] ✓ Initialization complete. Active variant: ${_variantName(currentVariant.value)}');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('[AppTheme] ✗ Error loading variant: $e');
        print('[AppTheme] Stack trace: $stackTrace');
      }
      // Continue with default variant
    }
  }

  /// Toggles between Corporate and Social theme variants.
  ///
  /// Automatically persists the new selection and notifies listeners
  /// to trigger UI rebuild with AnimatedTheme transition.
  ///
  /// **Behavior:**
  /// - Corporate → Social
  /// - Social → Corporate
  Future<void> toggleThemeVariant() async {
    final newVariant = currentVariant.value == AppThemeVariant.corporate
        ? AppThemeVariant.social
        : AppThemeVariant.corporate;

    await setThemeVariant(newVariant);
  }

  /// Sets specific theme variant and persists the selection.
  ///
  /// **Parameters:**
  /// - [variant] — Target theme variant to activate
  ///
  /// **Side Effects:**
  /// - Updates currentVariant.value
  /// - Saves to SharedPreferences
  /// - Notifies listeners for UI rebuild
  /// - Logs variant change in debug mode
  Future<void> setThemeVariant(AppThemeVariant variant) async {
    if (currentVariant.value == variant) {
      return; // No change needed
    }

    currentVariant.value = variant;
    notifyListeners();

    // Persist selection
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, variant.toString());

      if (kDebugMode) {
        print('[AppTheme] Current variant: ${_variantName(variant)}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AppTheme] Error saving variant: $e');
      }
    }
  }

  /// Returns user-friendly name for variant.
  String _variantName(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.corporate:
        return 'Corporate';
      case AppThemeVariant.social:
        return 'Social Professional';
    }
  }

  /// Returns user-friendly name for current variant.
  String get currentVariantName => _variantName(currentVariant.value);

  /// Checks if current variant is corporate.
  bool get isCorporate => currentVariant.value == AppThemeVariant.corporate;

  /// Checks if current variant is social.
  bool get isSocial => currentVariant.value == AppThemeVariant.social;

  @override
  void dispose() {
    currentVariant.dispose();
    super.dispose();
  }
}
