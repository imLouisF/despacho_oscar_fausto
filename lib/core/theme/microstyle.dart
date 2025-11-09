import 'package:flutter/material.dart';

/// AppMicroStyle - Microstyle layer for Despacho Jurídico
/// 
/// The "micro-design" layer that sits beneath the main theme system.
/// Defines small but consistent design details that reinforce the
/// "Apple meets LegalTech" aesthetic throughout the app.
/// 
/// Purpose:
/// - Consistent iconography across features
/// - Standardized shadows and elevation
/// - Unified opacity and blur levels
/// - Smooth animations and motion
/// - Clean borders and corner radius
/// 
/// Usage:
/// ```dart
/// Icon(AppMicroStyle.icons['agenda'])
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
///     boxShadow: [AppMicroStyle.shadowMedium],
///   ),
/// )
/// 
/// AnimatedContainer(
///   duration: AppMicroStyle.defaultAnimationDuration,
///   curve: AppMicroStyle.defaultCurve,
/// )
/// ```
class AppMicroStyle {
  // Private constructor to prevent instantiation
  AppMicroStyle._();

  // ==================== Iconography ====================
  // Semantic icon mapping using outlined style for visual consistency
  // Use these instead of hard-coding Icons.* throughout the app

  /// Semantic icon map for all main features
  /// Use outlined icons for clean, professional appearance
  static const Map<String, IconData> icons = {
    'agenda': Icons.calendar_today_outlined,
    'casos': Icons.folder_open_outlined,
    'comunicacion': Icons.chat_bubble_outline,
    'formularios': Icons.description_outlined,
    'firma': Icons.draw_outlined,
    'configuracion': Icons.settings_outlined,
    'home': Icons.home_outlined,
    'buscar': Icons.search_outlined,
    'notificaciones': Icons.notifications_outlined,
    'perfil': Icons.person_outline,
    'mas': Icons.more_horiz_outlined,
    'cerrar': Icons.close_outlined,
    'atras': Icons.arrow_back_outlined,
    'siguiente': Icons.arrow_forward_outlined,
    'check': Icons.check_circle_outline,
    'error': Icons.error_outline,
    'info': Icons.info_outline,
    'advertencia': Icons.warning_amber_outlined,
    'descargar': Icons.download_outlined,
    'compartir': Icons.share_outlined,
    'editar': Icons.edit_outlined,
    'eliminar': Icons.delete_outline,
  };

  // ==================== Shadows ====================
  // Three-tier shadow system for consistent elevation
  // Soft → Medium → Deep for increasing visual prominence

