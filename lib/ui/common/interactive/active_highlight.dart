import 'package:flutter/material.dart';
import '../../../core/animation/interaction_states.dart';
import '../../../core/theme/microstyle.dart';

/// 🎯 ActiveHighlight - Focus/Active state visual indicator
///
/// Provides visual feedback for focus and active states through animated borders
/// and optional gradient glow effects. Perfect for form inputs, buttons, and
/// selectable items.
///
/// Features:
/// - Animated border with customizable color and width
/// - Optional gradient glow effect (inner/outer)
/// - Smooth fade-in/fade-out transitions
/// - Support for focus, active, and selected states
/// - Integration with InteractionStateController
/// - Accessibility-friendly (respects focus indicators)
///
/// Usage:
/// ```dart
/// ActiveHighlight(
///   isFocused: _isFocused,
///   child: TextField(...),
/// )
/// ```
///
/// With gradient glow:
/// ```dart
/// ActiveHighlight(
///   isActive: true,
///   showGlow: true,
///   glowColor: Colors.blue,
///   child: MyWidget(),
/// )
/// ```

class ActiveHighlight extends StatefulWidget {
  const ActiveHighlight({
    super.key,
    required this.child,
    this.isFocused = false,
    this.isActive = false,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.showGlow = false,
    this.glowColor,
    this.glowSpread = 4.0,
    this.glowBlur = 8.0,
    this.duration,
    this.curve,
  });

  /// Content to wrap with highlight indicator.
  final Widget child;

  /// Whether the widget is focused (keyboard focus).
  final bool isFocused;

  /// Whether the widget is active/selected.
  final bool isActive;

  /// Color of the border highlight.
  /// Default: Theme.primaryColor
  final Color? borderColor;

  /// Width of the border.
  /// Default: [InteractionStates.focusBorderWidth] (2.0)
  final double? borderWidth;

  /// Border radius for the highlight.
  /// Default: [AppMicroStyle.radiusMedium] (12.0)
  final BorderRadius? borderRadius;

  /// Whether to show gradient glow effect.
  final bool showGlow;

  /// Color of the glow effect.
  /// Default: [borderColor] with reduced opacity
  final Color? glowColor;

  /// Glow spread distance (logical pixels).
  final double glowSpread;

  /// Glow blur radius.
  final double glowBlur;

  /// Animation duration for state transitions.
  /// Default: [InteractionStates.focusDuration] (300ms)
  final Duration? duration;

  /// Animation curve for state transitions.
  /// Default: [InteractionStates.focusCurve]
  final Curve? curve;

  @override
  State<ActiveHighlight> createState() => _ActiveHighlightState();
}

class _ActiveHighlightState extends State<ActiveHighlight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    final duration = widget.duration ?? InteractionStates.focusDuration;
    final curve = widget.curve ?? InteractionStates.focusCurve;

    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: curve,
    );

    _updateAnimation();
  }

  @override
  void didUpdateWidget(ActiveHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFocused != widget.isFocused ||
        oldWidget.isActive != widget.isActive) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Updates animation state based on focus/active state.
  void _updateAnimation() {
    if (widget.isFocused || widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor = widget.borderColor ?? theme.primaryColor;
    final effectiveBorderWidth =
        widget.borderWidth ?? InteractionStates.focusBorderWidth;
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(AppMicroStyle.radiusMedium);
    final effectiveGlowColor =
        widget.glowColor ?? effectiveBorderColor.withValues(alpha: 0.3);

    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        final opacity = _opacityAnimation.value;

        return Stack(
          children: [
            // Outer glow effect (if enabled)
            if (widget.showGlow && opacity > 0)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: effectiveBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: effectiveGlowColor.withValues(alpha: opacity * 0.5),
                        blurRadius: widget.glowBlur,
                        spreadRadius: widget.glowSpread,
                      ),
                    ],
                  ),
                ),
              ),

            // Main content
            child!,

            // Animated border overlay
            if (opacity > 0)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: effectiveBorderColor.withValues(alpha: opacity),
                        width: effectiveBorderWidth,
                      ),
                      borderRadius: effectiveBorderRadius,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: widget.child,
    );
  }
}

/// 🎯 FocusableCard - Card with integrated focus highlight
///
/// Combines HoverCard-style interaction with ActiveHighlight focus indicators.
/// Perfect for keyboard-navigable lists and grids.
///
/// Usage:
/// ```dart
/// FocusableCard(
///   onTap: () {},
///   child: ListTile(title: Text('Item')),
/// )
/// ```
class FocusableCard extends StatefulWidget {
  const FocusableCard({
    super.key,
    required this.child,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.isActive = false,
    this.elevation = 2.0,
    this.borderRadius,
    this.padding,
    this.margin,
    this.enabled = true,
  });

  /// Content to display inside the card.
  final Widget child;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Optional focus node for external focus management.
  final FocusNode? focusNode;

