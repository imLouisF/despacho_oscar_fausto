import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/services.dart' show HapticFeedback;

/// 🎯 AppHaptics - Production-Ready Haptic Feedback System
///
/// Provides elegant, subtle tactile responses that match the "Apple meets LegalTech"
/// UX direction and integrate seamlessly with AppMotion timing system.
///
/// Core Features:
/// - Platform-aware haptic feedback (iOS, Android, Web, Desktop)
/// - Safe execution with try-catch error handling
/// - Null-safe and async-safe implementation
/// - Integration with AppMotion timing constants
/// - Production-ready with comprehensive error handling
/// - Extensible architecture for future audio-tactile feedback
///
/// Usage:
/// ```dart
/// // Light feedback for subtle interactions
/// await AppHaptics.lightImpact();
///
/// // Medium feedback for button presses
/// await AppHaptics.mediumImpact();
///
/// // Heavy feedback for destructive actions
/// await AppHaptics.heavyImpact();
///
/// // Selection feedback for pickers/toggles
/// await AppHaptics.selectionClick();
/// ```
///
/// Philosophy:
/// Haptic feedback should be subtle and purposeful, never distracting.
/// Each vibration pattern is carefully matched to interaction timing from AppMotion:
/// - Light: micro duration (~150ms perception, matches AppMotion.micro)
/// - Medium: fast duration (~200ms perception, matches AppMotion.fast)
/// - Heavy: normal duration (~300ms perception, matches AppMotion.normal)

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Platform Detection
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Platform categories for haptic feedback support.
enum HapticPlatform {
  /// iOS or Android mobile platforms (full haptic support).
  mobile,

  /// Windows, macOS, Linux desktop platforms (no haptic support).
  desktop,

  /// Web browsers (no haptic support, may support in future).
  web,

  /// Unknown or unsupported platform.
  unsupported,
}

/// Platform detection utilities for haptic feedback.
class HapticPlatformDetector {
  HapticPlatformDetector._();

  /// Returns the current platform category for haptic feedback.
  static HapticPlatform get currentPlatform {
    if (kIsWeb) {
      return HapticPlatform.web;
    }

    try {
      final platform = defaultTargetPlatform;
      switch (platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.android:
          return HapticPlatform.mobile;

        case TargetPlatform.windows:
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
          return HapticPlatform.desktop;

        case TargetPlatform.fuchsia:
          return HapticPlatform.unsupported;
      }
    } catch (e) {
      // Platform detection failed - assume unsupported
      return HapticPlatform.unsupported;
    }
  }

  /// Returns true if the current platform supports haptic feedback.
  static bool get isSupported => currentPlatform == HapticPlatform.mobile;

