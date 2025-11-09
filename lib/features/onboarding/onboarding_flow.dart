/// Onboarding Flow — Phase 8.1
///
/// Apple-style setup experience with Purple Jurídico brand aesthetics.
/// Features smooth Cupertino transitions, gradient backgrounds, and Spanish localization.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   CupertinoPageRoute(builder: (_) => OnboardingFlow()),
/// );
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/ui_components/ui_components_index.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ONBOARDING STRINGS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Centralized Spanish strings for onboarding flow.
class AppOnboardingStrings {
  AppOnboardingStrings._();

  // Step 1: Welcome
  static const String welcomeTitle = 'Bienvenido a Purple Jurídico';
  static const String welcomeSubtitle = 'Tu despacho digital comienza aquí.';

  // Step 2: Organization
  static const String organizationTitle = 'Organiza tus casos';
  static const String organizationSubtitle =
      'Mantén control profesional y precisión diaria.';

  // Step 3: Communication
  static const String communicationTitle = 'Conecta con tus clientes';
  static const String communicationSubtitle =
      'Mensajería y gestión simplificada.';

  // Step 4: Ready
  static const String readyTitle = 'Listo para comenzar';
  static const String readySubtitle = 'Tu espacio jurídico está preparado.';

  // Navigation
  static const String nextButton = 'Siguiente';
  static const String skipButton = 'Saltar';
  static const String startButton = 'Comenzar';
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ONBOARDING FLOW
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Main onboarding flow widget with multi-step progression.
///
/// Features:
/// - 4 sequential screens with smooth transitions
/// - Purple→Indigo gradient backgrounds
/// - Cupertino-style navigation
/// - Adaptive layout (mobile/tablet)
/// - Dark mode support
class OnboardingFlow extends StatefulWidget {
  /// Callback when onboarding is completed
  final VoidCallback? onComplete;

  const OnboardingFlow({
    super.key,
    this.onComplete,
  });

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _fadeController;
  int _currentPage = 0;

  final List<OnboardingStepData> _steps = [
    OnboardingStepData(
      icon: CupertinoIcons.briefcase_fill,
      title: AppOnboardingStrings.welcomeTitle,
      subtitle: AppOnboardingStrings.welcomeSubtitle,
    ),
    OnboardingStepData(
      icon: CupertinoIcons.doc_text_fill,
      title: AppOnboardingStrings.organizationTitle,
      subtitle: AppOnboardingStrings.organizationSubtitle,
    ),
    OnboardingStepData(
      icon: CupertinoIcons.person_crop_circle_badge_checkmark,
      title: AppOnboardingStrings.communicationTitle,
      subtitle: AppOnboardingStrings.communicationSubtitle,
    ),
    OnboardingStepData(
      icon: CupertinoIcons.checkmark_shield_fill,
      title: AppOnboardingStrings.readyTitle,
      subtitle: AppOnboardingStrings.readySubtitle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    } else {
      _complete();
    }
  }

  void _skip() {
    _complete();
  }

  void _complete() {
    widget.onComplete?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Gradient background
          _buildGradientBackground(isDark),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Skip button
                if (_currentPage < _steps.length - 1)
                  _buildSkipButton(isDark),

                // Page view
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _steps.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _fadeController,
                        child: OnboardingStep(
                          data: _steps[index],
                          isDark: isDark,
                        ),
                      );
                    },
                  ),
                ),

                // Page indicators
                _buildPageIndicators(isDark),

                const SizedBox(height: AppSpacing.spacing24),

                // Navigation button
                _buildNavigationButton(isDark),

                const SizedBox(height: AppSpacing.spacing32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds animated gradient background
  Widget _buildGradientBackground(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                colors: [
                  Color(0xFF311B92), // Deep Purple 900
                  Color(0xFF1A237E), // Indigo 900
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  Color(0xFF7E57C2), // Purple 400
                  Color(0xFF512DA8), // Deep Purple 700
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
    );
  }

  /// Builds skip button in top-right
  Widget _buildSkipButton(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: AppSpacing.spacing8,
            ),
            onPressed: _skip,
            child: Text(
              AppOnboardingStrings.skipButton,
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds animated page indicator dots
  Widget _buildPageIndicators(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _steps.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
        ),
      ),
    );
  }

  /// Builds main navigation button
  Widget _buildNavigationButton(bool isDark) {
    final isLastPage = _currentPage == _steps.length - 1;
    final buttonText =
        isLastPage ? AppOnboardingStrings.startButton : AppOnboardingStrings.nextButton;

    return Padding(
      padding: AppLayout.screenEdges,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing16,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        onPressed: _nextPage,
        child: Center(
          child: Text(
            buttonText,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ONBOARDING STEP
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Individual onboarding step screen.
///
/// Features:
/// - Large icon with glow effect
/// - Title and subtitle text
/// - Responsive layout (mobile/tablet)
/// - Fade-in animation
class OnboardingStep extends StatelessWidget {
  final OnboardingStepData data;
  final bool isDark;

  const OnboardingStep({
    super.key,
    required this.data,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= AppLayout.breakpointMobile;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.getResponsiveHorizontal(screenWidth),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with glow
          _buildIcon(),

          SizedBox(height: isTablet ? AppSpacing.spacing64 : AppSpacing.spacing48),

          // Title
          Text(
            data.title,
            style: (isTablet
                    ? AppTypography.headlineLarge
                    : AppTypography.headlineMedium)
                .copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.spacing16),

          // Subtitle
          Text(
            data.subtitle,
            style: (isTablet
                    ? AppTypography.titleLarge
                    : AppTypography.bodyLarge)
                .copyWith(
              color: Colors.white.withOpacity(0.85),
              height: 1.5,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds icon with shadow glow effect
  Widget _buildIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 32,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Icon(
        data.icon,
        size: 64,
        color: Colors.white,
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ONBOARDING STEP DATA
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Data model for onboarding step content.
class OnboardingStepData {
  final IconData icon;
  final String title;
  final String subtitle;

  const OnboardingStepData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ONBOARDING CONTROLLER (OPTIONAL)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Controller for managing onboarding state (for advanced usage).
///
/// Can be used with Provider/Riverpod for state management across app.
class OnboardingController extends ChangeNotifier {
  int _currentPage = 0;
  bool _isComplete = false;

  int get currentPage => _currentPage;
  bool get isComplete => _isComplete;

  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void complete() {
    _isComplete = true;
    notifyListeners();
  }

  void reset() {
    _currentPage = 0;
    _isComplete = false;
    notifyListeners();
  }
}