  /// Whether the card should request focus on mount.
  final bool autofocus;

  /// Whether the card is in active/selected state.
  final bool isActive;

  /// Base elevation (shadow depth).
  final double elevation;

  /// Border radius for the card.
  final BorderRadius? borderRadius;

  /// Internal padding.
  final EdgeInsetsGeometry? padding;

  /// External margin.
  final EdgeInsetsGeometry? margin;

  /// Whether the card is interactive.
  final bool enabled;

  @override
  State<FocusableCard> createState() => _FocusableCardState();
}

class _FocusableCardState extends State<FocusableCard> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _handleTap() {
    if (!widget.enabled) return;
    _focusNode.requestFocus();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(AppMicroStyle.radiusMedium);

    return GestureDetector(
      onTap: _handleTap,
      child: Focus(
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        child: ActiveHighlight(
          isFocused: _isFocused,
          isActive: widget.isActive,
          borderRadius: effectiveBorderRadius,
          showGlow: true,
          child: AnimatedContainer(
            duration: InteractionStates.focusDuration,
            curve: InteractionStates.focusCurve,
            margin: widget.margin,
            child: Material(
              color: theme.cardColor,
              elevation: widget.elevation,
              borderRadius: effectiveBorderRadius,
              child: widget.padding != null
                  ? Padding(padding: widget.padding!, child: widget.child)
                  : widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

/// 🎯 SelectableChip - Chip with active state highlight
///
/// A chip-style widget with clear visual indication of selection state.
///
/// Usage:
/// ```dart
/// SelectableChip(
///   label: 'Category',
///   isSelected: _isSelected,
///   onTap: () => setState(() => _isSelected = !_isSelected),
/// )
/// ```
class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
    this.icon,
    this.selectedColor,
    this.unselectedColor,
    this.textColor,
    this.padding,
    this.enabled = true,
  });

  /// Label text for the chip.
  final String label;

  /// Whether the chip is selected.
  final bool isSelected;

  /// Callback when chip is tapped.
  final VoidCallback? onTap;

  /// Optional icon before label.
  final IconData? icon;

  /// Color when selected.
  /// Default: Theme.primaryColor
  final Color? selectedColor;

  /// Color when unselected.
  /// Default: Theme.cardColor
  final Color? unselectedColor;

  /// Text and icon color.
  /// Default: Adaptive (white when selected, primary when unselected)
  final Color? textColor;

  /// Internal padding.
  /// Default: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
  final EdgeInsetsGeometry? padding;

  /// Whether the chip is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveSelectedColor = selectedColor ?? theme.primaryColor;
    final effectiveUnselectedColor = unselectedColor ?? theme.cardColor;
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    final effectiveTextColor = textColor ??
        (isSelected ? Colors.white : theme.primaryColor);

    return ActiveHighlight(
      isActive: isSelected,
      borderRadius: BorderRadius.circular(AppMicroStyle.radiusSmall),
      showGlow: isSelected,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: AnimatedContainer(
          duration: InteractionStates.focusDuration,
          curve: InteractionStates.focusCurve,
          padding: effectivePadding,
          decoration: BoxDecoration(
            color: isSelected ? effectiveSelectedColor : effectiveUnselectedColor,
            borderRadius: BorderRadius.circular(AppMicroStyle.radiusSmall),
            border: Border.all(
              color: isSelected
                  ? effectiveSelectedColor
                  : theme.dividerColor,
              width: 1.0,
            ),
          ),
          child: Opacity(
            opacity: enabled ? 1.0 : InteractionStates.disabledOpacity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: effectiveTextColor),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: effectiveTextColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🎯 ActiveIndicator - Simple animated indicator dot
///
/// A small circular indicator that animates between active/inactive states.
/// Useful for tabs, steppers, and pagination.
///
/// Usage:
/// ```dart
/// Row(
///   children: pages.map((i) => ActiveIndicator(
///     isActive: i == currentPage,
///   )).toList(),
/// )
/// ```
class ActiveIndicator extends StatelessWidget {
  const ActiveIndicator({
    super.key,
    this.isActive = false,
    this.size = 8.0,
    this.activeSize = 12.0,
    this.color,
    this.activeColor,
  });

  /// Whether the indicator is active.
  final bool isActive;

  /// Size when inactive.
  final double size;

  /// Size when active.
  final double activeSize;

  /// Color when inactive.
  /// Default: Theme.disabledColor
  final Color? color;

  /// Color when active.
  /// Default: Theme.primaryColor
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.disabledColor;
    final effectiveActiveColor = activeColor ?? theme.primaryColor;

    return AnimatedContainer(
      duration: InteractionStates.focusDuration,
      curve: InteractionStates.focusCurve,
      width: isActive ? activeSize : size,
      height: isActive ? activeSize : size,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? effectiveActiveColor : effectiveColor,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: effectiveActiveColor.withValues(alpha: 0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}
