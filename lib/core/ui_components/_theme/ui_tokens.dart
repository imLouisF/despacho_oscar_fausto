import 'package:flutter/material.dart';

/// 🎯 UI Design Tokens - Visual Harmonization System
///
/// **Design Philosophy:**
/// "Purple Jurídico" - Elegant, clean, slightly glassy aesthetic with
/// premium Mexican tech identity. Professional authority meets calming confidence.
///
/// **Token Categories:**
/// 1. **AppSpacing** - Padding and margin scales (4px multiples)
/// 2. **AppRadius** - Corner radii for consistent roundness
/// 3. **AppShadow** - Elevation and depth language
/// 4. **AppTypography** - Text hierarchy with elegant proportions
/// 5. **AppColors** - Purple Jurídico color system with dark mode
/// 6. **AppMotion** - Timing and curves for smooth animations
///
/// **Usage:**
/// ```dart
/// Container(
///   padding: AppSpacing.md,
///   decoration: BoxDecoration(
///     color: AppColors.primary,
///     borderRadius: AppRadius.medium,
///     boxShadow: [AppShadow.soft],
///   ),
///   child: Text(
///     'Hello',
///     style: AppTypography.bodyLarge,
///   ),
/// )
/// ```

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP SPACING ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized spacing scale based on 4px grid system.
///
/// All spacing values are multiples of 4 for visual consistency.
/// Use these constants for padding, margins, and gaps throughout the app.
class AppSpacing {
  AppSpacing._();

  // ─────────────────────────── Numeric Scale ───────────────────────────

  /// 2px - Micro spacing for tight layouts
  static const double spacing2 = 2.0;

  /// 4px - Extra small spacing
  static const double spacing4 = 4.0;

  /// 8px - Small spacing
  static const double spacing8 = 8.0;

  /// 12px - Medium-small spacing
  static const double spacing12 = 12.0;

  /// 16px - Medium spacing (most common)
  static const double spacing16 = 16.0;

  /// 20px - Medium-large spacing
  static const double spacing20 = 20.0;

  /// 24px - Large spacing
  static const double spacing24 = 24.0;

  /// 32px - Extra large spacing
  static const double spacing32 = 32.0;

  /// 40px - 2XL spacing
  static const double spacing40 = 40.0;

  /// 48px - 3XL spacing
  static const double spacing48 = 48.0;

  /// 64px - 4XL spacing for major sections
  static const double spacing64 = 64.0;

  // ─────────────────────────── EdgeInsets Scale ───────────────────────────

  /// 4px - Extra small padding
  static const EdgeInsets xs = EdgeInsets.all(spacing4);

  /// 8px - Small padding
  static const EdgeInsets sm = EdgeInsets.all(spacing8);

  /// 12px - Medium-small padding
  static const EdgeInsets md = EdgeInsets.all(spacing12);

  /// 16px - Medium padding (default for most components)
  static const EdgeInsets lg = EdgeInsets.all(spacing16);

  /// 24px - Large padding
  static const EdgeInsets xl = EdgeInsets.all(spacing24);

  /// 32px - Extra large padding
  static const EdgeInsets xxl = EdgeInsets.all(spacing32);

  // ─────────────────────────── Common Patterns ───────────────────────────

  /// Standard content padding (16px horizontal, 12px vertical)
  static const EdgeInsets content = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  /// Page padding for main content areas (24px all sides)
  static const EdgeInsets page = EdgeInsets.all(spacing24);

  /// Card padding (16px all sides)
  static const EdgeInsets card = EdgeInsets.all(spacing16);

