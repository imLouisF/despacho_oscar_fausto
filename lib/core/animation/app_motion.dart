import 'package:flutter/material.dart';

/// AppMotion - Centralized motion system for consistent animations
/// 
/// Provides standardized durations and curves for all UI transitions.
/// Ensures "alive but sober" motion - fluid, precise, without exaggeration.
/// 
/// Philosophy:
/// - Fast: Quick feedback and micro-interactions
/// - Normal: Standard transitions and page changes
/// - Slow: Complex animations and emphasized movements
/// 
/// Usage:
/// ```dart
/// AnimatedContainer(
///   duration: AppMotion.normal,
///   curve: AppCurves.smooth,
/// )
/// ```
class AppMotion {
  // Private constructor
  AppMotion._();

  // ==================== Duration System ====================
  
  /// Fast motion - Quick feedback (200ms)
  /// Use for: Button press, toggle, hover states
  static const Duration fast = Duration(milliseconds: 200);

  /// Normal motion - Standard transitions (300ms)
  /// Use for: Page transitions, container changes, fades
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow motion - Emphasized movements (400ms)
  /// Use for: Complex animations, hero transitions, onboarding
  static const Duration slow = Duration(milliseconds: 400);

  /// Micro motion - Instant feedback (150ms)
  /// Use for: Ripples, tap feedback, very subtle changes
  static const Duration micro = Duration(milliseconds: 150);

  /// Extended motion - Dramatic effects (600ms)
  /// Use for: Modal presentations, splash screens
  static const Duration extended = Duration(milliseconds: 600);

  // ==================== Curve System ====================
  
  /// Default curve - Smooth acceleration/deceleration
  static const Curve defaultCurve = Curves.easeInOutCubic;
}

/// AppCurves - Semantic curve definitions for specific contexts
/// 
/// Provides meaningful names for curves based on their use case.
/// All curves are designed for natural, organic motion feel.
class AppCurves {
  // Private constructor
  AppCurves._();

  // ==================== Standard Curves ====================
  
  /// Smooth curve - Standard easing for most transitions
  /// Symmetric acceleration and deceleration
  static const Curve smooth = Curves.easeInOutCubic;

  /// Sharp curve - Crisp, decisive movements
  /// Quick acceleration, smooth landing
  static const Curve sharp = Curves.easeOutQuint;

  /// Gentle curve - Subtle, delicate transitions
  /// Slow start, gentle finish
  static const Curve gentle = Curves.easeInOutSine;

  /// Elastic curve - Playful, spring-like motion
  /// Slight overshoot for emphasis
  static const Curve elastic = Curves.easeOutBack;

  /// Bounce curve - Energetic, attention-grabbing
  /// For success states and celebrations
  static const Curve bounce = Curves.elasticOut;

  // ==================== Directional Curves ====================
  
  /// Enter curve - Objects coming into view
  /// Strong deceleration for settling effect
  static const Curve enter = Curves.easeOut;

  /// Exit curve - Objects leaving view
  /// Quick acceleration for smooth departure
  static const Curve exit = Curves.easeIn;

  /// Emphasized enter - Dramatic entrances
  static const Curve emphasizedEnter = Curves.easeOutExpo;

  /// Emphasized exit - Dramatic exits
  static const Curve emphasizedExit = Curves.easeInExpo;

  // ==================== Specialized Curves ====================
  
  /// Spring curve - Natural physics simulation
  /// For draggable elements and interactive objects
  static const Curve spring = Curves.elasticOut;

  /// Linear curve - No easing
  /// For loading indicators and continuous progress
  static const Curve linear = Curves.linear;

  /// Decelerate curve - Fast start, slow end
  /// For scroll-to-top and reveal animations
  static const Curve decelerate = Curves.decelerate;

  /// Accelerate curve - Slow start, fast end
  /// For dismissal animations
  static const Curve accelerate = Curves.easeIn;
}

/// AppTransitions - Pre-configured transition builders
/// 
/// Provides ready-to-use transition effects for common scenarios.
/// Ensures visual consistency across navigation and state changes.
class AppTransitions {
  // Private constructor
  AppTransitions._();

  /// Fade transition builder
  /// Smooth opacity change for overlays and content switches
  static Widget fade({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale fade transition builder
  /// Combined scale and fade for modal presentations
  static Widget scaleFade({
    required Animation<double> animation,
    required Widget child,
    double initialScale = 0.95,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: initialScale,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: AppCurves.smooth,
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// Slide fade transition builder
  /// Directional entry with fade for drawers and panels
  static Widget slideFade({
    required Animation<double> animation,
    required Widget child,
    Offset beginOffset = const Offset(0, 0.03),
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: AppCurves.smooth,
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// Hero-style shared element transition
  /// For seamless navigation between detail views
  static Widget sharedAxis({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.3, 1.0, curve: AppCurves.smooth),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: AppCurves.emphasizedEnter,
          ),
        ),
        child: child,
      ),
    );
  }
}

/// Motion utility helpers
/// 
/// Provides convenience methods for common motion patterns.
extension MotionHelpers on Widget {
  /// Wraps widget with animated opacity
  Widget fadeIn({
    required bool visible,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: duration ?? AppMotion.normal,
      curve: curve ?? AppCurves.smooth,
      child: this,
    );
  }

  /// Wraps widget with animated scale
  Widget scaleIn({
    required bool visible,
    Duration? duration,
    Curve? curve,
  }) {
    return AnimatedScale(
      scale: visible ? 1.0 : 0.95,
      duration: duration ?? AppMotion.normal,
      curve: curve ?? AppCurves.smooth,
      child: this,
    );
  }
}
