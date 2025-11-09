import 'package:flutter/material.dart';
import '../../../core/animation/interaction_states.dart';

/// 🎯 TapFeedbackWrapper - Universal tap feedback system
///
/// Wraps any widget with responsive tap feedback including haptic response,
/// ripple effect, and scale-down animation. Provides instant tactile confirmation
/// for user interactions.
///
/// Features:
/// - Platform-aware haptic feedback (mobile only)
/// - Material ripple effect with customizable colors
/// - Scale-down animation on press (1.0 → 0.97)
/// - Configurable feedback intensity (light, medium, heavy)
/// - Disabled state support
/// - Optional custom feedback duration
///
/// Usage:
/// ```dart
/// TapFeedbackWrapper(
///   onTap: () => print('Tapped!'),
///   child: Icon(Icons.star),
/// )
/// ```
///
/// Custom configuration:
/// ```dart
/// TapFeedbackWrapper(
///   onTap: () {},
///   hapticIntensity: HapticIntensity.heavy,
///   rippleColor: Colors.blue,
///   scaleOnTap: 0.95,
///   showRipple: false,
///   child: MyWidget(),
/// )
/// ```

/// Haptic feedback intensity levels.
enum HapticIntensity {
  /// Light haptic for subtle interactions.
  light,

  /// Medium haptic for standard interactions (default).
  medium,

  /// Heavy haptic for emphasized interactions.
  heavy,

  /// No haptic feedback.
  none,
}

class TapFeedbackWrapper extends StatefulWidget {
  const TapFeedbackWrapper({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.hapticIntensity = HapticIntensity.medium,
    this.rippleColor,
    this.highlightColor,
    this.scaleOnTap,
    this.showRipple = true,
    this.borderRadius,
    this.behavior = HitTestBehavior.opaque,
    this.enabled = true,
  });

  /// Content to wrap with tap feedback.
  final Widget child;

  /// Callback when widget is tapped.
  final VoidCallback onTap;

  /// Callback when widget is long-pressed.
  final VoidCallback? onLongPress;

  /// Callback when widget is double-tapped.
  final VoidCallback? onDoubleTap;

  /// Intensity of haptic feedback (mobile only).
  /// Default: [HapticIntensity.medium]
  final HapticIntensity hapticIntensity;

  /// Color of the ripple effect.
  /// Default: Theme.of(context).splashColor
  final Color? rippleColor;

  /// Color of the highlight overlay during press.
  /// Default: Theme.of(context).highlightColor
  final Color? highlightColor;

  /// Scale factor when pressed. If null, uses [InteractionStates.tapScale] (0.95).
  final double? scaleOnTap;

  /// Whether to show Material ripple effect.
  final bool showRipple;

  /// Border radius for ripple clipping.
  /// If null, ripple extends to widget bounds.
  final BorderRadius? borderRadius;

  /// How the gesture detector should behave during hit testing.
  final HitTestBehavior behavior;

  /// Whether the widget is interactive.
  final bool enabled;

  @override
  State<TapFeedbackWrapper> createState() => _TapFeedbackWrapperState();
}

class _TapFeedbackWrapperState extends State<TapFeedbackWrapper>
    with SingleTickerProviderStateMixin {
  late final InteractionStateController _controller;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = InteractionStateController(isDisabled: !widget.enabled);

    // Scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: InteractionStates.tapDuration,
    );

    final scaleValue = widget.scaleOnTap ?? InteractionStates.tapScale;
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: scaleValue,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: InteractionStates.tapCurve,
    ));
  }

  @override
  void didUpdateWidget(TapFeedbackWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _controller.setDisabled(!widget.enabled);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Triggers haptic feedback based on intensity setting.
  Future<void> _triggerHaptic() async {
    if (!widget.enabled) return;

    switch (widget.hapticIntensity) {
      case HapticIntensity.light:
        await AppHaptics.light();
        break;
      case HapticIntensity.medium:
        await AppHaptics.medium();
        break;
      case HapticIntensity.heavy:
        await AppHaptics.heavy();
        break;
      case HapticIntensity.none:
        // No haptic feedback
        break;
    }
  }

  /// Handles tap down event (press start).
  void _onTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    _controller.onTapDown();
    _scaleController.forward();
  }

  /// Handles tap up event (press release).
  void _onTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    _controller.onTapUp();
    _scaleController.reverse();
  }

  /// Handles tap cancel event (press interrupted).
  void _onTapCancel() {
    if (!widget.enabled) return;
    _controller.onTapCancel();
    _scaleController.reverse();
  }

  /// Handles successful tap completion.
  void _onTap() {
    if (!widget.enabled) return;
    _triggerHaptic();
    widget.onTap();
  }

  /// Handles long press.
  void _onLongPress() {
    if (!widget.enabled || widget.onLongPress == null) return;
    AppHaptics.heavy(); // Heavy haptic for long press
    widget.onLongPress!();
  }

  /// Handles double tap.
  void _onDoubleTap() {
    if (!widget.enabled || widget.onDoubleTap == null) return;
    AppHaptics.selection(); // Selection haptic for double tap
    widget.onDoubleTap!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build content with scale animation
    final scaledChild = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );

    // Wrap with Material and InkWell for ripple effect
    if (widget.showRipple) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.enabled ? _onTap : null,
          onLongPress: widget.enabled && widget.onLongPress != null
              ? _onLongPress
              : null,
          onDoubleTap: widget.enabled && widget.onDoubleTap != null
              ? _onDoubleTap
              : null,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          splashColor: widget.rippleColor ?? theme.splashColor,
          highlightColor: widget.highlightColor ?? theme.highlightColor,
          borderRadius: widget.borderRadius,
          child: scaledChild,
        ),
      );
    }

    // Without ripple - use GestureDetector only
    return GestureDetector(
      onTap: widget.enabled ? _onTap : null,
      onLongPress: widget.enabled && widget.onLongPress != null
          ? _onLongPress
          : null,
      onDoubleTap: widget.enabled && widget.onDoubleTap != null
          ? _onDoubleTap
          : null,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: widget.behavior,
      child: scaledChild,
    );
  }
}