  /// Section padding for grouped content (32px vertical, 16px horizontal)
  static const EdgeInsets section = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing32,
  );

  /// Button padding (24px horizontal, 12px vertical)
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: spacing24,
    vertical: spacing12,
  );

  /// Input field padding (16px horizontal, 12px vertical)
  static const EdgeInsets input = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  /// Dialog padding (24px all sides)
  static const EdgeInsets dialog = EdgeInsets.all(spacing24);

  /// List item padding (16px horizontal, 12px vertical)
  static const EdgeInsets listItem = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  // ─────────────────────────── Responsive Helpers ───────────────────────────

  /// Get responsive horizontal padding based on screen width
  static EdgeInsets responsiveHorizontal(double screenWidth) {
    if (screenWidth < 600) {
      return const EdgeInsets.symmetric(horizontal: spacing16);
    } else if (screenWidth < 1200) {
      return const EdgeInsets.symmetric(horizontal: spacing24);
    } else {
      return const EdgeInsets.symmetric(horizontal: spacing32);
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP LAYOUT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized layout constants for 8dp grid compliance.
///
/// Phase 7.2: Mathematical aesthetic balance with consistent proportions.
/// All values follow 8dp baseline for vertical rhythm and horizontal alignment.
class AppLayout {
  AppLayout._();

  // ─────────────────────────── Grid Baseline ───────────────────────────

  /// Base grid unit (8dp) - All layout measurements are multiples of this
  static const double gridUnit = 8.0;

  /// Half grid unit (4dp) - For micro adjustments
  static const double gridHalf = 4.0;

  // ─────────────────────────── Safe Areas ───────────────────────────

  /// Standard horizontal safe area (16dp = 2 grid units)
  /// Use for primary content blocks
  static const double safeHorizontal = 16.0;

  /// Standard vertical safe area (16dp = 2 grid units)
  static const double safeVertical = 16.0;

  /// Page horizontal margin (20dp - special case for page edges)
  static const double pageHorizontal = 20.0;

  /// Page vertical margin (24dp = 3 grid units)
  static const double pageVertical = 24.0;

  // ─────────────────────────── Component Spacing ───────────────────────────

  /// Gap between list items (12dp = 1.5 grid units)
  static const double listGap = 12.0;

  /// Gap between cards (16dp = 2 grid units)
  static const double cardGap = 16.0;

  /// Gap between sections (32dp = 4 grid units)
  static const double sectionGap = 32.0;

  /// Gap between major sections (48dp = 6 grid units)
  static const double majorSectionGap = 48.0;

  // ─────────────────────────── Component Dimensions ───────────────────────────

  /// Standard card height (120dp = 15 grid units)
  static const double cardHeight = 120.0;

  /// Compact card height (96dp = 12 grid units)
  static const double cardHeightCompact = 96.0;

  /// Large card height (160dp = 20 grid units)
  static const double cardHeightLarge = 160.0;

  /// Standard button height (48dp = 6 grid units)
  static const double buttonHeight = 48.0;

  /// Compact button height (40dp = 5 grid units)
  static const double buttonHeightCompact = 40.0;

  /// Standard input height (56dp = 7 grid units)
  static const double inputHeight = 56.0;

  /// App bar height (56dp = 7 grid units)
  static const double appBarHeight = 56.0;

  /// Bottom navigation height (56dp = 7 grid units)
  static const double bottomNavHeight = 56.0;

  /// Modal header height (64dp = 8 grid units)
  static const double modalHeaderHeight = 64.0;

  // ─────────────────────────── EdgeInsets Presets ───────────────────────────

  /// Standard safe area padding (16dp horizontal, 16dp vertical)
  static const EdgeInsets safeArea = EdgeInsets.symmetric(
    horizontal: safeHorizontal,
    vertical: safeVertical,
  );

  /// Page content padding (20dp horizontal, 24dp vertical)
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pageHorizontal,
    vertical: pageVertical,
  );

  /// Screen edges (16dp horizontal only)
  static const EdgeInsets screenEdges = EdgeInsets.symmetric(
    horizontal: safeHorizontal,
  );

  /// Card internal padding (16dp all sides)
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  /// List item padding (16dp horizontal, 12dp vertical)
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );

  /// Section padding (16dp horizontal, 32dp vertical)
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 32.0,
  );

  // ─────────────────────────── Responsive Breakpoints ───────────────────────────

  /// Mobile breakpoint (max width)
  static const double breakpointMobile = 600.0;

  /// Tablet breakpoint (max width)
  static const double breakpointTablet = 1200.0;

  /// Desktop breakpoint (min width)
  static const double breakpointDesktop = 1200.0;

  /// Get content max width based on screen width
  static double getContentMaxWidth(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return screenWidth;
    } else if (screenWidth < breakpointTablet) {
      return 720.0;
    } else {
      return 960.0;
    }
  }

  /// Get responsive horizontal padding
  static double getResponsiveHorizontal(double screenWidth) {
    if (screenWidth < breakpointMobile) {
      return safeHorizontal;
    } else if (screenWidth < breakpointTablet) {
      return pageHorizontal;
    } else {
      return 32.0;
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP RADIUS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized corner radius scale for consistent roundness.
///
/// Use these values for all border radius applications to maintain
/// visual harmony across components.
class AppRadius {
  AppRadius._();

  // ─────────────────────────── Numeric Scale ───────────────────────────

  /// 4px - Extra small radius for subtle roundness
  static const double xs = 4.0;

  /// 8px - Small radius for tight elements
  static const double sm = 8.0;

  /// 12px - Medium-small radius for buttons and chips
  static const double md = 12.0;

  /// 16px - Medium radius (default for cards and inputs)
  static const double lg = 16.0;

  /// 20px - Medium-large radius
  static const double xl = 20.0;

  /// 24px - Large radius for modals and dialogs
  static const double xxl = 24.0;

  /// 32px - Extra large radius for prominent elements
  static const double xxxl = 32.0;

  /// 9999px - Full circular radius
  static const double full = 9999.0;

  // ─────────────────────────── Radius Objects ───────────────────────────

  /// 4px circular radius
  static const Radius radiusXs = Radius.circular(xs);

  /// 8px circular radius
  static const Radius radiusSm = Radius.circular(sm);

  /// 12px circular radius
  static const Radius radiusMd = Radius.circular(md);

  /// 16px circular radius
  static const Radius radiusLg = Radius.circular(lg);

  /// 24px circular radius
  static const Radius radiusXxl = Radius.circular(xxl);

  /// Full circular radius
  static const Radius radiusFull = Radius.circular(full);

  // ─────────────────────────── BorderRadius Objects ───────────────────────────

  /// 4px - Extra small border radius
  static const BorderRadius small = BorderRadius.all(radiusXs);

  /// 8px - Small border radius for chips
  static const BorderRadius smallMedium = BorderRadius.all(radiusSm);

  /// 12px - Medium-small border radius for buttons
  static const BorderRadius medium = BorderRadius.all(radiusMd);

  /// 16px - Medium border radius (default for cards and inputs)
  static const BorderRadius large = BorderRadius.all(radiusLg);

  /// 24px - Large border radius for modals and dialogs
  static const BorderRadius extraLarge = BorderRadius.all(radiusXxl);

  /// Full circular border radius
  static const BorderRadius circular = BorderRadius.all(radiusFull);

  // ─────────────────────────── Common Patterns ───────────────────────────

  /// Button radius (12px)
  static const BorderRadius button = BorderRadius.all(radiusMd);

  /// Card radius (16px)
  static const BorderRadius card = BorderRadius.all(radiusLg);

  /// Input field radius (16px)
  static const BorderRadius input = BorderRadius.all(radiusLg);

  /// Modal radius (24px)
  static const BorderRadius modal = BorderRadius.all(radiusXxl);

  /// Bottom sheet radius (24px top corners only)
  static const BorderRadius sheet = BorderRadius.vertical(
    top: radiusXxl,
  );

  /// Chip radius (full circular)
  static const BorderRadius chip = BorderRadius.all(radiusFull);
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP SHADOW ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized shadow system for consistent elevation and depth.
///
/// Shadows use subtle blur and low opacity for elegant, non-intrusive depth.
/// Purple Jurídico aesthetic favors soft, glassy elevation over harsh shadows.
class AppShadow {
  AppShadow._();

  // ─────────────────────────── Shadow Definitions ───────────────────────────

  /// No shadow - Flat surface
  static const BoxShadow none = BoxShadow(
    color: Colors.transparent,
    blurRadius: 0,
    offset: Offset.zero,
  );

  /// Soft shadow - Subtle elevation (3px blur, 1px offset)
  /// Use for: Buttons, chips, floating action buttons
  static const BoxShadow soft = BoxShadow(
    color: Color(0x1A000000), // 10% black
    blurRadius: 3,
    offset: Offset(0, 1),
  );

  /// Medium shadow - Standard elevation (6px blur, 2px offset)
  /// Use for: Cards, raised buttons, app bars
  static const BoxShadow medium = BoxShadow(
    color: Color(0x26000000), // 15% black
    blurRadius: 6,
    offset: Offset(0, 2),
  );

  /// Strong shadow - Prominent elevation (12px blur, 4px offset)
  /// Use for: Modals, dialogs, elevated sheets
  static const BoxShadow strong = BoxShadow(
    color: Color(0x33000000), // 20% black
    blurRadius: 12,
    offset: Offset(0, 4),
  );

  /// Extra strong shadow - Maximum elevation (24px blur, 8px offset)
  /// Use for: Full-screen overlays, critical alerts
  static const BoxShadow extraStrong = BoxShadow(
    color: Color(0x40000000), // 25% black
    blurRadius: 24,
    offset: Offset(0, 8),
  );

  /// Glow shadow - Purple accent glow for focused/active states
  /// Use for: Focus indicators, active selections, premium highlights
  static const BoxShadow glow = BoxShadow(
    color: Color(0x33512DA8), // 20% Deep Purple
    blurRadius: 8,
    offset: Offset.zero,
  );

  /// Inner shadow effect - Subtle inset appearance
  /// Use for: Input fields, wells, recessed surfaces
  static const BoxShadow inner = BoxShadow(
    color: Color(0x0D000000), // 5% black
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  // ─────────────────────────── Shadow Lists ───────────────────────────

  /// Layered soft shadow (two-layer depth)
  static const List<BoxShadow> softLayered = [
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  /// Layered medium shadow (three-layer depth)
  static const List<BoxShadow> mediumLayered = [
    BoxShadow(
      color: Color(0x0D000000), // 5% black
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x26000000), // 15% black
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  /// Layered strong shadow (three-layer depth with more prominence)
  static const List<BoxShadow> strongLayered = [
    BoxShadow(
      color: Color(0x1A000000), // 10% black
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x26000000), // 15% black
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x33000000), // 20% black
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Glow with shadow combination (for premium highlighted elements)
  static const List<BoxShadow> glowWithShadow = [
    BoxShadow(
      color: Color(0x33512DA8), // 20% Deep Purple glow
      blurRadius: 8,
      offset: Offset.zero,
    ),
    BoxShadow(
      color: Color(0x1A000000), // 10% black shadow
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP TYPOGRAPHY ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized typography scale with elegant proportional rhythm.
///
/// Uses Inter font family for clean, professional readability.
/// Line heights and letter spacing are optimized for digital screens.
class AppTypography {
  AppTypography._();

  // ─────────────────────────── Font Family ───────────────────────────

  /// Base font family - Inter (neutral, professional sans-serif)
  static const String fontFamily = 'Inter';

  // ─────────────────────────── Font Weights ───────────────────────────

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ─────────────────────────── Display Styles ───────────────────────────

  /// Display Large - 57px / 64px line height / -0.25 letter spacing
  /// Use for: Splash screens, hero sections
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    height: 1.12, // 64px line height
    letterSpacing: -0.25,
    fontWeight: bold,
  );

  /// Display Medium - 45px / 52px line height / 0 letter spacing
  /// Use for: Page titles, major headings
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    height: 1.16, // 52px line height
    letterSpacing: 0,
    fontWeight: bold,
  );

  /// Display Small - 36px / 44px line height / 0 letter spacing
  /// Use for: Section titles, prominent headings
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    height: 1.22, // 44px line height
    letterSpacing: 0,
    fontWeight: semiBold,
  );

  // ─────────────────────────── Headline Styles ───────────────────────────

  /// Headline Large - 32px / 40px line height / 0 letter spacing
  /// Use for: Card titles, dialog headers
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 1.25, // 40px line height
    letterSpacing: 0,
    fontWeight: semiBold,
  );

  /// Headline Medium - 28px / 36px line height / 0 letter spacing
  /// Use for: Section headings, list group headers
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 1.29, // 36px line height
    letterSpacing: 0,
    fontWeight: semiBold,
  );

  /// Headline Small - 24px / 32px line height / 0 letter spacing
  /// Use for: Subsection headings, panel titles
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 1.33, // 32px line height
    letterSpacing: 0,
    fontWeight: medium,
  );

  // ─────────────────────────── Title Styles ───────────────────────────

  /// Title Large - 22px / 28px line height / 0 letter spacing
  /// Use for: List item titles, form section headers
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    height: 1.27, // 28px line height
    letterSpacing: 0,
    fontWeight: medium,
  );

  /// Title Medium - 16px / 24px line height / 0.15 letter spacing
  /// Use for: Button text, tab labels, input labels
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.50, // 24px line height
    letterSpacing: 0.15,
    fontWeight: medium,
  );

  /// Title Small - 14px / 20px line height / 0.1 letter spacing
  /// Use for: Secondary buttons, chip labels
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43, // 20px line height
    letterSpacing: 0.1,
    fontWeight: medium,
  );

  // ─────────────────────────── Body Styles ───────────────────────────

  /// Body Large - 16px / 24px line height / 0.5 letter spacing
  /// Use for: Primary body text, paragraphs
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.50, // 24px line height
    letterSpacing: 0.5,
    fontWeight: regular,
  );

  /// Body Medium - 14px / 20px line height / 0.25 letter spacing
  /// Use for: Secondary body text, descriptions
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43, // 20px line height
    letterSpacing: 0.25,
    fontWeight: regular,
  );

  /// Body Small - 12px / 16px line height / 0.4 letter spacing
  /// Use for: Helper text, captions
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33, // 16px line height
    letterSpacing: 0.4,
    fontWeight: regular,
  );

  // ─────────────────────────── Label Styles ───────────────────────────

  /// Label Large - 14px / 20px line height / 0.1 letter spacing
  /// Use for: Input labels, form field labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43, // 20px line height
    letterSpacing: 0.1,
    fontWeight: medium,
  );

  /// Label Medium - 12px / 16px line height / 0.5 letter spacing
  /// Use for: Secondary labels, metadata
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33, // 16px line height
    letterSpacing: 0.5,
    fontWeight: medium,
  );

  /// Label Small - 11px / 16px line height / 0.5 letter spacing
  /// Use for: Timestamps, legal text, tiny labels
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 1.45, // 16px line height
    letterSpacing: 0.5,
    fontWeight: medium,
  );
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP COLORS ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Purple Jurídico color system with light and dark mode support.
///
/// Primary gradient: Deep Purple (#512DA8) → Indigo (#3949AB)
/// Aesthetic: Professional, elegant, slightly glassy, premium Mexican tech identity
class AppColors {
  AppColors._();

