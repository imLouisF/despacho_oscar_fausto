/// Onboarding Screen — Phase 8.4
///
/// Wrapper screen for OnboardingFlow with guided flow integration.
/// Manages the transition from onboarding to main application.
///
/// **Integration:**
/// - Uses GuidedFlowManager for smooth transitions
/// - Maintains gradient background persistence
/// - Triggers contextual welcome message
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => const OnboardingScreen()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import '../../core/flow/guided_flow_manager.dart';
import '../../core/ui_components/ui_components_index.dart';
import 'onboarding_flow.dart';

/// Onboarding screen with guided flow integration.
///
/// **Phase 8.4 Features:**
/// - Seamless transition to home screen
/// - Gradient background continuity
/// - Contextual welcome message delivery
/// - Dark/light mode synchronization
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: brightness == Brightness.dark
          ? AppColors.backgroundDark
          : AppColors.background,
      body: Stack(
        children: [
          // Animated shimmer background (dark mode only)
          const AnimatedShimmerBackground(
            opacity: 0.2,
          ),

          // Onboarding flow content
          OnboardingFlow(
            onComplete: () => _handleCompletion(context),
          ),
        ],
      ),
    );
  }

  /// Handles onboarding completion with guided flow transition.
  ///
  /// **Flow:**
  /// 1. Triggers GuidedFlowManager.completeOnboarding()
  /// 2. Animates transition to home screen (800ms)
  /// 3. Shows welcome message after 600ms delay
  ///
  /// **Animation:**
  /// - Crossfade with subtle scale (0.95 → 1.0)
  /// - easeInOut curve for professional feel
  /// - Gradient background persists throughout
  Future<void> _handleCompletion(BuildContext context) async {
    await GuidedFlowManager.completeOnboarding(
      context,
      targetRoute: '/', // Navigate to home
    );
  }
}