/// 🎯 TapFeedbackButton - Pre-styled button with integrated tap feedback
///
/// A complete button implementation with consistent styling, icon support,
/// and built-in tap feedback.
///
/// Usage:
/// ```dart
/// TapFeedbackButton(
///   label: 'Submit',
///   icon: Icons.check,
///   onTap: () => _submitForm(),
/// )
/// ```
class TapFeedbackButton extends StatelessWidget {
  const TapFeedbackButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.hapticIntensity = HapticIntensity.medium,
    this.enabled = true,
  });

  /// Button label text.
  final String label;

  /// Callback when button is tapped.
  final VoidCallback onTap;

  /// Optional icon before label.
  final IconData? icon;

  /// Button background color.
  /// Default: Theme.primaryColor
  final Color? backgroundColor;

  /// Text and icon color.
  /// Default: Colors.white
  final Color? textColor;

  /// Internal padding.
  /// Default: EdgeInsets.symmetric(horizontal: 24, vertical: 12)
  final EdgeInsetsGeometry? padding;

  /// Border radius.
  /// Default: BorderRadius.circular(8)
  final BorderRadius? borderRadius;

  /// Haptic feedback intensity.
  final HapticIntensity hapticIntensity;

  /// Whether button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.primaryColor;
    final effectiveTextColor = textColor ?? Colors.white;
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(8);

    return TapFeedbackWrapper(
      onTap: onTap,
      hapticIntensity: hapticIntensity,
      enabled: enabled,
      showRipple: true,
      borderRadius: effectiveBorderRadius,
      child: Opacity(
        opacity: enabled ? 1.0 : InteractionStates.disabledOpacity,
        child: Container(
          padding: effectivePadding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: effectiveBorderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: effectiveTextColor, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🎯 TapFeedbackIconButton - Icon button with integrated tap feedback
///
/// A circular icon button with consistent styling and tap feedback.
///
/// Usage:
/// ```dart
/// TapFeedbackIconButton(
///   icon: Icons.favorite,
///   onTap: () => _toggleFavorite(),
/// )
/// ```
class TapFeedbackIconButton extends StatelessWidget {
  const TapFeedbackIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 48.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.iconColor,
    this.hapticIntensity = HapticIntensity.light,
    this.enabled = true,
  });

  /// Icon to display.
  final IconData icon;

  /// Callback when button is tapped.
  final VoidCallback onTap;

  /// Button size (diameter).
  final double size;

  /// Icon size.
  final double iconSize;

  /// Background color.
  /// Default: Theme.cardColor
  final Color? backgroundColor;

  /// Icon color.
  /// Default: Theme.iconTheme.color
  final Color? iconColor;

  /// Haptic feedback intensity.
  final HapticIntensity hapticIntensity;

  /// Whether button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.cardColor;
    final effectiveIconColor = iconColor ?? theme.iconTheme.color;

    return TapFeedbackWrapper(
      onTap: onTap,
      hapticIntensity: hapticIntensity,
      enabled: enabled,
      showRipple: true,
      borderRadius: BorderRadius.circular(size / 2),
      child: Opacity(
        opacity: enabled ? 1.0 : InteractionStates.disabledOpacity,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: effectiveIconColor,
          ),
        ),
      ),
    );
  }
}
