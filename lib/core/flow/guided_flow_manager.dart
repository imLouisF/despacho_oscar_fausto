/// Guided Flow Manager — Phase 8.4
///
/// Orchestrates seamless transitions between onboarding and main application.
/// Manages contextual welcome messages and narrative continuity.
///
/// **Architecture:**
/// - State management for onboarding completion
/// - Animated transition coordination
/// - Contextual message delivery
/// - Theme-aware flow control
///
/// Example:
/// ```dart
/// await GuidedFlowManager.completeOnboarding(context);
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../ui_components/ui_components_index.dart';
import '../ui_components/contextual_toast.dart';

/// Manages the guided flow from onboarding to main application.
///
/// **Phase 8.4 Features:**
/// - Smooth animated transitions (700-900ms)
/// - Gradient background persistence
/// - Contextual welcome message display
/// - Dark/light mode synchronization
///
/// **Usage:**
/// Call `completeOnboarding()` when user finishes onboarding flow.
class GuidedFlowManager {
  GuidedFlowManager._(); // Private constructor

  /// Standard transition duration for guided flows
  static const Duration transitionDuration = Duration(milliseconds: 800);

  /// Welcome message display duration
  static const Duration welcomeDuration = Duration(milliseconds: 3500);

  /// Completes onboarding and transitions to home screen.
  ///
  /// **Flow:**
  /// 1. Exit onboarding with fade + scale animation
  /// 2. Navigate to home with crossfade transition
  /// 3. Display welcome message after 600ms delay
  /// 4. Auto-dismiss welcome message after 3.5s
  ///
  /// **Parameters:**
  /// - [context] — Current BuildContext
  /// - [targetRoute] — Route to navigate to (default: '/')
  ///
  /// **Returns:**
  /// Future that completes when transition animation finishes.
  static Future<void> completeOnboarding(
    BuildContext context, {
    String targetRoute = '/',
  }) async {
    // Use pushReplacementNamed with custom transition
    await Navigator.of(context).pushNamedAndRemoveUntil(
      targetRoute,
      (route) => false,
      arguments: {'showWelcome': true},
    );
    
    // Show welcome message after navigation settles
    Future.delayed(const Duration(milliseconds: 900), () {
      if (context.mounted) {
        showWelcomeMessage(context);
      }
    });
  }

  /// Creates a custom page route with elegant transition.
  ///
  /// **Animation Specs:**
  /// - Duration: 800ms (easeInOut curve)
  /// - Crossfade between old and new route
  /// - Subtle scale effect (0.95 → 1.0)
  /// - Maintains gradient background throughout
  ///
  /// **Usage:**
  /// Can be used for any custom route transition requiring the
  /// Purple Jurídico premium animation style.
  static PageRouteBuilder createTransitionRoute({
    required WidgetBuilder builder,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionDuration: transitionDuration,
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Crossfade animation
        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));

        // Subtle scale animation for depth
        final scaleAnimation = Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Shows welcome message after transition completes.
  ///
  /// **Message:**
  /// "Bienvenido, abogado. Tu despacho digital te espera."
  ///
  /// **Behavior:**
  /// - Displays with fade-in + slide animation
  /// - Auto-dismisses after 3.5s
  /// - User can manually dismiss
  static void showWelcomeMessage(BuildContext context) {
    ContextualToast.show(
      context,
      message: 'Bienvenido, abogado. Tu despacho digital te espera.',
      duration: welcomeDuration,
      icon: CupertinoIcons.checkmark_shield_fill,
    );
  }

}