  // ─────────────────────────── Primary Colors ───────────────────────────

  /// Deep Purple - Primary brand color
  static const Color primary = Color(0xFF512DA8);

  /// Indigo - Secondary gradient color
  static const Color primaryDark = Color(0xFF3949AB);

  /// Light Purple - Primary tint
  static const Color primaryLight = Color(0xFF7E57C2);

  /// Extra Light Purple - Background tint
  static const Color primaryExtraLight = Color(0xFFEDE7F6);

  // ─────────────────────────── Accent Colors ───────────────────────────

  /// Lavender - Accent color for highlights
  static const Color accent = Color(0xFFB39DDB);

  /// Light Lavender - Accent tint
  static const Color accentLight = Color(0xFFD1C4E9);

  /// Purple tint with transparency (10%)
  static const Color purpleTint = Color(0x1A512DA8);

  /// Purple tint with transparency (20%)
  static const Color purpleTint20 = Color(0x33512DA8);

  // ─────────────────────────── Semantic Colors ───────────────────────────

  /// Success green
  static const Color success = Color(0xFF43A047);

  /// Success light tint
  static const Color successLight = Color(0xFFC8E6C9);

  /// Warning amber
  static const Color warning = Color(0xFFFFA726);

  /// Warning light tint
  static const Color warningLight = Color(0xFFFFE0B2);

