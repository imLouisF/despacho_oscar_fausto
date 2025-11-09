/// Animated Background — Phase 7.1
///
/// Animated gradient background with dynamic blur and subtle parallax motion.
/// Provides premium "Purple Jurídico" branding with smooth, calm animations.
///
/// Example:
/// ```dart
/// AnimatedGradientBackground(
///   child: YourContentWidget(),
/// )
/// ```
library;

import 'dart:ui';
import 'package:flutter/material.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ANIMATED GRADIENT BACKGROUND
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Animated gradient background with Purple Jurídico branding.
///
/// Features:
/// - 16-second animation cycle with smooth easing
/// - Dynamic blur layer for depth
/// - Light/dark mode adaptive gradients
/// - Subtle parallax-like movement
/// - Optimized for performance (no rebuilds on scroll)
class AnimatedGradientBackground extends StatefulWidget {
  /// Child widget to display over the background
  final Widget child;

  /// Whether to enable blur effect (default: true)
  final bool enableBlur;

  /// Blur intensity (sigmaX/Y) - default: 10.0
  final double blurIntensity;

  /// Whether to enable parallax animation (default: true)
  final bool enableAnimation;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.enableBlur = true,
    this.blurIntensity = 10.0,
    this.enableAnimation = true,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create 16-second animation cycle
    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    );

    // Smooth easing curve
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    // Start infinite loop
    if (widget.enableAnimation) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Stack(
      children: [
        // Animated gradient layer
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: _buildGradient(isDark, _animation.value),
              ),
            );
          },
        ),

        // Blur layer for depth
        if (widget.enableBlur)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurIntensity,
              sigmaY: widget.blurIntensity,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),

        // Content
        widget.child,
      ],
    );
  }

  /// Builds animated gradient with parallax effect
  LinearGradient _buildGradient(bool isDark, double animationValue) {
    // Calculate parallax offset (-0.2 to +0.2)
    final offset = (animationValue - 0.5) * 0.4;

    if (isDark) {
      // Dark mode: Deep purple to indigo
      return LinearGradient(
        colors: const [
          Color(0xFF311B92), // Deep Purple 900
          Color(0xFF1A237E), // Indigo 900
        ],
        begin: Alignment(
          -1.0 + offset,
          -1.0 + offset * 0.5,
        ),
        end: Alignment(
          1.0 - offset,
          1.0 - offset * 0.5,
        ),
      );
    } else {
      // Light mode: Purple to deep purple
      return LinearGradient(
        colors: const [
          Color(0xFF7E57C2), // Purple 400
          Color(0xFF512DA8), // Deep Purple 700
        ],
        begin: Alignment(
          -1.0 + offset,
          -1.0 + offset * 0.5,
        ),
        end: Alignment(
          1.0 - offset,
          1.0 - offset * 0.5,
        ),
      );
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// STATIC GRADIENT BACKGROUND
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Static version of gradient background (no animation).
///
/// Use this for performance-critical screens or when animation is not desired.
class StaticGradientBackground extends StatelessWidget {
  /// Child widget to display over the background
  final Widget child;

  /// Whether to enable blur effect (default: true)
  final bool enableBlur;

  /// Blur intensity (sigmaX/Y) - default: 10.0
  final double blurIntensity;

  const StaticGradientBackground({
    super.key,
    required this.child,
    this.enableBlur = true,
    this.blurIntensity = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Stack(
      children: [
        // Static gradient layer
        Container(
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
        ),

        // Blur layer for depth
        if (enableBlur)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurIntensity,
              sigmaY: blurIntensity,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),

        // Content
        child,
      ],
    );
  }
}
