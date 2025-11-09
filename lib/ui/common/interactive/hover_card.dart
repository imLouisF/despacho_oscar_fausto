import 'package:flutter/material.dart';
import '../../../core/animation/interaction_states.dart';
import '../../../core/theme/microstyle.dart';

/// 🎯 HoverCard - Responsive card with platform-aware hover effects
///
/// An interactive card that responds to hover events (desktop/web) with subtle
/// scale, shadow elevation, and color overlay effects. Maintains professional
/// appearance while providing clear visual feedback.
///
/// Features:
/// - Platform-aware hover detection (desktop/web only)
/// - Smooth scale transform on hover (1.0 → 1.02)
/// - Dynamic shadow elevation increase
/// - Optional color overlay with configurable opacity
/// - Integrated with InteractionStateController
/// - Synced with AppMotion timing and AppMicroStyle constants
///
/// Usage:
/// ```dart
/// HoverCard(
///   onTap: () => Navigator.push(...),
///   child: ListTile(
///     title: Text('Case #12345'),
///     subtitle: Text('Active'),
///   ),
/// )
/// ```
///
/// Advanced usage with custom configuration:
/// ```dart
/// HoverCard(
///   elevation: 4.0,
///   hoverElevation: 12.0,
///   borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
///   overlayColor: Colors.blue,
///   overlayOpacity: 0.08,
///   onTap: () {},
///   child: YourContent(),
/// )
/// ```

