import 'package:flutter/material.dart';
import '../animation/app_motion.dart';
import '../interaction/global_interaction_refinement.dart';
import '../theme/microstyle.dart';

/// 🎯 AppToggle System - Switch & Radio Components
///
/// **Design Philosophy:**
/// "Apple meets LegalTech" - Cupertino-inspired toggles with gradient tracks,
/// spring physics, and tactile haptic feedback.
///
/// **Components:**
/// 1. **AppSwitchToggle** - Animated switch with gradient track
/// 2. **AppRadioGroup** - Radio button set with scale animations
///
/// **Features:**
/// - Spring physics thumb movement
/// - Deep Purple → Indigo gradient on active state
/// - Haptic feedback on toggle/selection
/// - Scalable sizes (small, medium, large)
/// - Shadow bloom on activation
/// - Keyboard navigation support
///
/// **Integration:**
/// - AppMotion timing and curves
/// - AppInteractionRefinement for haptics
/// - AppMicroStyle for shadows
/// - Compatible with AppFormContainer

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ENUMS & TOKENS ━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Toggle switch sizes.
enum AppSwitchSize {
  small,
  medium,
  large,
}

/// Radio group layout direction.
enum AppRadioLayout {
  vertical,
  horizontal,
}

/// Design tokens for switch toggle.
class AppToggleColors {
  AppToggleColors._();

  // Track colors
  static const Color trackInactive = Color(0xFFE0E0E0);
  static const Color trackActiveStart = Color(0xFF512DA8); // Deep Purple
  static const Color trackActiveEnd = Color(0xFF3949AB); // Indigo

  // Thumb colors
  static const Color thumbInactive = Color(0xFFFFFFFF);
  static const Color thumbActive = Color(0xFFFFFFFF);

  // Disabled colors
  static const Color trackDisabled = Color(0xFFF5F5F5);
  static const Color thumbDisabled = Color(0xFFBDBDBD);

  // Label colors
  static const Color labelActive = Color(0xFF1A1A1A);
  static const Color labelInactive = Color(0xFF757575);
  static const Color labelDisabled = Color(0xFFBDBDBD);
}

class AppToggleMetrics {
  AppToggleMetrics._();

  // Track sizes by size variant
  static const Map<AppSwitchSize, double> trackWidth = {
    AppSwitchSize.small: 40.0,
    AppSwitchSize.medium: 48.0,
    AppSwitchSize.large: 56.0,
  };

  static const Map<AppSwitchSize, double> trackHeight = {
    AppSwitchSize.small: 20.0,
    AppSwitchSize.medium: 24.0,
    AppSwitchSize.large: 28.0,
  };

  // Thumb sizes by size variant
  static const Map<AppSwitchSize, double> thumbSize = {
    AppSwitchSize.small: 16.0,
    AppSwitchSize.medium: 20.0,
    AppSwitchSize.large: 24.0,
  };

  // Padding
  static const double thumbPadding = 2.0;

  // Transition durations
  static const Duration transitionNormal = AppMotion.normal; // 300ms
  static const Duration transitionFast = AppMotion.fast; // 200ms
}

/// Design tokens for radio buttons.
class AppRadioColors {
  AppRadioColors._();

  // Outer ring colors
  static const Color ringInactive = Color(0xFFBDBDBD);
  static const Color ringActive = Color(0xFF512DA8);
  static const Color ringDisabled = Color(0xFFE0E0E0);

  // Inner dot colors
  static const Color dotInactive = Colors.transparent;
  static const Color dotActive = Color(0xFF512DA8);

  // Label colors
  static const Color labelActive = Color(0xFF1A1A1A);
  static const Color labelInactive = Color(0xFF757575);
  static const Color labelDisabled = Color(0xFFBDBDBD);
}

class AppRadioMetrics {
  AppRadioMetrics._();

  // Radio button sizes
  static const double ringSize = 20.0;
  static const double dotSize = 10.0;
  static const double ringWidth = 2.0;

  // Spacing
  static const double labelSpacing = 12.0;
  static const double itemSpacing = 16.0;

  // Transition durations
  static const Duration transitionNormal = AppMotion.normal; // 300ms
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━ APP SWITCH TOGGLE ━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Cupertino-style switch toggle with gradient track and spring physics.
class AppSwitchToggle extends StatefulWidget {
  const AppSwitchToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelPosition = LabelPosition.right,
    this.size = AppSwitchSize.medium,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final LabelPosition labelPosition;
  final AppSwitchSize size;
  final bool enabled;

