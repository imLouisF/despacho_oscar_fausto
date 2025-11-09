/// Animated Shimmer Gradient — Phase 8.3
///
/// Subtle, elegant shimmer effect for Dark Mode Jurídico backgrounds.
/// Provides depth and visual interest without distraction.
///
/// **Design Specs:**
/// - Duration: 2500ms linear pan
/// - Opacity: 0.15–0.25 range
/// - Motion: Gentle horizontal sweep
/// - No flicker or harsh transitions
///
/// Example:
/// ```dart
/// Stack(
///   children: [
///     AnimatedShimmerBackground(),
///     // Your content here
///   ],
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '_theme/ui_tokens.dart';

/// Animated shimmer gradient overlay for premium backgrounds.
///
/// **Phase 8.3 Enhancement:**
/// - Designed for "Dark Mode Jurídico" aesthetic
/// - Conveys depth and sophistication
/// - Complements Purple-Indigo brand gradient
/// - Subtle motion: 2500ms linear cycle
///
/// **Usage:**
/// Place as the bottommost layer in a Stack for background shimmer.
/// Works best on dark surfaces to create depth.
class AnimatedShimmerBackground extends StatefulWidget {
  /// Creates an animated shimmer background.
  ///
  /// [opacity] controls the overall shimmer intensity (0.0–1.0).
  /// [duration] controls the animation cycle speed.
  /// [blur] controls the backdrop blur effect (0 = no blur).
  const AnimatedShimmerBackground({
    super.key,
    this.opacity = 1.0,
    this.duration = const Duration(milliseconds: 2500),
    this.blur = 0.0,
  });

  /// Overall opacity multiplier for shimmer effect.
  /// Defaults to 1.0. Useful for fading in/out shimmer.
  final double opacity;

  /// Animation cycle duration.
  /// Defaults to 2500ms for gentle, calming motion.
  final Duration duration;

  /// Backdrop blur sigma value.
  /// Set to 0 for no blur. Defaults to 0.
  final double blur;

  @override
  State<AnimatedShimmerBackground> createState() =>
      _AnimatedShimmerBackgroundState();
}

class _AnimatedShimmerBackgroundState extends State<AnimatedShimmerBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    
    // Use shimmer gradient only in dark mode
    if (brightness == Brightness.light) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1.0, -0.5),
              end: Alignment(_animation.value + 1.0, 0.5),
              colors: [
                AppColors.shimmerGradientDark.colors[0]
                    .withOpacity(widget.opacity),
                AppColors.shimmerGradientDark.colors[1]
                    .withOpacity(widget.opacity),
                AppColors.shimmerGradientDark.colors[2]
                    .withOpacity(widget.opacity),
              ],
              stops: AppColors.shimmerGradientDark.stops,
            ),
          ),
        );
      },
    );
  }
}

/// Compact shimmer overlay for cards and elevated surfaces.
///
/// Smaller-scale shimmer effect suitable for:
/// - Card backgrounds
/// - Modal sheets
/// - Elevated components
///
/// Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     color: AppColors.cardDark,
///     borderRadius: BorderRadius.circular(AppRadius.lg),
///   ),
///   child: Stack(
///     children: [
///       AnimatedShimmerCard(),
///       // Card content here
///     ],
///   ),
/// )
/// ```
class AnimatedShimmerCard extends StatefulWidget {
  /// Creates a card-scale shimmer effect.
  ///
  /// [opacity] controls shimmer intensity.
  /// [duration] controls animation speed.
  const AnimatedShimmerCard({
    super.key,
    this.opacity = 0.5,
    this.duration = const Duration(milliseconds: 3000),
  });

  /// Shimmer opacity (0.0–1.0).
  /// Lower values recommended for cards (default: 0.5).
  final double opacity;

  /// Animation cycle duration.
  /// Slightly slower than background shimmer (default: 3000ms).
  final Duration duration;

  @override
  State<AnimatedShimmerCard> createState() => _AnimatedShimmerCardState();
}

class _AnimatedShimmerCardState extends State<AnimatedShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    // Only show in dark mode
    if (brightness == Brightness.light) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(_animation.value - 0.5, -0.3),
                end: Alignment(_animation.value + 0.5, 0.3),
                colors: [
                  Colors.transparent,
                  AppColors.shimmerGradientDark.colors[1]
                      .withOpacity(widget.opacity * 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