class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevation = 2.0,
    this.hoverElevation,
    this.borderRadius,
    this.backgroundColor,
    this.overlayColor,
    this.overlayOpacity,
    this.padding,
    this.margin,
    this.clipBehavior = Clip.antiAlias,
    this.enabled = true,
  });

  /// Content to display inside the card.
  final Widget child;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Callback when card is long-pressed.
  final VoidCallback? onLongPress;

  /// Base elevation (shadow depth) for the card.
  /// Default: 2.0
  final double elevation;

  /// Elevation when hovered. If null, uses [elevation + InteractionStates.hoverElevationDelta].
  final double? hoverElevation;

  /// Border radius for the card corners.
  /// Default: [AppMicroStyle.radiusMedium] (12.0)
  final BorderRadius? borderRadius;

  /// Background color of the card.
  /// Default: Theme.cardColor
  final Color? backgroundColor;

  /// Color for the hover overlay effect.
  /// Default: Theme.primaryColor
  final Color? overlayColor;

  /// Opacity for the hover overlay.
  /// Default: [InteractionStates.hoverOverlayOpacity] (0.05)
  final double? overlayOpacity;

  /// Internal padding for the card content.
  final EdgeInsetsGeometry? padding;

  /// External margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Clip behavior for the card shape.
  final Clip clipBehavior;

  /// Whether the card is interactive.
  /// If false, hover and tap effects are disabled.
  final bool enabled;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  late final InteractionStateController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InteractionStateController(isDisabled: !widget.enabled);
  }

  @override
  void didUpdateWidget(HoverCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _controller.setDisabled(!widget.enabled);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(AppMicroStyle.radiusMedium);
    final effectiveBackgroundColor = widget.backgroundColor ?? theme.cardColor;
    final effectiveOverlayColor = widget.overlayColor ?? theme.primaryColor;
    final effectiveOverlayOpacity =
        widget.overlayOpacity ?? InteractionStates.hoverOverlayOpacity;
    final effectiveHoverElevation = widget.hoverElevation ??
        (widget.elevation + InteractionStates.hoverElevationDelta);

    return ValueListenableBuilder<InteractionState>(
      valueListenable: _controller,
      builder: (context, state, child) {
        // Calculate current elevation based on hover state
        final currentElevation =
            state.isHovered ? effectiveHoverElevation : widget.elevation;

        // Calculate overlay opacity based on interaction state
        final currentOverlayOpacity =
            state.isHovered ? effectiveOverlayOpacity : 0.0;

        return AnimatedContainer(
          duration: InteractionStates.hoverDuration,
          curve: InteractionStates.hoverCurve,
          margin: widget.margin,
          // Apply scale transform on hover (platform-aware)
          transform: Matrix4.identity()..scale(state.scale),
          transformAlignment: Alignment.center,
          child: Material(
            color: effectiveBackgroundColor,
            elevation: currentElevation,
            borderRadius: effectiveBorderRadius,
            clipBehavior: widget.clipBehavior,
            child: Stack(
              children: [
                // Main content
                if (widget.padding != null)
                  Padding(padding: widget.padding!, child: widget.child)
                else
                  widget.child,

                // Hover overlay (color tint)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: currentOverlayOpacity,
                    duration: InteractionStates.hoverDuration,
                    curve: InteractionStates.hoverCurve,
                    child: Container(
                      decoration: BoxDecoration(
                        color: effectiveOverlayColor,
                        borderRadius: effectiveBorderRadius,
                      ),
                    ),
                  ),
                ),

                // Interaction detector (hover + tap)
                Positioned.fill(
                  child: MouseRegion(
                    cursor: widget.enabled && (widget.onTap != null || widget.onLongPress != null)
                        ? SystemMouseCursors.click
                        : MouseCursor.defer,
                    onEnter: (_) => _controller.onHoverEnter(),
                    onExit: (_) => _controller.onHoverExit(),
                    child: GestureDetector(
                      onTapDown: (_) => _controller.onTapDown(),
                      onTapUp: (_) {
                        _controller.onTapUp();
                        if (widget.enabled && widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      onTapCancel: () => _controller.onTapCancel(),
                      onLongPress: widget.enabled ? widget.onLongPress : null,
                      behavior: HitTestBehavior.translucent,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 🎯 HoverCardList - Convenience widget for list items with hover effects
///
/// Pre-configured HoverCard optimized for list item usage with consistent
/// spacing and typography.
///
/// Usage:
/// ```dart
/// ListView.builder(
///   itemBuilder: (context, index) => HoverCardList(
///     title: 'Item $index',
///     subtitle: 'Description',
///     leading: Icon(Icons.folder),
///     onTap: () {},
///   ),
/// )
/// ```
class HoverCardList extends StatelessWidget {
  const HoverCardList({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  });

  /// Primary text for the list item.
  final String title;

  /// Secondary text for the list item.
  final String? subtitle;

  /// Leading widget (usually an icon or avatar).
  final Widget? leading;

  /// Trailing widget (usually an icon or badge).
  final Widget? trailing;

  /// Callback when item is tapped.
  final VoidCallback? onTap;

  /// Callback when item is long-pressed.
  final VoidCallback? onLongPress;

  /// Whether the item is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      onTap: onTap,
      onLongPress: onLongPress,
      enabled: enabled,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMicroStyle.spaceM,
        vertical: AppMicroStyle.spaceXS,
      ),
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        enabled: enabled,
      ),
    );
  }
}

/// 🎯 HoverCardGrid - Convenience widget for grid items with hover effects
///
/// Pre-configured HoverCard optimized for grid item usage with square aspect
/// ratio and centered content.
///
/// Usage:
/// ```dart
/// GridView.builder(
///   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
///   itemBuilder: (context, index) => HoverCardGrid(
///     icon: Icons.folder,
///     label: 'Item $index',
///     onTap: () {},
///   ),
/// )
/// ```
class HoverCardGrid extends StatelessWidget {
  const HoverCardGrid({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.enabled = true,
    this.iconSize = 48.0,
  });

  /// Icon to display in the center.
  final IconData icon;

  /// Label text below the icon.
  final String label;

  /// Callback when item is tapped.
  final VoidCallback? onTap;

  /// Whether the item is interactive.
  final bool enabled;

  /// Size of the icon.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return HoverCard(
      onTap: onTap,
      enabled: enabled,
      margin: const EdgeInsets.all(AppMicroStyle.spaceS),
      child: Padding(
        padding: const EdgeInsets.all(AppMicroStyle.spaceL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: enabled ? theme.primaryColor : theme.disabledColor,
            ),
            const SizedBox(height: AppMicroStyle.spaceS),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: enabled ? theme.textTheme.bodyMedium?.color : theme.disabledColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
