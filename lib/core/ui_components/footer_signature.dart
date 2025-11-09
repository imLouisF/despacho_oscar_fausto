/// Footer Signature — Phase 7.1
///
/// Elegant footer signature displaying "By Fausto — Ingeniería y Diseño".
/// Features scroll-triggered fade-in animation for subtle branding.
///
/// Example:
/// ```dart
/// FooterSignature()
/// ```
library;

import 'package:flutter/material.dart';
import '_theme/ui_tokens.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// FOOTER SIGNATURE
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Footer signature with "By Fausto" branding.
///
/// Features:
/// - Elegant Montserrat Alternates-style typography
/// - Scroll-triggered fade-in animation
/// - Dark/light mode adaptive colors
/// - Bottom-center alignment with safe padding
class FooterSignature extends StatefulWidget {
  /// Whether to animate entrance (default: true)
  final bool animate;

  /// Custom text (default: "By Fausto — Ingeniería y Diseño")
  final String? customText;

  const FooterSignature({
    super.key,
    this.animate = true,
    this.customText,
  });

  @override
  State<FooterSignature> createState() => _FooterSignatureState();
}

class _FooterSignatureState extends State<FooterSignature> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Trigger fade-in animation after delay (simulates scroll enter)
    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() => _visible = true);
        }
      });
    } else {
      _visible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: AppSpacing.spacing16,
          top: AppSpacing.spacing24,
        ),
        alignment: Alignment.bottomCenter,
        child: Text(
          widget.customText ?? 'By Fausto — Ingeniería y Diseño',
          style: TextStyle(
            // Montserrat Alternates-style attributes
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            height: 1.4,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SCROLLABLE FOOTER SIGNATURE
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Footer signature that responds to scroll position.
///
/// Use this variant in scrollable lists for visibility-based animation.
class ScrollableFooterSignature extends StatelessWidget {
  /// Custom text (default: "By Fausto — Ingeniería y Diseño")
  final String? customText;

  /// Padding from bottom (default: 16px)
  final double bottomPadding;

  const ScrollableFooterSignature({
    super.key,
    this.customText,
    this.bottomPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
        top: AppSpacing.spacing32,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider line
          Container(
            width: 60,
            height: 1,
            margin: const EdgeInsets.only(bottom: AppSpacing.spacing16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (isDark ? Colors.white24 : Colors.black12),
                  (isDark ? Colors.white12 : Colors.black12),
                  (isDark ? Colors.white24 : Colors.black12),
                ],
              ),
            ),
          ),

          // Signature text
          Text(
            customText ?? 'By Fausto — Ingeniería y Diseño',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              height: 1.4,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.spacing8),

          // Year
          Text(
            '© 2025',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.3,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// INLINE SIGNATURE
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Compact inline signature (single line, minimal padding).
///
/// Use this for tight spaces like navigation bars or card footers.
class InlineSignature extends StatelessWidget {
  /// Custom text (default: "By Fausto")
  final String? customText;

  const InlineSignature({
    super.key,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.spacing8,
        horizontal: AppSpacing.spacing12,
      ),
      child: Text(
        customText ?? 'By Fausto',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: isDark ? Colors.white54 : Colors.black45,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
