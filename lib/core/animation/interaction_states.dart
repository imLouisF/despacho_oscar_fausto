import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'app_motion.dart';

/// 🎯 Interaction States System
///
/// Provides centralized state management and utilities for interactive UI elements.
/// Manages hover, tap, focus, pressed, active, and disabled states with platform-aware behavior.
///
/// Core Features:
/// - Platform detection (mobile/desktop/web)
/// - Haptic feedback integration
/// - State transition timing
/// - Semantic state models
///
/// Usage:
/// ```dart
/// final stateController = InteractionStateController();
/// AnimatedContainer(
///   scale: stateController.isHovered ? 1.05 : 1.0,
///   duration: InteractionStates.hoverDuration,
/// );
/// ```

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Platform Detection
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Platform detection utilities for adaptive interaction behavior.
class InteractionPlatform {
  InteractionPlatform._();

  /// Returns true if running on desktop (Windows, macOS, Linux, or Web).
  static bool get isDesktop {
    if (kIsWeb) return true;
    try {
      return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if running on mobile (iOS or Android).
  static bool get isMobile {
    if (kIsWeb) return false;
    try {
      return Platform.isIOS || Platform.isAndroid;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if hover effects should be enabled (desktop/web only).
  static bool get supportsHover => isDesktop;

  /// Returns true if haptic feedback is available (mobile only).
  static bool get supportsHaptics => isMobile;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Haptic Feedback Manager
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Haptic feedback utilities with platform-aware execution.
class AppHaptics {
  AppHaptics._();

  /// Light haptic feedback for subtle interactions (hover, focus).
  /// Executes only on mobile platforms.
  static Future<void> light() async {
    if (InteractionPlatform.supportsHaptics) {
      await HapticFeedback.lightImpact();
    }
  }

  /// Medium haptic feedback for standard interactions (tap, button press).
  /// Executes only on mobile platforms.
  static Future<void> medium() async {
    if (InteractionPlatform.supportsHaptics) {
      await HapticFeedback.mediumImpact();
    }
  }

  /// Heavy haptic feedback for emphasized interactions (delete, submit).
  /// Executes only on mobile platforms.
  static Future<void> heavy() async {
    if (InteractionPlatform.supportsHaptics) {
      await HapticFeedback.heavyImpact();
    }
  }

  /// Selection haptic feedback for discrete changes (toggle, picker).
  /// Executes only on mobile platforms.
  static Future<void> selection() async {
    if (InteractionPlatform.supportsHaptics) {
      await HapticFeedback.selectionClick();
    }
  }

  /// Vibrate for error or warning feedback.
  /// Executes only on mobile platforms.
  static Future<void> vibrate() async {
    if (InteractionPlatform.supportsHaptics) {
      await HapticFeedback.vibrate();
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Interaction State Constants
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Centralized timing and scale constants for interaction states.
/// Synced with AppMotion and AppCurves for visual consistency.
class InteractionStates {
  InteractionStates._();

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Durations                                                       │
  // └─────────────────────────────────────────────────────────────────┘

  /// Duration for hover state transitions (desktop/web).
  static const Duration hoverDuration = AppMotion.fast; // 200ms

  /// Duration for tap feedback animations.
  static const Duration tapDuration = AppMotion.micro; // 150ms

  /// Duration for focus state transitions.
  static const Duration focusDuration = AppMotion.normal; // 300ms

  /// Duration for active/pressed state transitions.
  static const Duration pressedDuration = AppMotion.micro; // 150ms

  /// Duration for disabled state transitions.
  static const Duration disabledDuration = AppMotion.normal; // 300ms

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Curves                                                          │
  // └─────────────────────────────────────────────────────────────────┘

  /// Curve for hover transitions (smooth and subtle).
  static const Curve hoverCurve = AppCurves.smooth; // easeInOutCubic

  /// Curve for tap feedback (quick and responsive).
  static const Curve tapCurve = AppCurves.sharp; // easeOutQuint

  /// Curve for focus transitions (gentle emphasis).
  static const Curve focusCurve = AppCurves.gentle; // easeInOutSine

  /// Curve for pressed state (instant response).
  static const Curve pressedCurve = AppCurves.sharp; // easeOutQuint

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Scale & Transform                                               │
  // └─────────────────────────────────────────────────────────────────┘

  /// Scale factor for hover state (subtle lift).
  static const double hoverScale = 1.02;

  /// Scale factor for pressed state (subtle press down).
  static const double pressedScale = 0.97;

  /// Scale factor for tap feedback (brief shrink).
  static const double tapScale = 0.95;

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Opacity & Visual Effects                                        │
  // └─────────────────────────────────────────────────────────────────┘

  /// Opacity for hover overlay effect.
  static const double hoverOverlayOpacity = 0.05;

  /// Opacity for pressed/active state overlay.
  static const double pressedOverlayOpacity = 0.10;

  /// Opacity for disabled state.
  static const double disabledOpacity = 0.40;

  /// Shadow elevation increase on hover (logical pixels).
  static const double hoverElevationDelta = 4.0;

  /// Border width for focus/active state indicators.
  static const double focusBorderWidth = 2.0;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Interaction State Model
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Immutable model representing the current interaction state of a widget.
@immutable
class InteractionState {
  const InteractionState({
    this.isHovered = false,
    this.isPressed = false,
    this.isFocused = false,
    this.isActive = false,
    this.isDisabled = false,
  });

  /// Widget is being hovered (desktop/web only).
  final bool isHovered;

  /// Widget is currently pressed/tapped.
  final bool isPressed;

  /// Widget has keyboard focus.
  final bool isFocused;

  /// Widget is in active/selected state (e.g., selected tab).
  final bool isActive;

  /// Widget is disabled (no interactions).
  final bool isDisabled;

  /// Returns true if any interactive state is active (excluding disabled).
  bool get isInteracting =>
      !isDisabled && (isHovered || isPressed || isFocused || isActive);

  /// Returns the most appropriate scale based on current state.
  double get scale {
    if (isDisabled) return 1.0;
    if (isPressed) return InteractionStates.pressedScale;
    if (isHovered) return InteractionStates.hoverScale;
    return 1.0;
  }

  /// Returns the overlay opacity based on current state.
  double get overlayOpacity {
    if (isDisabled) return 0.0;
    if (isPressed) return InteractionStates.pressedOverlayOpacity;
    if (isHovered) return InteractionStates.hoverOverlayOpacity;
    return 0.0;
  }

  /// Returns the overall opacity including disabled state.
  double get opacity {
    return isDisabled ? InteractionStates.disabledOpacity : 1.0;
  }

  /// Creates a copy with modified values.
  InteractionState copyWith({
    bool? isHovered,
    bool? isPressed,
    bool? isFocused,
    bool? isActive,
    bool? isDisabled,
  }) {
    return InteractionState(
      isHovered: isHovered ?? this.isHovered,
      isPressed: isPressed ?? this.isPressed,
      isFocused: isFocused ?? this.isFocused,
      isActive: isActive ?? this.isActive,
      isDisabled: isDisabled ?? this.isDisabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InteractionState &&
          runtimeType == other.runtimeType &&
          isHovered == other.isHovered &&
          isPressed == other.isPressed &&
          isFocused == other.isFocused &&
          isActive == other.isActive &&
          isDisabled == other.isDisabled;

  @override
  int get hashCode =>
      isHovered.hashCode ^
      isPressed.hashCode ^
      isFocused.hashCode ^
      isActive.hashCode ^
      isDisabled.hashCode;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🔹 Interaction State Controller
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Controller for managing widget interaction states with ValueNotifier.
///
/// Usage:
/// ```dart
/// final controller = InteractionStateController();
/// ValueListenableBuilder<InteractionState>(
///   valueListenable: controller,
///   builder: (context, state, child) {
///     return AnimatedContainer(
///       transform: Matrix4.identity()..scale(state.scale),
///       duration: InteractionStates.hoverDuration,
///       child: child,
///     );
///   },
/// );
/// ```
class InteractionStateController extends ValueNotifier<InteractionState> {
  InteractionStateController({
    bool isActive = false,
    bool isDisabled = false,
  }) : super(InteractionState(isActive: isActive, isDisabled: isDisabled));

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ State Getters                                                   │
  // └─────────────────────────────────────────────────────────────────┘

  bool get isHovered => value.isHovered;
  bool get isPressed => value.isPressed;
  bool get isFocused => value.isFocused;
  bool get isActive => value.isActive;
  bool get isDisabled => value.isDisabled;
  bool get isInteracting => value.isInteracting;

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ State Setters                                                   │
  // └─────────────────────────────────────────────────────────────────┘

  void setHovered(bool hovered) {
    if (isDisabled || !InteractionPlatform.supportsHover) return;
    value = value.copyWith(isHovered: hovered);
    if (hovered) AppHaptics.light(); // Subtle haptic on hover start
  }

  void setPressed(bool pressed) {
    if (isDisabled) return;
    value = value.copyWith(isPressed: pressed);
    if (pressed) AppHaptics.medium(); // Medium haptic on press
  }

  void setFocused(bool focused) {
    if (isDisabled) return;
    value = value.copyWith(isFocused: focused);
    if (focused) AppHaptics.selection(); // Selection haptic on focus
  }

  void setActive(bool active) {
    value = value.copyWith(isActive: active);
  }

  void setDisabled(bool disabled) {
    value = value.copyWith(isDisabled: disabled);
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Event Handlers                                                  │
  // └─────────────────────────────────────────────────────────────────┘

  void onHoverEnter() => setHovered(true);
  void onHoverExit() => setHovered(false);

  void onTapDown() => setPressed(true);
  void onTapUp() => setPressed(false);
  void onTapCancel() => setPressed(false);

  void onFocusGain() => setFocused(true);
  void onFocusLoss() => setFocused(false);

  /// Triggers tap feedback with haptic and brief visual state change.
  Future<void> triggerTapFeedback() async {
    if (isDisabled) return;
    await AppHaptics.medium();
    setPressed(true);
    await Future.delayed(InteractionStates.tapDuration);
    setPressed(false);
  }

  /// Resets all transient states (hover, pressed, focused).
  void reset() {
    value = value.copyWith(
      isHovered: false,
      isPressed: false,
      isFocused: false,
    );
  }
}