  /// Returns true if running on iOS.
  static bool get isIOS {
    if (kIsWeb) return false;
    try {
      return defaultTargetPlatform == TargetPlatform.iOS;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if running on Android.
  static bool get isAndroid {
    if (kIsWeb) return false;
    try {
      return defaultTargetPlatform == TargetPlatform.android;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if running on Web.
  static bool get isWeb => kIsWeb;

  /// Returns true if running on desktop (Windows, macOS, Linux).
  static bool get isDesktop {
    return currentPlatform == HapticPlatform.desktop;
  }

  /// Returns a human-readable platform name for debugging.
  static String get platformName {
    switch (currentPlatform) {
      case HapticPlatform.mobile:
        if (isIOS) return 'iOS';
        if (isAndroid) return 'Android';
        return 'Mobile';
      case HapticPlatform.desktop:
        return 'Desktop';
      case HapticPlatform.web:
        return 'Web';
      case HapticPlatform.unsupported:
        return 'Unsupported';
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Haptic Feedback Manager
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Production-ready haptic feedback manager with platform-aware execution.
///
/// All methods are async-safe, null-safe, and include comprehensive error handling.
/// Haptic feedback is automatically disabled on unsupported platforms.
class AppHaptics {
  AppHaptics._();

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Configuration                                                   │
  // └─────────────────────────────────────────────────────────────────┘

  /// Global flag to enable/disable all haptic feedback.
  /// Useful for user preferences or accessibility settings.
  static bool _isEnabled = true;

  /// Returns true if haptic feedback is globally enabled.
  static bool get isEnabled => _isEnabled;

  /// Enable haptic feedback globally.
  static void enable() => _isEnabled = true;

  /// Disable haptic feedback globally.
  static void disable() => _isEnabled = false;

  /// Toggle haptic feedback on/off.
  static void toggle() => _isEnabled = !_isEnabled;

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Core Haptic Methods                                             │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a light haptic feedback.
  ///
  /// **Use cases:**
  /// - Hover enter (desktop hover simulation)
  /// - Focus gain
  /// - Subtle confirmations
  /// - Light UI transitions
  ///
  /// **Intensity:** Subtle, barely noticeable
  /// **Duration perception:** ~150ms (matches AppMotion.micro)
  /// **Platform:** iOS, Android only
  ///
  /// Example:
  /// ```dart
  /// // On hover enter
  /// await AppHaptics.lightImpact();
  /// ```
  static Future<void> lightImpact() async {
    if (!_shouldExecute()) return;

    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      _handleError('lightImpact', e);
    }
  }

  /// Triggers a medium haptic feedback.
  ///
  /// **Use cases:**
  /// - Button presses
  /// - Standard taps
  /// - Confirmation actions
  /// - List item selections
  ///
  /// **Intensity:** Moderate, clearly noticeable
  /// **Duration perception:** ~200ms (matches AppMotion.fast)
  /// **Platform:** iOS, Android only
  ///
  /// Example:
  /// ```dart
  /// // On button tap
  /// await AppHaptics.mediumImpact();
  /// ```
  static Future<void> mediumImpact() async {
    if (!_shouldExecute()) return;

    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      _handleError('mediumImpact', e);
    }
  }

  /// Triggers a heavy haptic feedback.
  ///
  /// **Use cases:**
  /// - Destructive actions (delete, remove)
  /// - Important confirmations (submit, send)
  /// - Long press triggers
  /// - Error states
  ///
  /// **Intensity:** Strong, emphatic
  /// **Duration perception:** ~300ms (matches AppMotion.normal)
  /// **Platform:** iOS, Android only
  ///
  /// Example:
  /// ```dart
  /// // On delete action
  /// await AppHaptics.heavyImpact();
  /// ```
  static Future<void> heavyImpact() async {
    if (!_shouldExecute()) return;

    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      _handleError('heavyImpact', e);
    }
  }

  /// Triggers a selection haptic feedback.
  ///
  /// **Use cases:**
  /// - Picker wheel scrolling
  /// - Segmented control switches
  /// - Toggle changes
  /// - Checkbox state changes
  /// - Radio button selections
  ///
  /// **Intensity:** Sharp, crisp click
  /// **Duration perception:** ~100ms (instantaneous)
  /// **Platform:** iOS, Android only
  ///
  /// Example:
  /// ```dart
  /// // On toggle switch
  /// await AppHaptics.selectionClick();
  /// ```
  static Future<void> selectionClick() async {
    if (!_shouldExecute()) return;

    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      _handleError('selectionClick', e);
    }
  }

  /// Triggers a generic vibration pattern.
  ///
  /// **Use cases:**
  /// - Alerts and warnings
  /// - Error feedback
  /// - Notifications
  /// - Timer/alarm triggers
  ///
  /// **Intensity:** Device-dependent
  /// **Duration perception:** Variable (device-dependent)
  /// **Platform:** iOS, Android only
  ///
  /// Note: Behavior varies significantly across devices.
  /// Consider using specific impact methods for predictable feedback.
  ///
  /// Example:
  /// ```dart
  /// // On error
  /// await AppHaptics.vibrate();
  /// ```
  static Future<void> vibrate() async {
    if (!_shouldExecute()) return;

    try {
      await HapticFeedback.vibrate();
    } catch (e) {
      _handleError('vibrate', e);
    }
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Private Helpers                                                 │
  // └─────────────────────────────────────────────────────────────────┘

  /// Checks if haptic feedback should be executed.
  static bool _shouldExecute() {
    // Check global enable flag
    if (!_isEnabled) return false;

    // Check platform support
    if (!HapticPlatformDetector.isSupported) return false;

    return true;
  }

  /// Handles errors from haptic feedback execution.
  /// Silently ignores errors to prevent crashes on unsupported devices.
  static void _handleError(String method, Object error) {
    // In production, errors are silently ignored to prevent crashes.
    // In debug mode, you can optionally log errors:
    // debugPrint('AppHaptics.$method failed: $error');

    // Errors are expected on:
    // - Emulators without haptic simulation
    // - Devices with disabled haptic settings
    // - Unsupported hardware
    // - Platform API changes
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Future Expansion Hooks                                          │
  // └─────────────────────────────────────────────────────────────────┘

  // TODO: Phase 3.3.2 - Semantic Haptic Patterns
  // Add semantic methods like:
  // - success()
  // - error()
  // - warning()
  // - notification()

  // TODO: Phase 3.4 - Audio-Tactile Integration
  // Integrate with AppSound layer for synchronized audio + haptic feedback:
  // - playWithHaptic(soundId, hapticPattern)
  // - successWithSound()
  // - errorWithSound()

  // TODO: Phase 3.5 - Custom Patterns (Advanced)
  // Support for custom vibration patterns on Android:
  // - customPattern(List<int> timings)
  // - iOS: Map patterns to closest standard haptic
}
