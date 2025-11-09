/// Contextual Toast — Phase 8.4
///
/// Elegant, dismissible toast notifications for contextual messages.
/// Designed for Purple Jurídico's LegalTech Premium aesthetic.
///
/// **Features:**
/// - Smooth fade-in/fade-out animations
/// - Auto-dismiss after configurable duration
/// - Dark mode support
/// - Professional, unobtrusive design
///
/// Example:
/// ```dart
/// ContextualToast.show(
///   context,
///   message: 'Bienvenido, abogado. Tu despacho digital te espera.',
/// );
/// ```
library;

import 'package:flutter/material.dart';
import '_theme/ui_tokens.dart';

/// Displays an elegant contextual toast message.
///
/// **Phase 8.4 Integration:**
/// - Designed for welcome messages and contextual feedback
/// - Maintains Purple Jurídico aesthetic
/// - Supports both light and dark themes
/// - Auto-dismisses with smooth fade-out
///
/// **Usage:**
/// Call `ContextualToast.show()` to display a toast message.
/// The toast will automatically dismiss after the specified duration.
class ContextualToast {
  ContextualToast._(); // Private constructor

  /// Shows a contextual toast message overlay.
  ///
  /// [context] — Current BuildContext
  /// [message] — Text to display (Spanish professional tone)
  /// [duration] — How long to show before auto-dismiss (default: 3.5s)
  /// [icon] — Optional leading icon
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 3500),
    IconData? icon,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ContextualToastWidget(
        message: message,
        duration: duration,
        icon: icon,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

/// Internal widget that renders the toast UI.
class _ContextualToastWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final IconData? icon;
  final VoidCallback onDismiss;

  const _ContextualToastWidget({
    required this.message,
    required this.duration,
    required this.onDismiss,
    this.icon,
  });

  @override
  State<_ContextualToastWidget> createState() => _ContextualToastWidgetState();
}

class _ContextualToastWidgetState extends State<_ContextualToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for entry + exit
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Fade animation (opacity)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    // Slide animation (subtle vertical motion)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Start entry animation
    _controller.forward();

    // Schedule auto-dismiss
    Future.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (mounted) {
      await _controller.reverse();
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Positioned(
      top: MediaQuery.of(context).padding.top + AppSpacing.spacing16,
      left: AppSpacing.spacing16,
      right: AppSpacing.spacing16,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spacing20,
                vertical: AppSpacing.spacing16,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark.withOpacity(0.95)
                    : AppColors.surface.withOpacity(0.95),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: isDark
                      ? AppColors.borderDark
                      : AppColors.border,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Optional leading icon
                  if (widget.icon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.spacing8),
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? AppColors.brandGradientDark
                            : AppColors.brandGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spacing12),
                  ],

                  // Message text
                  Expanded(
                    child: Text(
                      widget.message,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),

                  // Dismiss button
                  const SizedBox(width: AppSpacing.spacing8),
                  GestureDetector(
                    onTap: _dismiss,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.spacing4),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