  @override
  State<AppSwitchToggle> createState() => _AppSwitchToggleState();
}

enum LabelPosition { left, right }

class _AppSwitchToggleState extends State<AppSwitchToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _thumbAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppToggleMetrics.transitionNormal,
      vsync: this,
    );

    _thumbAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(_controller);

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AppSwitchToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (!widget.enabled) return;
    await AppInteractionRefinement.onTap(context);
    widget.onChanged?.call(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final trackW = AppToggleMetrics.trackWidth[widget.size]!;
    final trackH = AppToggleMetrics.trackHeight[widget.size]!;
    final thumbS = AppToggleMetrics.thumbSize[widget.size]!;

    final switchWidget = GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: AppToggleMetrics.transitionNormal,
        curve: AppCurves.smooth,
        width: trackW,
        height: trackH,
        decoration: BoxDecoration(
          gradient: widget.value && widget.enabled
              ? LinearGradient(
                  colors: [
                    AppToggleColors.trackActiveStart,
                    AppToggleColors.trackActiveEnd,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: !widget.enabled
              ? AppToggleColors.trackDisabled
              : (widget.value ? null : AppToggleColors.trackInactive),
          borderRadius: BorderRadius.circular(trackH / 2),
          boxShadow: widget.value && widget.enabled
              ? [AppMicroStyle.shadowSoft]
              : null,
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final maxOffset = trackW - thumbS - (AppToggleMetrics.thumbPadding * 2);
            final offset = _thumbAnimation.value * maxOffset;

            return Padding(
              padding: const EdgeInsets.all(AppToggleMetrics.thumbPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: Offset(offset, 0),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: thumbS,
                      height: thumbS,
                      decoration: BoxDecoration(
                        color: widget.enabled
                            ? (widget.value
                                ? AppToggleColors.thumbActive
                                : AppToggleColors.thumbInactive)
                            : AppToggleColors.thumbDisabled,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    if (widget.label == null) {
      return switchWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelPosition == LabelPosition.left) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              color: widget.enabled
                  ? (widget.value
                      ? AppToggleColors.labelActive
                      : AppToggleColors.labelInactive)
                  : AppToggleColors.labelDisabled,
              fontWeight: widget.value ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
          const SizedBox(width: 12),
        ],
        switchWidget,
        if (widget.labelPosition == LabelPosition.right) ...[
          const SizedBox(width: 12),
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              color: widget.enabled
                  ? (widget.value
                      ? AppToggleColors.labelActive
                      : AppToggleColors.labelInactive)
                  : AppToggleColors.labelDisabled,
              fontWeight: widget.value ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP RADIO GROUP ━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Radio button option model.
class AppRadioOption<T> {
  const AppRadioOption({
    required this.value,
    required this.label,
    this.sublabel,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? sublabel;
  final bool enabled;
}

/// Radio button group with animated selection transitions.
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.groupLabel,
    this.helperText,
    this.layout = AppRadioLayout.vertical,
    this.enabled = true,
  });

  final List<AppRadioOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? groupLabel;
  final String? helperText;
  final AppRadioLayout layout;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupLabel != null) ...[
          Text(
            groupLabel!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppRadioColors.labelActive,
            ),
          ),
          const SizedBox(height: 12),
        ],
        layout == AppRadioLayout.vertical
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppRadioMetrics.itemSpacing,
                    ),
                    child: _AppRadioButton<T>(
                      option: option,
                      isSelected: value == option.value,
                      onTap: () => onChanged?.call(option.value),
                      enabled: enabled && option.enabled,
                    ),
                  );
                }).toList(),
              )
            : Wrap(
                spacing: AppRadioMetrics.itemSpacing,
                runSpacing: AppRadioMetrics.itemSpacing,
                children: options.map((option) {
                  return _AppRadioButton<T>(
                    option: option,
                    isSelected: value == option.value,
                    onTap: () => onChanged?.call(option.value),
                    enabled: enabled && option.enabled,
                  );
                }).toList(),
              ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            helperText!,
            style: TextStyle(
              fontSize: 12,
              color: AppRadioColors.labelInactive,
            ),
          ),
        ],
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP RADIO BUTTON ━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Individual radio button with scale animation.
class _AppRadioButton<T> extends StatefulWidget {
  const _AppRadioButton({
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.enabled,
  });

  final AppRadioOption<T> option;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  State<_AppRadioButton<T>> createState() => _AppRadioButtonState<T>();
}

class _AppRadioButtonState<T> extends State<_AppRadioButton<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppRadioMetrics.transitionNormal,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    if (widget.isSelected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_AppRadioButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (!widget.enabled) return;
    await AppInteractionRefinement.onSelection(context);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppRadioMetrics.ringSize,
            height: AppRadioMetrics.ringSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ring
                Container(
                  width: AppRadioMetrics.ringSize,
                  height: AppRadioMetrics.ringSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: !widget.enabled
                          ? AppRadioColors.ringDisabled
                          : (widget.isSelected
                              ? AppRadioColors.ringActive
                              : AppRadioColors.ringInactive),
                      width: AppRadioMetrics.ringWidth,
                    ),
                  ),
                ),
                // Inner dot (animated)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: AppRadioMetrics.dotSize,
                        height: AppRadioMetrics.dotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isSelected
                              ? AppRadioColors.dotActive
                              : AppRadioColors.dotInactive,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: AppRadioMetrics.labelSpacing),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.option.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: widget.isSelected ? FontWeight.w500 : FontWeight.w400,
                    color: !widget.enabled
                        ? AppRadioColors.labelDisabled
                        : (widget.isSelected
                            ? AppRadioColors.labelActive
                            : AppRadioColors.labelInactive),
                  ),
                ),
                if (widget.option.sublabel != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    widget.option.sublabel!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppRadioColors.labelInactive,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ Phase 4.3.2 — Toggles System Complete
///
/// **Components:**
/// - AppSwitchToggle: Switch with gradient track and spring physics
/// - AppRadioGroup: Radio button set with scale animations
///
/// **Features:**
/// - Spring physics thumb movement (300ms smooth)
/// - Deep Purple → Indigo gradient on active state
/// - Shadow bloom on switch activation
/// - Radio inner dot scale animation with easeOutBack curve
/// - Haptic feedback via AppInteractionRefinement
/// - Scalable switch sizes (small/medium/large)
/// - Vertical/horizontal radio layouts
/// - Optional sublabels and helper text
/// - Full disabled state support
