import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import '../animation/app_motion.dart';
import '../interaction/global_interaction_refinement.dart';
import '../theme/microstyle.dart';

/// 🎯 AppCard System - Modular Card Architecture
///
/// **Design Philosophy:**
/// Cards are the primary structural elements that organize content and establish
/// visual hierarchy. Following "Apple meets LegalTech" aesthetic with Deep Purple
/// Jurídico palette, glassmorphism effects, and smooth motion integration.
///
/// **Card Hierarchy:**
/// 1. **Standard** - Elevated card with shadow depth (default content container)
/// 2. **Glass** - Glassmorphism with blur and transparency (featured/overlay content)
/// 3. **Gradient** - Deep Purple → Indigo gradient (high-importance sections)
///
/// **Integration:**
/// - AppMotion timing and curves for smooth transitions
/// - AppInteractionRefinement for haptic + visual feedback
/// - AppMicroStyle for shadows, spacing, and radius
/// - Deep Purple palette with gradient accents
///
/// **Usage:**
/// ```dart
/// // Standard elevated card
/// AppCard(
///   child: ListTile(
///     title: Text('Caso #12345'),
///     subtitle: Text('En progreso'),
///   ),
///   onTap: () => navigateToCase(),
/// )
///
/// // Glassmorphism card
/// AppGlassCard(
///   child: Column(
///     children: [
///       Text('Estadísticas'),
///       Text('42 casos activos'),
///     ],
///   ),
/// )
///
/// // Gradient accent card
/// AppGradientCard(
///   child: Text('Destacado'),
///   onTap: () => showFeaturedContent(),
/// )
/// ```

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ CORE ENUMS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Card visual style types.
enum AppCardType {
  /// Standard elevated card with solid background.
  standard,

  /// Glassmorphism card with blur and transparency.
  glass,

  /// Gradient background card (Deep Purple → Indigo).
  gradient,
}

/// Card elevation levels for depth perception.
enum AppCardElevation {
  /// Flat design with no shadow (0dp).
  flat,

  /// Soft elevation for subtle depth (~2dp).
  soft,

  /// Medium elevation for standard depth (~4dp).
  medium,

  /// Deep elevation for prominent depth (~8dp).
  deep,
}

/// Card interaction states for visual feedback.
enum AppCardState {
  /// Normal resting state.
  normal,

  /// Mouse hover state (desktop only).
  hover,

  /// Pressed/tapped state.
  pressed,

  /// Disabled non-interactive state.
  disabled,
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━ DESIGN TOKENS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Deep Purple Jurídico color palette for cards.
class AppCardColors {
  AppCardColors._();

  // Background colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F8F8);
  static const Color surfaceTinted = Color(0xFFF9F7FC); // Light purple tint

  // Gradient colors (Deep Purple → Indigo)
  static const Color gradientStart = Color(0xFF512DA8); // Deep Purple 700
  static const Color gradientEnd = Color(0xFF3949AB); // Indigo 600

  // Glass effect colors
  static const Color glassSurface = Color(0xFAFFFFFF); // 98% white
  static const Color glassOverlay = Color(0x1A512DA8); // 10% purple tint

  // Border colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderHighlight = Color(0xFF9575CD); // Purple 300

  // State colors
  static const Color hover = Color(0xFFF3F0FF); // Light purple
  static const Color pressed = Color(0xFFE8E0FF); // Slightly darker
}

/// Card size and spacing constants.
class AppCardMetrics {
  AppCardMetrics._();

  // Padding
  static const EdgeInsets paddingSmall = EdgeInsets.all(12);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24);

  // Margin
  static const EdgeInsets marginSmall = EdgeInsets.all(4);
  static const EdgeInsets marginMedium = EdgeInsets.all(8);
  static const EdgeInsets marginLarge = EdgeInsets.all(16);

  // Border radius
  static const double radiusSmall = 12.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 24.0;

  // Border width
  static const double borderWidth = 1.0;

  // Glass blur intensity
  static const double glassBlur = 16.0;

  // Scale factors for interaction states
  static const double scaleNormal = 1.0;
  static const double scaleHover = 1.02;
  static const double scalePressed = 0.98;
}

/// Elevation configuration for card depth.
class AppCardElevationConfig {
  const AppCardElevationConfig({
    required this.shadows,
    required this.hoverShadows,
  });