  /// Error red
  static const Color error = Color(0xFFE53935);

  /// Error light tint
  static const Color errorLight = Color(0xFFFFCDD2);

  /// Info blue
  static const Color info = Color(0xFF1E88E5);

  /// Info light tint
  static const Color infoLight = Color(0xFFBBDEFB);

  // ─────────────────────────── Neutral Colors (Light Mode) ───────────────────────────

  /// Text primary - Almost black
  static const Color textPrimary = Color(0xFF212121);

  /// Text secondary - Medium gray
  static const Color textSecondary = Color(0xFF757575);

  /// Text tertiary - Light gray
  static const Color textTertiary = Color(0xFF9E9E9E);

  /// Text disabled - Very light gray
  static const Color textDisabled = Color(0xFFBDBDBD);

  /// Text hint - Purple tinted gray
  static const Color textHint = Color(0x99512DA8); // 60% purple

  /// Background - White
  static const Color background = Color(0xFFFFFFFF);

  /// Background secondary - Light gray
  static const Color backgroundSecondary = Color(0xFFFAFAFA);

  /// Background tertiary - Very light gray
  static const Color backgroundTertiary = Color(0xFFF5F5F5);

  /// Surface - White (for cards, sheets)
  static const Color surface = Color(0xFFFFFFFF);