  /// Soft shadow - Minimal elevation
  /// Use for: Hover states, subtle cards
  static const BoxShadow shadowSoft = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 3,
    offset: Offset(0, 1),
  );

  /// Medium shadow - Standard elevation
  /// Use for: Cards, buttons, modals
  static const BoxShadow shadowMedium = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.2),
    blurRadius: 6,
    offset: Offset(0, 3),
  );

  /// Deep shadow - Prominent elevation
  /// Use for: Dialogs, floating action buttons, important overlays
  static const BoxShadow shadowDeep = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    blurRadius: 12,
    offset: Offset(0, 6),
  );

  // ==================== Opacity & Blur Levels ====================
  // Standardized transparency and blur for overlays and backgrounds

  /// Low opacity - Subtle transparency
  static const double opacityLow = 0.6;

  /// Medium opacity - Standard transparency
  static const double opacityMedium = 0.8;

  /// High opacity - Minimal transparency
  static const double opacityHigh = 1.0;

  /// Light blur - Subtle background blur
  static const double blurLight = 8.0;

  /// Medium blur - Standard background blur
  static const double blurMedium = 16.0;

  // ==================== Animations & Motion ====================
  // Consistent timing and easing for all transitions
  // Apple-inspired smooth, natural motion

  /// Default animation duration
  /// Use for: Most transitions, container changes, fades
  static const Duration defaultAnimationDuration = Duration(milliseconds: 250);

  /// Fast animation duration
  /// Use for: Quick feedback, micro-interactions
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  /// Slow animation duration
  /// Use for: Page transitions, complex animations
  static const Duration slowAnimationDuration = Duration(milliseconds: 400);

  /// Default animation curve
  /// Smooth, natural easing curve inspired by Apple's motion design
  static const Curve defaultCurve = Curves.easeInOutCubic;

  /// Bounce curve
  /// Use for: Playful interactions, success feedback
  static const Curve bounceCurve = Curves.elasticOut;

  /// Hover scale factor
  /// Use for: Interactive elements on hover (web/desktop)
  static const double hoverScale = 1.02;

  /// Tap scale factor
  /// Use for: Button press feedback
  static const double tapScale = 0.97;

  // ==================== Border & Radius ====================
  // Consistent borders and corner radius across all components

  /// Thin border - Subtle dividers
  /// Use for: Separators, light boundaries
  static const BorderSide borderThin = BorderSide(
    width: 0.6,
    color: Color(0x1F000000), // Colors.black12
  );

  /// Standard border - Regular boundaries
  /// Use for: Input fields, cards, containers
  static const BorderSide borderStandard = BorderSide(
    width: 1.0,
    color: Color(0x42000000), // Colors.black26
  );

  /// Thick border - Emphasis boundaries
  /// Use for: Active states, selected items
  static const BorderSide borderThick = BorderSide(
    width: 2.0,
    color: Color(0x66000000), // Colors.black38
  );

  /// Small border radius
  /// Use for: Chips, tags, small buttons
  static const double radiusSmall = 8.0;

  /// Medium border radius
  /// Use for: Standard cards, inputs
  static const double radiusMedium = 12.0;

  /// Large border radius
  /// Use for: Large cards, modals, prominent components
  static const double radiusLarge = 16.0;

  /// Extra large border radius
  /// Use for: Bottom sheets, full-screen modals
  static const double radiusXLarge = 24.0;

  // ==================== Spacing Scale ====================
  // Consistent spacing multipliers based on 4px grid
  // Follows 8-point grid system with flexibility

  /// Extra small spacing - 4px
  static const double spaceXS = 4.0;

  /// Small spacing - 8px
  static const double spaceS = 8.0;

  /// Medium spacing - 16px
  static const double spaceM = 16.0;

  /// Large spacing - 24px
  static const double spaceL = 24.0;

  /// Extra large spacing - 32px
  static const double spaceXL = 32.0;

  /// Double extra large spacing - 48px
  static const double spaceXXL = 48.0;

  // ==================== Transition Helpers ====================
  // Pre-built transition configurations for common scenarios

  /// Fade transition builder
  /// Use for: Modal overlays, content switches
  static Widget fadeTransition(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale fade transition builder
  /// Use for: Dialog appearances, popups
  static Widget scaleFadeTransition(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: defaultCurve),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// Slide transition builder
  /// Use for: Drawer, side panels, sheets
  static Widget slideTransition(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: defaultCurve)),
      child: child,
    );
  }

  // ==================== Utility Methods ====================
  // Helper methods for common microstyle operations

  /// Get icon by semantic key
  /// Returns default icon if key not found
  static IconData getIcon(String key, {IconData? defaultIcon}) {
    return icons[key] ?? defaultIcon ?? Icons.help_outline;
  }

  /// Create rounded container decoration
  /// Quick helper for consistent container styling
  static BoxDecoration roundedContainer({
    Color? color,
    double? radius,
    BoxShadow? shadow,
    Border? border,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(radius ?? radiusMedium),
      boxShadow: shadow != null ? [shadow] : null,
      border: border,
    );
  }

  /// Create standard card decoration
  /// Pre-configured for typical card appearance
  static BoxDecoration cardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(radiusLarge),
      boxShadow: const [shadowMedium],
      border: Border.all(color: borderThin.color, width: borderThin.width),
    );
  }

  /// Create animated scale wrapper
  /// Applies hover/tap scale effects
  static Widget animatedScale({
    required Widget child,
    required bool isPressed,
    bool isHovered = false,
  }) {
    final scale = isPressed ? tapScale : (isHovered ? hoverScale : 1.0);
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: scale),
      duration: fastAnimationDuration,
      curve: defaultCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
