/// Brand Header — Phase 7.1
///
/// Top brand widget displaying despacho logo + title with elegant fade-in.
/// Provides professional identity for Purple Jurídico brand.
///
/// Example:
/// ```dart
/// BrandHeader()
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '_theme/ui_tokens.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// BRAND HEADER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Brand header with logo and title.
///
/// Features:
/// - Elegant fade-in animation (300ms delay)
/// - Center-aligned logo + title + subtitle
/// - Dark/light mode adaptive
/// - Professional Spanish typography
class BrandHeader extends StatefulWidget {
  /// Whether to show the logo (default: true)
  final bool showLogo;

  /// Custom logo size (default: 48.0)
  final double logoSize;

  /// Whether to animate entrance (default: true)
  final bool animate;

  const BrandHeader({
    super.key,
    this.showLogo = true,
    this.logoSize = 48.0,
    this.animate = true,
  });

  @override
  State<BrandHeader> createState() => _BrandHeaderState();
}

class _BrandHeaderState extends State<BrandHeader> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Trigger fade-in animation after delay
    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 300), () {
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
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.spacing24,
          horizontal: AppSpacing.spacing20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            if (widget.showLogo) ...[
              _buildLogo(isDark),
              const SizedBox(height: AppSpacing.spacing16),
            ],

            // Title
            Text(
              'Despacho Jurídico',
              style: AppTypography.titleLarge.copyWith(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.spacing8),

            // Subtitle
            Text(
              'Soluciones Legales Premium',
              style: AppTypography.bodySmall.copyWith(
                color: isDark
                    ? AppColors.textSecondary
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds logo widget
  Widget _buildLogo(bool isDark) {
    // Placeholder logo using icon until asset is added
    // TODO: Replace with actual logo asset: assets/logo_despacho.png
    return Container(
      width: widget.logoSize,
      height: widget.logoSize,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7E57C2), // Purple 400
            Color(0xFF512DA8), // Deep Purple 700
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        CupertinoIcons.building_2_fill,
        size: widget.logoSize * 0.5,
        color: Colors.white,
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// COMPACT BRAND HEADER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Compact version of brand header (no subtitle, smaller padding).
///
/// Use this in navigation bars or compact spaces.
class CompactBrandHeader extends StatelessWidget {
  /// Logo size (default: 32.0)
  final double logoSize;

  const CompactBrandHeader({
    super.key,
    this.logoSize = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7E57C2), // Purple 400
                Color(0xFF512DA8), // Deep Purple 700
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.building_2_fill,
            size: logoSize * 0.5,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: AppSpacing.spacing12),

        // Title
        Text(
          'Despacho Jurídico',
          style: AppTypography.titleMedium.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