  /// Surface elevated - Slightly elevated white
  static const Color surfaceElevated = Color(0xFFFAFAFA);

  /// Divider - Light gray
  static const Color divider = Color(0xFFE0E0E0);

  /// Border - Medium light gray
  static const Color border = Color(0xFFBDBDBD);

  /// Border light - Very light gray
  static const Color borderLight = Color(0xFFE0E0E0);

  // ─────────────────────────── Dark Mode Jurídico ───────────────────────────

  /// Text primary (dark mode) - High contrast readable white
  /// Contrast ratio: 15.8:1 with backgroundDark
  static const Color textPrimaryDark = Color(0xFFE0E0E0);

  /// Text secondary (dark mode) - Soft gray for less emphasis
  /// Contrast ratio: 6.2:1 with backgroundDark
  static const Color textSecondaryDark = Color(0xFFB5B5C8);

  /// Text tertiary (dark mode) - Muted gray
  static const Color textTertiaryDark = Color(0xFF808090);

  /// Text disabled (dark mode) - Very muted
  static const Color textDisabledDark = Color(0xFF505058);

  /// Background (dark mode) - Neutral deep base
  /// Phase 8.3: Refined for "LegalTech Premium" sophistication
  static const Color backgroundDark = Color(0xFF0E0E13);

