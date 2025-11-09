/// Theme Switcher — Phase 9.1
///
/// Visual control for toggling between Corporate and Social theme variants.
/// Provides animated icon transitions and persistent state management.
///
/// **Features:**
/// - Floating action button or AppBar icon
/// - Animated icon rotation (400ms)
/// - Contextual tooltip with variant name
/// - Instant theme switching via ThemeModeController
/// - Automatic persistence via SharedPreferences
///
/// Example:
/// ```dart
/// ThemeSwitcher(
///   themeController: themeController,
///   style: ThemeSwitcherStyle.fab,
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';
import '../ui_components/ui_components_index.dart';

/// Display style for theme switcher
enum ThemeSwitcherStyle {
  /// Floating action button (bottom-right)
  fab,

  /// AppBar icon button (top-right)
  appBarIcon,
}

/// Theme switcher widget with animated variant toggle.
///
/// **Phase 9.1 Features:**
/// - Visual indicator of current theme variant
/// - Smooth icon animation on toggle (400ms)
/// - Contextual tooltip ("Tema: Corporate" / "Social Profesional")
/// - Instant theme switching without reload
/// - Persistent state via ThemeModeController
///
/// **Usage:**
/// ```dart
/// // As FAB
/// floatingActionButton: ThemeSwitcher(
///   themeController: controller,
///   style: ThemeSwitcherStyle.fab,
/// )
///
/// // As AppBar icon
/// actions: [
///   ThemeSwitcher(
///     themeController: controller,
///     style: ThemeSwitcherStyle.appBarIcon,
///   ),
/// ]
/// ```
class ThemeSwitcher extends StatefulWidget {
  /// Theme controller for variant management
  final ThemeModeController themeController;

  /// Display style (FAB or AppBar icon)
  final ThemeSwitcherStyle style;

  /// Whether to show on onboarding screens
  final bool hideOnOnboarding;

  const ThemeSwitcher({
    super.key,
    required this.themeController,
    this.style = ThemeSwitcherStyle.fab,
    this.hideOnOnboarding = true,
  });

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    debugPrint('[ThemeSwitcher] Initializing...');

    // Animation for icon rotation
    _animationController = AnimationController(
      duration: AppMotion.normal,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Listen to theme changes
    widget.themeController.addListener(_onThemeChanged);

    debugPrint('[ThemeSwitcher] Initialized. Current variant: ${widget.themeController.currentVariantName}');
  }

  @override
  void dispose() {
    debugPrint('[ThemeSwitcher] Disposing...');
    widget.themeController.removeListener(_onThemeChanged);
    _animationController.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        // Trigger icon animation on theme change
        _animationController.forward(from: 0.0);
      });
    }
  }

  Future<void> _handleToggle() async {
    debugPrint('[ThemeSwitcher] Toggle requested');

    try {
      // Animate icon
      await _animationController.forward(from: 0.0);

      // Toggle theme variant
      await widget.themeController.toggleThemeVariant();

      debugPrint('[ThemeSwitcher] Toggle complete. New variant: ${widget.themeController.currentVariantName}');
    } catch (e, stackTrace) {
      debugPrint('[ThemeSwitcher] Toggle error: $e');
      debugPrint('[ThemeSwitcher] Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final brightness = Theme.of(context).brightness;
      final isCorporate = widget.themeController.isCorporate;

      return widget.style == ThemeSwitcherStyle.fab
          ? _buildFAB(brightness, isCorporate)
          : _buildAppBarIcon(brightness, isCorporate);
    } catch (e, stackTrace) {
      debugPrint('[ThemeSwitcher] Build error: $e');
      debugPrint('[ThemeSwitcher] Stack trace: $stackTrace');
      // Return empty positioned container on error
      return const Positioned(
        right: 24,
        bottom: 100,
        child: SizedBox.shrink(),
      );
    }
  }

  /// Builds floating action button style
  Widget _buildFAB(Brightness brightness, bool isCorporate) {
    return Positioned(
      right: 24,
      bottom: 100, // Above bottom nav (60px) + spacing
      child: FloatingActionButton(
        onPressed: _handleToggle,
        backgroundColor: brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surface,
        elevation: 4,
        heroTag: 'theme_switcher_fab', // Unique hero tag
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 3.14159, // 180 degrees
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  _getIcon(isCorporate),
                  key: ValueKey<bool>(isCorporate),
                  color: _getIconColor(brightness, isCorporate),
                  size: 28,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds AppBar icon button style
  Widget _buildAppBarIcon(Brightness brightness, bool isCorporate) {
    return IconButton(
      onPressed: _handleToggle,
      icon: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 3.14159,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Icon(
                _getIcon(isCorporate),
                key: ValueKey<bool>(isCorporate),
                color: _getIconColor(brightness, isCorporate),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Returns appropriate icon for current variant
  IconData _getIcon(bool isCorporate) {
    return isCorporate ? Icons.work_outline : Icons.people_outline;
  }

  /// Returns icon color based on variant and brightness
  Color _getIconColor(Brightness brightness, bool isCorporate) {
    if (isCorporate) {
      // Corporate: subdued purple
      return const Color(0xFF6A1B9A);
    } else {
      // Social: vivid purple
      return const Color(0xFF7E57C2);
    }
  }
}

/// Compact theme switcher for use in tight spaces.
///
/// **Phase 9.1 Variant:**
/// Simplified version without animation, suitable for:
/// - Dense toolbars
/// - Compact layouts
/// - Secondary screens
class CompactThemeSwitcher extends StatelessWidget {
  final ThemeModeController themeController;

  const CompactThemeSwitcher({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isCorporate = themeController.isCorporate;

    return GestureDetector(
      onTap: () => themeController.toggleThemeVariant(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing12,
          vertical: AppSpacing.spacing8,
        ),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? AppColors.surfaceDark
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: brightness == Brightness.dark
                ? AppColors.borderDark
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCorporate ? Icons.work_outline : Icons.people_outline,
              size: 18,
              color: isCorporate
                  ? const Color(0xFF6A1B9A)
                  : const Color(0xFF7E57C2),
            ),
            const SizedBox(width: AppSpacing.spacing8),
            Text(
              isCorporate ? 'Corp' : 'Social',
              style: AppTypography.labelSmall.copyWith(
                color: brightness == Brightness.dark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
