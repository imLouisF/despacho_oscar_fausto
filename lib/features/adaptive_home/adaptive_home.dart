/// Adaptive Home — Phase 9.1.2
///
/// Smart home screen wrapper that switches between Corporate and Social layouts
/// based on the current theme variant.
///
/// **Architecture:**
/// - Corporate variant → Traditional HomeScreen (grid cards, bottom nav)
/// - Social variant → SocialModule (feed/profile tabs, modern UI)
///
/// **Integration:**
/// ```dart
/// MaterialApp(
///   routes: {
///     '/': (context) => const AdaptiveHome(userName: 'Oscar Fausto'),
///   },
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../../core/theme/theme_controller.dart';
import '../../screens/home/home_screen.dart';
import '../../features/social/social_module.dart';
import '../../app.dart'; // For ThemeControllerProvider

/// Adaptive home screen that switches layout based on theme variant.
///
/// **Phase 9.1.2 Enhancement:**
/// Dynamically renders Corporate or Social layout based on ThemeModeController state.
/// Rebuilds automatically when theme variant changes via AnimatedSwitcher.
///
/// **Layouts:**
/// - **Corporate Mode:** Traditional grid-based HomeScreen
/// - **Social Mode:** Feed-based SocialModule
class AdaptiveHome extends StatelessWidget {
  /// User name to pass to social module
  final String userName;

  /// Optional user ID
  final String? userId;

  const AdaptiveHome({
    super.key,
    required this.userName,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Access theme controller from context
    final themeController = ThemeControllerProvider.of(context);

    // Phase 9.1.2: Log rebuild events
    debugPrint('[AdaptiveHome] Building with variant: ${themeController?.currentVariantName ?? "unknown"}');

    // If controller not available, fallback to social
    if (themeController == null) {
      debugPrint('[AdaptiveHome] ⚠️ ThemeController not found, using Social layout');
      return SocialModule(userName: userName, userId: userId);
    }

    // Listen to theme changes with AnimatedBuilder
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        final isCorporate = themeController.isCorporate;

        debugPrint('[AdaptiveHome] Rebuild triggered. isCorporate: $isCorporate');

        // Phase 9.1.2: Smooth layout transition
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Fade + scale transition for smooth layout swap
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: isCorporate
              ? _buildCorporateLayout(context)
              : _buildSocialLayout(context),
        );
      },
    );
  }

  /// Builds Corporate layout (traditional grid-based home)
  Widget _buildCorporateLayout(BuildContext context) {
    debugPrint('[AdaptiveHome] 🏢 Rendering Corporate Layout');

    return const HomeScreen(
      key: ValueKey('corporate_home'),
    );
  }

  /// Builds Social layout (feed-based social module)
  Widget _buildSocialLayout(BuildContext context) {
    debugPrint('[AdaptiveHome] 👥 Rendering Social Layout');

    return SocialModule(
      key: const ValueKey('social_home'),
      userName: userName,
      userId: userId,
    );
  }
}

/// Alternative implementation using ValueListenableBuilder (more efficient)
///
/// **Usage:**
/// ```dart
/// AdaptiveHomeValueListenable(userName: 'Oscar Fausto')
/// ```
class AdaptiveHomeValueListenable extends StatelessWidget {
  final String userName;
  final String? userId;

  const AdaptiveHomeValueListenable({
    super.key,
    required this.userName,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeControllerProvider.of(context);

    if (themeController == null) {
      return SocialModule(userName: userName, userId: userId);
    }

    // More efficient: only rebuilds when currentVariant changes
    return ValueListenableBuilder<AppThemeVariant>(
      valueListenable: themeController.currentVariant,
      builder: (context, variant, child) {
        final isCorporate = variant == AppThemeVariant.corporate;

        debugPrint('[AdaptiveHome] ValueListenable rebuild. Variant: $variant');

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: isCorporate
              ? const HomeScreen(key: ValueKey('corporate_home'))
              : SocialModule(
                  key: const ValueKey('social_home'),
                  userName: userName,
                  userId: userId,
                ),
        );
      },
    );
  }
}