  /// Background surface gradient start - Subtle depth
  static const Color backgroundDarkGradientStart = Color(0xFF121212);

  /// Background surface gradient end - Elegant shift
  static const Color backgroundDarkGradientEnd = Color(0xFF1A1A2E);

  /// Surface (dark mode) - Slightly elevated for cards/sheets
  /// Contrast with background for visual hierarchy
  static const Color surfaceDark = Color(0xFF1E1E2F);

  /// Surface elevated (dark mode) - Higher elevation
  static const Color surfaceElevatedDark = Color(0xFF2A2A3C);

  /// Card background (dark mode) - Distinct from surface
  static const Color cardDark = Color(0xFF1E1E2F);

  /// Divider (dark mode) - Subtle separation
  static const Color dividerDark = Color(0xFF2F2F40);

  /// Border (dark mode) - Low contrast, soft
  static const Color borderDark = Color(0xFF2A2A3C);

  /// Border subtle (dark mode) - Nearly invisible
  static const Color borderDarkSubtle = Color(0xFF252535);

  // ─────────────────────────── Gradient Definitions ───────────────────────────

  /// Primary gradient (Deep Purple → Indigo)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Primary gradient (vertical)
  static const LinearGradient primaryGradientVertical = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Accent gradient (Purple → Lavender)
  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Brand gradient for large surfaces (light: 7E57C2→512DA8)
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF7E57C2), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Brand accent color (Deep Purple 700)
  static const Color brandAccent = Color(0xFF512DA8);

  /// Dark Mode Jurídico gradient (reduced brightness, 60% opacity concept)
  /// Phase 8.3: Sophisticated purple gradient for dark backgrounds
  static const LinearGradient brandGradientDark = LinearGradient(
    colors: [
      Color(0xFF6A1B9A), // Deep Purple 800 (darker, more sophisticated)
      Color(0xFF3949AB), // Indigo 600 (maintains brand connection)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Background surface gradient (dark mode) - Subtle depth
  static const LinearGradient backgroundGradientDark = LinearGradient(
    colors: [backgroundDarkGradientStart, backgroundDarkGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Shimmer overlay gradient for animated backgrounds
  /// Alpha values: 0.15–0.25 for subtle effect
  static final LinearGradient shimmerGradientDark = LinearGradient(
    colors: [
      const Color(0xFF6A1B9A).withOpacity(0.15),
      const Color(0xFF3949AB).withOpacity(0.25),
      const Color(0xFF6A1B9A).withOpacity(0.15),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 0.5, 1.0],
  );

  // ─────────────────────────── Brightness-Aware Helpers ───────────────────────────

  /// Get text primary color based on brightness
  static Color textPrimaryFor(Brightness brightness) {
    return brightness == Brightness.light ? textPrimary : textPrimaryDark;
  }

  /// Get text secondary color based on brightness
  static Color textSecondaryFor(Brightness brightness) {
    return brightness == Brightness.light ? textSecondary : textSecondaryDark;
  }

  /// Get background color based on brightness
  static Color backgroundFor(Brightness brightness) {
    return brightness == Brightness.light ? background : backgroundDark;
  }

  /// Get surface color based on brightness
  static Color surfaceFor(Brightness brightness) {
    return brightness == Brightness.light ? surface : surfaceDark;
  }

  /// Get divider color based on brightness
  static Color dividerFor(Brightness brightness) {
    return brightness == Brightness.light ? divider : dividerDark;
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP MOTION ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Standardized motion timing and curves for consistent animations.
///
/// Aligned with AppModal and AppSheet motion language.
/// Durations are intentionally shorter for snappy, premium feel.
class AppMotion {
  AppMotion._();

  // ─────────────────────────── Duration Constants ───────────────────────────

  /// 150ms - Micro interactions (hover, focus, small state changes)
  static const Duration micro = Duration(milliseconds: 150);

  /// 200ms - Fast transitions (toggles, swipes, quick animations)
  static const Duration fast = Duration(milliseconds: 200);

  /// 300ms - Normal transitions (page changes, modal open/close)
  static const Duration normal = Duration(milliseconds: 300);

  /// 400ms - Slow transitions (complex animations, sheet expansions)
  static const Duration slow = Duration(milliseconds: 400);

  /// 600ms - Extra slow (special effects, onboarding sequences)
  static const Duration extraSlow = Duration(milliseconds: 600);

  // ─────────────────────────── Curve Constants ───────────────────────────

  /// Standard ease out - Decelerating curve for natural finish
  static const Curve easeOut = Curves.easeOut;

  /// Standard ease in out - Smooth acceleration and deceleration
  static const Curve easeInOut = Curves.easeInOut;

  /// Ease out cubic - Stronger deceleration
  static const Curve easeOutCubic = Curves.easeOutCubic;

  /// Ease in cubic - Stronger acceleration
  static const Curve easeInCubic = Curves.easeInCubic;

  /// Smooth - Gentle curve for subtle transitions
  static const Curve smooth = Curves.easeInOutCubic;

  /// Elastic - Spring-like overshoot for playful feel
  static const Curve elastic = Curves.elasticOut;

  /// Bounce - Bouncy animation for attention-grabbing
  static const Curve bounce = Curves.bounceOut;

  /// Sharp - Quick, snappy transition
  static const Curve sharp = Curves.easeOutExpo;

  // ─────────────────────────── Common Animation Specs ───────────────────────────

  /// Micro animation spec (150ms, ease out)
  static AnimationController microController(TickerProvider vsync) {
    return AnimationController(
      duration: micro,
      vsync: vsync,
    );
  }

  /// Fast animation spec (200ms, ease out cubic)
  static AnimationController fastController(TickerProvider vsync) {
    return AnimationController(
      duration: fast,
      vsync: vsync,
    );
  }

  /// Normal animation spec (300ms, smooth)
  static AnimationController normalController(TickerProvider vsync) {
    return AnimationController(
      duration: normal,
      vsync: vsync,
    );
  }

  /// Slow animation spec (400ms, ease in out)
  static AnimationController slowController(TickerProvider vsync) {
    return AnimationController(
      duration: slow,
      vsync: vsync,
    );
  }

  // ─────────────────────────── Preset Animations ───────────────────────────

  /// Fade in animation (300ms)
  static Animation<double> fadeIn(AnimationController controller) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: easeOut),
    );
  }

  /// Fade out animation (250ms)
  static Animation<double> fadeOut(AnimationController controller) {
    return Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: easeIn),
    );
  }

  /// Scale up animation (300ms with elastic)
  static Animation<double> scaleUp(AnimationController controller) {
    return Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: elastic),
    );
  }

  /// Slide up animation (300ms)
  static Animation<Offset> slideUp(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: easeOutCubic),
    );
  }

  /// Ease in curve constant
  static const Curve easeIn = Curves.easeIn;
}

/// ✅ Phase 4.5.1 — Visual Harmonization Complete
///
/// **Token Categories:**
/// - **AppSpacing**: 4px grid system with common patterns
/// - **AppRadius**: Consistent roundness from 4px to full circular
/// - **AppShadow**: Soft, layered elevation with purple glow variants
/// - **AppTypography**: Inter font with Material 3 inspired scale
/// - **AppColors**: Purple Jurídico palette with dark mode support
/// - **AppMotion**: Timing (150ms-600ms) and curves for smooth animations
///
/// **Design Philosophy:**
/// "Purple Jurídico" - Professional authority meets calming confidence.
/// Elegant, clean, slightly glassy aesthetic with premium Mexican tech identity.
///
/// **Usage:**
/// All UI components should reference these tokens exclusively for
/// visual consistency. No hardcoded values in component implementations.
///
/// **Next Phase:**
/// Structural harmonization (4.5.2) will update all existing components
/// to use these unified tokens.