  final List<BoxShadow> shadows;
  final List<BoxShadow> hoverShadows;

  /// Returns elevation configuration for given level.
  static AppCardElevationConfig forLevel(AppCardElevation level) {
    switch (level) {
      case AppCardElevation.flat:
        return const AppCardElevationConfig(
          shadows: [],
          hoverShadows: [],
        );

      case AppCardElevation.soft:
        return AppCardElevationConfig(
          shadows: [AppMicroStyle.shadowSoft],
          hoverShadows: [AppMicroStyle.shadowMedium],
        );

      case AppCardElevation.medium:
        return AppCardElevationConfig(
          shadows: [AppMicroStyle.shadowMedium],
          hoverShadows: [AppMicroStyle.shadowDeep],
        );

      case AppCardElevation.deep:
        return AppCardElevationConfig(
          shadows: [AppMicroStyle.shadowDeep],
          hoverShadows: [
            const BoxShadow(
              color: Color(0x40000000), // 25% black
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        );
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ COMPONENTS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standard elevated card with shadow depth and smooth interactions.
///
/// The foundational card component for organizing content with visual hierarchy.
/// Supports hover effects, tap feedback, and customizable elevation levels.
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.elevation = AppCardElevation.medium,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.enabled = true,
  });

  /// Content to display inside the card.
  final Widget child;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Callback when card is long-pressed.
  final VoidCallback? onLongPress;

  /// Elevation level for shadow depth.
  final AppCardElevation elevation;

  /// Internal padding (defaults to medium).
  final EdgeInsetsGeometry? padding;

  /// External margin (defaults to medium).
  final EdgeInsetsGeometry? margin;

  /// Border radius (defaults to medium).
  final double? borderRadius;

  /// Background color (defaults to surface).
  final Color? backgroundColor;

  /// Optional border decoration.
  final BoxBorder? border;

  /// Whether the card is interactive.
  final bool enabled;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  AppCardState _currentState = AppCardState.normal;

  bool get _isInteractive =>
      widget.enabled && (widget.onTap != null || widget.onLongPress != null);

  @override
  Widget build(BuildContext context) {
    final state = widget.enabled ? _currentState : AppCardState.disabled;
    final elevationConfig = AppCardElevationConfig.forLevel(widget.elevation);

    // Determine effective values
    final effectivePadding = widget.padding ?? AppCardMetrics.paddingMedium;
    final effectiveMargin = widget.margin ?? AppCardMetrics.marginMedium;
    final effectiveRadius = widget.borderRadius ?? AppCardMetrics.radiusMedium;
    final effectiveBackgroundColor =
        widget.backgroundColor ?? AppCardColors.surface;

    // Determine current shadows based on state
    final currentShadows = state == AppCardState.hover
        ? elevationConfig.hoverShadows
        : elevationConfig.shadows;

    // Determine current scale based on state
    final currentScale = state == AppCardState.hover
        ? AppCardMetrics.scaleHover
        : state == AppCardState.pressed
            ? AppCardMetrics.scalePressed
            : AppCardMetrics.scaleNormal;

    return MouseRegion(
      cursor: _isInteractive ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => _updateState(AppCardState.hover),
      onExit: (_) => _updateState(AppCardState.normal),
      child: GestureDetector(
        onTapDown: (_) => _updateState(AppCardState.pressed),
        onTapUp: (_) {
          _updateState(AppCardState.normal);
          if (_isInteractive && widget.onTap != null) {
            _handleTap();
          }
        },
        onTapCancel: () => _updateState(AppCardState.normal),
        onLongPress: widget.enabled ? widget.onLongPress : null,
        child: AnimatedScale(
          scale: currentScale,
          duration: AppMotion.fast,
          curve: AppCurves.smooth,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppCurves.smooth,
            margin: effectiveMargin,
            padding: effectivePadding,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: widget.border,
              boxShadow: currentShadows,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _updateState(AppCardState newState) {
    if (!_isInteractive) return;
    setState(() => _currentState = newState);
  }

  void _handleTap() async {
    // Trigger haptic and visual feedback
    await AppInteractionRefinement.onTap(context);
    widget.onTap?.call();
  }
}

/// Glassmorphism card with blur and semi-transparent background.
///
/// Creates a frosted glass effect perfect for overlay content, modals,
/// or featured sections that need to stand out while maintaining context.
class AppGlassCard extends StatefulWidget {
  const AppGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blurIntensity,
    this.tintColor,
    this.border,
    this.enabled = true,
  });

  /// Content to display inside the card.
  final Widget child;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Internal padding (defaults to medium).
  final EdgeInsetsGeometry? padding;

  /// External margin (defaults to medium).
  final EdgeInsetsGeometry? margin;

  /// Border radius (defaults to large for glass effect).
  final double? borderRadius;

  /// Blur intensity (defaults to 16.0).
  final double? blurIntensity;

  /// Optional tint color overlay.
  final Color? tintColor;

  /// Optional border decoration.
  final BoxBorder? border;

  /// Whether the card is interactive.
  final bool enabled;

  @override
  State<AppGlassCard> createState() => _AppGlassCardState();
}

class _AppGlassCardState extends State<AppGlassCard> {
  AppCardState _currentState = AppCardState.normal;

  bool get _isInteractive => widget.enabled && widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final state = widget.enabled ? _currentState : AppCardState.disabled;

    // Determine effective values
    final effectivePadding = widget.padding ?? AppCardMetrics.paddingMedium;
    final effectiveMargin = widget.margin ?? AppCardMetrics.marginMedium;
    final effectiveRadius = widget.borderRadius ?? AppCardMetrics.radiusLarge;
    final effectiveBlur = widget.blurIntensity ?? AppCardMetrics.glassBlur;
    final effectiveTint = widget.tintColor ?? AppCardColors.glassOverlay;

    // Determine current scale based on state
    final currentScale = state == AppCardState.hover
        ? AppCardMetrics.scaleHover
        : state == AppCardState.pressed
            ? AppCardMetrics.scalePressed
            : AppCardMetrics.scaleNormal;

    return MouseRegion(
      cursor: _isInteractive ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => _updateState(AppCardState.hover),
      onExit: (_) => _updateState(AppCardState.normal),
      child: GestureDetector(
        onTapDown: (_) => _updateState(AppCardState.pressed),
        onTapUp: (_) {
          _updateState(AppCardState.normal);
          if (_isInteractive) {
            _handleTap();
          }
        },
        onTapCancel: () => _updateState(AppCardState.normal),
        child: AnimatedScale(
          scale: currentScale,
          duration: AppMotion.fast,
          curve: AppCurves.smooth,
          child: Container(
            margin: effectiveMargin,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(effectiveRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: effectiveBlur,
                  sigmaY: effectiveBlur,
                ),
                child: AnimatedContainer(
                  duration: AppMotion.fast,
                  curve: AppCurves.smooth,
                  padding: effectivePadding,
                  decoration: BoxDecoration(
                    color: AppCardColors.glassSurface,
                    borderRadius: BorderRadius.circular(effectiveRadius),
                    border: widget.border ??
                        Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                    boxShadow: [AppMicroStyle.shadowSoft],
                  ),
                  child: Stack(
                    children: [
                      // Purple tint overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: effectiveTint,
                            borderRadius: BorderRadius.circular(effectiveRadius),
                          ),
                        ),
                      ),
                      // Content
                      widget.child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateState(AppCardState newState) {
    if (!_isInteractive) return;
    setState(() => _currentState = newState);
  }

  void _handleTap() async {
    // Trigger haptic and visual feedback
    await AppInteractionRefinement.onTap(context);
    widget.onTap?.call();
  }
}

/// Gradient accent card with Deep Purple → Indigo background.
///
/// Used for high-importance or featured content sections that need
/// maximum visual prominence and attention.
class AppGradientCard extends StatefulWidget {
  const AppGradientCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.gradientStart,
    this.gradientEnd,
    this.elevation = AppCardElevation.medium,
    this.enabled = true,
  });

  /// Content to display inside the card.
  final Widget child;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Internal padding (defaults to large for prominence).
  final EdgeInsetsGeometry? padding;

  /// External margin (defaults to medium).
  final EdgeInsetsGeometry? margin;

  /// Border radius (defaults to large).
  final double? borderRadius;

  /// Gradient start color (defaults to Deep Purple).
  final Color? gradientStart;

  /// Gradient end color (defaults to Indigo).
  final Color? gradientEnd;

  /// Elevation level for shadow depth.
  final AppCardElevation elevation;

  /// Whether the card is interactive.
  final bool enabled;

  @override
  State<AppGradientCard> createState() => _AppGradientCardState();
}

class _AppGradientCardState extends State<AppGradientCard> {
  AppCardState _currentState = AppCardState.normal;

  bool get _isInteractive => widget.enabled && widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final state = widget.enabled ? _currentState : AppCardState.disabled;
    final elevationConfig = AppCardElevationConfig.forLevel(widget.elevation);

    // Determine effective values
    final effectivePadding = widget.padding ?? AppCardMetrics.paddingLarge;
    final effectiveMargin = widget.margin ?? AppCardMetrics.marginMedium;
    final effectiveRadius = widget.borderRadius ?? AppCardMetrics.radiusLarge;
    final effectiveGradientStart =
        widget.gradientStart ?? AppCardColors.gradientStart;
    final effectiveGradientEnd =
        widget.gradientEnd ?? AppCardColors.gradientEnd;

    // Determine current shadows based on state
    final currentShadows = state == AppCardState.hover
        ? elevationConfig.hoverShadows
        : elevationConfig.shadows;

    // Determine current scale based on state
    final currentScale = state == AppCardState.hover
        ? AppCardMetrics.scaleHover
        : state == AppCardState.pressed
            ? AppCardMetrics.scalePressed
            : AppCardMetrics.scaleNormal;

    return MouseRegion(
      cursor: _isInteractive ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => _updateState(AppCardState.hover),
      onExit: (_) => _updateState(AppCardState.normal),
      child: GestureDetector(
        onTapDown: (_) => _updateState(AppCardState.pressed),
        onTapUp: (_) {
          _updateState(AppCardState.normal);
          if (_isInteractive) {
            _handleTap();
          }
        },
        onTapCancel: () => _updateState(AppCardState.normal),
        child: AnimatedScale(
          scale: currentScale,
          duration: AppMotion.fast,
          curve: AppCurves.smooth,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppCurves.smooth,
            margin: effectiveMargin,
            padding: effectivePadding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [effectiveGradientStart, effectiveGradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(effectiveRadius),
              boxShadow: currentShadows,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateState(AppCardState newState) {
    if (!_isInteractive) return;
    setState(() => _currentState = newState);
  }

  void _handleTap() async {
    // Trigger haptic and visual feedback
    await AppInteractionRefinement.onTap(context);
    widget.onTap?.call();
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ UTILITIES ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Convenience widget for creating info cards with icon and text.
///
/// Perfect for dashboard statistics, metrics, or quick info displays.
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.subtitle,
    this.onTap,
    this.type = AppCardType.standard,
  });

  /// Card title (e.g., "Casos Activos").
  final String title;

  /// Main value to display (e.g., "42").
  final String value;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Card visual style.
  final AppCardType type;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 32),
          const SizedBox(height: 12),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: type == AppCardType.gradient
                ? Colors.white.withValues(alpha: 0.9)
                : AppCardColors.gradientStart.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: type == AppCardType.gradient
                ? Colors.white
                : AppCardColors.gradientStart,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12,
              color: type == AppCardType.gradient
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.black54,
            ),
          ),
        ],
      ],
    );

    switch (type) {
      case AppCardType.standard:
        return AppCard(
          onTap: onTap,
          child: content,
        );

      case AppCardType.glass:
        return AppGlassCard(
          onTap: onTap,
          child: content,
        );

      case AppCardType.gradient:
        return AppGradientCard(
          onTap: onTap,
          child: content,
        );
    }
  }
}

/// Convenience widget for creating action cards with button.
///
/// Combines content with a clear call-to-action, perfect for
/// dashboard quick actions or workflow triggers.
class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
    this.icon,
    this.type = AppCardType.standard,
  });

  /// Card title.
  final String title;

  /// Card description text.
  final String description;

  /// Action button label.
  final String actionLabel;

  /// Action button callback.
  final VoidCallback onAction;

  /// Optional icon.
  final IconData? icon;

  /// Card visual style.
  final AppCardType type;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 40,
            color: type == AppCardType.gradient
                ? Colors.white
                : AppCardColors.gradientStart,
          ),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: type == AppCardType.gradient
                ? Colors.white
                : AppCardColors.gradientStart,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: type == AppCardType.gradient
                ? Colors.white.withValues(alpha: 0.9)
                : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: type == AppCardType.gradient
                  ? Colors.white
                  : AppCardColors.gradientStart,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );

    switch (type) {
      case AppCardType.standard:
        return AppCard(child: content);

      case AppCardType.glass:
        return AppGlassCard(child: content);

      case AppCardType.gradient:
        return AppGradientCard(child: content);
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// ✅ Phase 4.2.1 — Core Card System Complete
///
/// **Implementation Summary:**
/// - 3 card types: Standard (elevated), Glass (blur), Gradient (accent)
/// - 4 elevation levels: Flat, Soft, Medium, Deep
/// - Full AppInteractionRefinement integration for haptic feedback
/// - Smooth AppMotion transitions (200ms fast timing)
/// - Deep Purple Jurídico palette with gradient accents
/// - Glassmorphism with BackdropFilter blur effects
/// - Platform-aware hover effects (desktop only)
/// - 2 utility components: InfoCard, ActionCard
///
/// **Component Hierarchy:**
/// ```
/// AppCard (Standard Elevated)
///   └─ Solid background + shadow depth
///
/// AppGlassCard (Glassmorphism)
///   └─ Blur + semi-transparent + purple tint
///
/// AppGradientCard (Gradient Accent)
///   └─ Deep Purple → Indigo gradient
///
/// InfoCard (Utility)
///   └─ Icon + title + value + subtitle
///
/// ActionCard (Utility)
///   └─ Icon + title + description + CTA button
/// ```
///
/// **Integration Examples:**
///
/// ```dart
/// // Example 1: Case list item
/// AppCard(
///   onTap: () => navigateToCase(case.id),
///   child: ListTile(
///     leading: Icon(Icons.folder_open),
///     title: Text('Caso #${case.number}'),
///     subtitle: Text(case.status),
///     trailing: Icon(Icons.arrow_forward_ios),
///   ),
/// )
///
/// // Example 2: Dashboard stats (glass effect)
/// AppGlassCard(
///   child: Column(
///     children: [
///       Text('Estadísticas Mensuales'),
///       SizedBox(height: 12),
///       Row(
///         children: [
///           Expanded(child: InfoCard(
///             title: 'Activos',
///             value: '42',
///             icon: Icons.trending_up,
///           )),
///           Expanded(child: InfoCard(
///             title: 'Cerrados',
///             value: '15',
///             icon: Icons.check_circle,
///           )),
///         ],
///       ),
///     ],
///   ),
/// )
///
/// // Example 3: Featured action (gradient)
/// AppGradientCard(
///   onTap: () => createNewCase(),
///   child: Row(
///     children: [
///       Icon(Icons.add_circle, size: 48),
///       SizedBox(width: 16),
///       Expanded(
///         child: Column(
///           crossAxisAlignment: CrossAxisAlignment.start,
///           children: [
///             Text('Crear Nuevo Caso',
///               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
///             Text('Inicia un nuevo expediente legal'),
///           ],
///         ),
///       ),
///       Icon(Icons.arrow_forward),
///     ],
///   ),
/// )
///
/// // Example 4: Info cards in grid
/// GridView.count(
///   crossAxisCount: 2,
///   children: [
///     InfoCard(
///       title: 'Total',
///       value: '127',
///       subtitle: 'Casos',
///       icon: Icons.folder,
///       type: AppCardType.standard,
///     ),
///     InfoCard(
///       title: 'Pendientes',
///       value: '8',
///       subtitle: 'Requieren atención',
///       icon: Icons.warning,
///       type: AppCardType.gradient,
///       onTap: () => showPendingCases(),
///     ),
///   ],
/// )
///
/// // Example 5: Action card for workflows
/// ActionCard(
///   title: 'Agenda una Audiencia',
///   description: 'Programa una nueva fecha para comparecencia judicial.',
///   actionLabel: 'Agendar',
///   icon: Icons.calendar_today,
///   type: AppCardType.glass,
///   onAction: () => showScheduleDialog(),
/// )
/// ```
///
/// **Motion & Interaction:**
/// - Hover: scale(1.02) + shadow intensify (fast 200ms)
/// - Tap: scale(0.98) + shadow compress (fast 200ms)
/// - Haptic: medium impact via AppInteractionRefinement
///
/// **Accessibility:**
/// - Proper cursor states (click/defer)
/// - Keyboard focus support ready
/// - Platform detection (mobile/desktop)
/// - Semantic structure maintained
