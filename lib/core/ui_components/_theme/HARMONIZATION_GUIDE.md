# Phase 4.5.2 — Structural Harmonization Guide

## 🎯 Objective
Replace all hardcoded visual values in UI components with unified design tokens from `ui_tokens.dart`.

---

## 📋 Harmonization Mapping Reference

### **1. Spacing Replacements**

| Hardcoded Value | Replace With | Usage |
|---|---|---|
| `EdgeInsets.all(4)` | `AppSpacing.xs` | Minimal padding |
| `EdgeInsets.all(8)` | `AppSpacing.sm` | Small padding |
| `EdgeInsets.all(12)` | `AppSpacing.md` | Medium-small padding |
| `EdgeInsets.all(16)` | `AppSpacing.lg` | Standard padding |
| `EdgeInsets.all(24)` | `AppSpacing.xl` | Large padding |
| `EdgeInsets.all(32)` | `AppSpacing.xxl` | Extra large padding |
| `EdgeInsets.symmetric(horizontal: 16, vertical: 12)` | `AppSpacing.content` | Content padding |
| `EdgeInsets.symmetric(horizontal: 24, vertical: 12)` | `AppSpacing.button` | Button padding |
| `const SizedBox(height: 8)` | `const SizedBox(height: AppSpacing.spacing8)` | Vertical gap |
| `const SizedBox(height: 12)` | `const SizedBox(height: AppSpacing.spacing12)` | Vertical gap |
| `const SizedBox(height: 16)` | `const SizedBox(height: AppSpacing.spacing16)` | Vertical gap |
| `const SizedBox(height: 24)` | `const SizedBox(height: AppSpacing.spacing24)` | Vertical gap |
| `const SizedBox(width: 12)` | `const SizedBox(width: AppSpacing.spacing12)` | Horizontal gap |

### **2. Radius Replacements**

| Hardcoded Value | Replace With | Usage |
|---|---|---|
| `BorderRadius.circular(8)` | `AppRadius.smallMedium` | Small radius |
| `BorderRadius.circular(12)` | `AppRadius.medium` | Button radius |
| `BorderRadius.circular(16)` | `AppRadius.large` | Card/input radius |
| `BorderRadius.circular(20)` | `BorderRadius.circular(AppRadius.xl)` | Large radius |
| `BorderRadius.circular(24)` | `AppRadius.extraLarge` | Modal radius |
| `Radius.circular(12)` | `AppRadius.radiusMd` | Radius object |
| `Radius.circular(16)` | `AppRadius.radiusLg` | Radius object |
| `Radius.circular(24)` | `AppRadius.radiusXxl` | Radius object |
| `BorderRadius.vertical(top: Radius.circular(24))` | `AppRadius.sheet` | Bottom sheet |
| `BorderRadius.circular(9999)` | `AppRadius.circular` | Full circular |

### **3. Color Replacements**

| Hardcoded Value | Replace With | Context |
|---|---|---|
| `Color(0xFFFFFFFF)` | `AppColors.background` | Background white |
| `Color(0xFF512DA8)` | `AppColors.primary` | Deep Purple |
| `Color(0xFF3949AB)` | `AppColors.primaryDark` | Indigo |
| `Color(0xFF1A1A1A)` | `AppColors.textPrimary` | Text primary |
| `Color(0xFF212121)` | `AppColors.textPrimary` | Text primary |
| `Color(0xFF757575)` | `AppColors.textSecondary` | Text secondary |
| `Color(0xFF9E9E9E)` | `AppColors.textTertiary` | Text tertiary |
| `Color(0xFFBDBDBD)` | `AppColors.textDisabled` | Text disabled |
| `Color(0x99512DA8)` | `AppColors.textHint` | Hint text (60% purple) |
| `Color(0x1A512DA8)` | `AppColors.purpleTint` | 10% purple tint |
| `Color(0x33512DA8)` | `AppColors.purpleTint20` | 20% purple tint |
| `Color(0xFFE0E0E0)` | `AppColors.divider` | Divider color |
| `Color(0xFFF5F5F5)` | `AppColors.backgroundTertiary` | Light gray background |
| `Color(0xFFFAFAFA)` | `AppColors.backgroundSecondary` | Very light gray |
| `Color(0xFFD32F2F)` | `AppColors.error` | Error red |
| `Color(0xFFE53935)` | `AppColors.error` | Error red |
| `Color(0xFF43A047)` | `AppColors.success` | Success green |
| `Colors.white` | `AppColors.background` | White surface |
| `Colors.black` | `AppColors.textPrimary` | Black text |

### **4. Gradient Replacements**

| Hardcoded Value | Replace With |
|---|---|
| `LinearGradient(colors: [Color(0xFF512DA8), Color(0xFF3949AB)], begin: Alignment.centerLeft, end: Alignment.centerRight)` | `AppColors.primaryGradient` |
| `LinearGradient(colors: [Color(0xFF512DA8), Color(0xFF3949AB)], begin: Alignment.topCenter, end: Alignment.bottomCenter)` | `AppColors.primaryGradientVertical` |
| `LinearGradient(colors: [Color(0xFF512DA8), Color(0xFFB39DDB)], ...)` | `AppColors.accentGradient` |

### **5. Shadow Replacements**

| Hardcoded Value | Replace With | Usage |
|---|---|---|
| `BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 1))` | `AppShadow.soft` | Subtle elevation |
| `BoxShadow(color: Color(0x26000000), blurRadius: 6, offset: Offset(0, 2))` | `AppShadow.medium` | Standard elevation |
| `BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4))` | `AppShadow.strong` | Prominent elevation |
| `BoxShadow(color: Color(0x40000000), blurRadius: 24, offset: Offset(0, 8))` | `AppShadow.extraStrong` | Maximum elevation |
| `BoxShadow(color: Color(0x33512DA8), blurRadius: 8, offset: Offset.zero)` | `AppShadow.glow` | Purple glow |
| `[BoxShadow(...), BoxShadow(...)]` | `AppShadow.mediumLayered` | Layered shadows |
| `[BoxShadow(...), BoxShadow(...)]` | `AppShadow.strongLayered` | Strong layered |

### **6. Typography Replacements**

| Hardcoded Value | Replace With | Usage |
|---|---|---|
| `TextStyle(fontSize: 57, fontWeight: FontWeight.w700)` | `AppTypography.displayLarge` | Hero text |
| `TextStyle(fontSize: 45, fontWeight: FontWeight.w700)` | `AppTypography.displayMedium` | Page titles |
| `TextStyle(fontSize: 36, fontWeight: FontWeight.w600)` | `AppTypography.displaySmall` | Section titles |
| `TextStyle(fontSize: 32, fontWeight: FontWeight.w600)` | `AppTypography.headlineLarge` | Card titles |
| `TextStyle(fontSize: 28, fontWeight: FontWeight.w600)` | `AppTypography.headlineMedium` | Section headings |
| `TextStyle(fontSize: 24, fontWeight: FontWeight.w500)` | `AppTypography.headlineSmall` | Panel titles |
| `TextStyle(fontSize: 22, fontWeight: FontWeight.w500)` | `AppTypography.titleLarge` | List titles |
| `TextStyle(fontSize: 20, fontWeight: FontWeight.w600)` | `AppTypography.headlineSmall` | Dialog titles |
| `TextStyle(fontSize: 16, fontWeight: FontWeight.w600)` | `AppTypography.titleMedium` | Button text |
| `TextStyle(fontSize: 16, fontWeight: FontWeight.w400)` | `AppTypography.bodyLarge` | Body text |
| `TextStyle(fontSize: 14, fontWeight: FontWeight.w500)` | `AppTypography.titleSmall` | Labels |
| `TextStyle(fontSize: 14, fontWeight: FontWeight.w400)` | `AppTypography.bodyMedium` | Secondary text |
| `TextStyle(fontSize: 12, fontWeight: FontWeight.w400)` | `AppTypography.bodySmall` | Helper text |
| `TextStyle(fontSize: 11, fontWeight: FontWeight.w500)` | `AppTypography.labelSmall` | Tiny labels |

### **7. Motion Replacements**

| Hardcoded Value | Replace With | Usage |
|---|---|---|
| `Duration(milliseconds: 150)` | `AppMotion.micro` | Micro interactions |
| `Duration(milliseconds: 200)` | `AppMotion.fast` | Fast transitions |
| `Duration(milliseconds: 250)` | `AppMotion.fast` | Fast transitions |
| `Duration(milliseconds: 300)` | `AppMotion.normal` | Normal transitions |
| `Duration(milliseconds: 400)` | `AppMotion.slow` | Slow transitions |
| `Curves.easeOut` | `AppMotion.easeOut` | Ease out curve |
| `Curves.easeInOut` | `AppMotion.easeInOut` | Ease in out |
| `Curves.easeOutCubic` | `AppMotion.easeOutCubic` | Strong deceleration |
| `Curves.easeInCubic` | `AppMotion.easeInCubic` | Strong acceleration |
| `Curves.easeInOutCubic` | `AppMotion.smooth` | Smooth curve |
| `Curves.elasticOut` | `AppMotion.elastic` | Spring-like |

---

## 🔧 Component-Specific Updates

### **app_modals.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppDialogColors class entirely
// DELETE AppDialogMetrics class entirely

// REPLACE in AppDialog:
padding: AppSpacing.dialog,  // was EdgeInsets.all(24)
borderRadius: AppRadius.modal,  // was BorderRadius.circular(24)
margin: AppSpacing.xl,  // was EdgeInsets.symmetric(horizontal: 24)
boxShadow: AppShadow.extraStrong,  // was manual BoxShadow

// REPLACE text styles:
style: AppTypography.headlineSmall,  // for title (was fontSize: 20)
style: AppTypography.bodyLarge,  // for message (was fontSize: 16)

// REPLACE colors:
color: AppColors.surface,  // was Color(0xFFFFFFFF)
color: AppColors.textPrimary,  // was Color(0xFF1A1A1A)
color: AppColors.textSecondary,  // was Color(0xFF757575)
gradient: AppColors.primaryGradient,  // for primary button

// REPLACE button padding:
padding: AppSpacing.button,  // was EdgeInsets.symmetric(horizontal: 24, vertical: 12)
borderRadius: AppRadius.medium,  // was BorderRadius.circular(12)
```

### **app_buttons.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppButtonColors class
// DELETE AppButtonMetrics class

// REPLACE:
borderRadius: AppRadius.button,  // was BorderRadius.circular(12/16/20)
padding: AppSpacing.button,  // was EdgeInsets.symmetric
gradient: AppColors.primaryGradient,  // for primary buttons
boxShadow: AppShadow.soft,  // for elevation
color: AppColors.primary,  // for fills
color: AppColors.textSecondary,  // for secondary text
style: AppTypography.titleMedium,  // for button text
duration: AppMotion.fast,  // was Duration(milliseconds: 200)
curve: AppMotion.easeOut,  // was Curves.easeOut
```

### **app_inputs.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppInputColors class
// DELETE AppInputMetrics class

// REPLACE:
borderRadius: AppRadius.input,  // was BorderRadius.circular(16)
padding: AppSpacing.input,  // was EdgeInsets.symmetric(horizontal: 16, vertical: 12)
boxShadow: AppShadow.soft,  // for focused state
color: AppColors.surface,  // for background
color: AppColors.primary,  // for focused border
color: AppColors.error,  // for error border
color: AppColors.textPrimary,  // for text
color: AppColors.textHint,  // for hint text
style: AppTypography.bodyLarge,  // for input text
style: AppTypography.labelMedium,  // for floating label
duration: AppMotion.fast,  // was Duration(milliseconds: 200/250)
```

### **app_cards.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppCardColors class
// DELETE AppCardMetrics class

// REPLACE:
borderRadius: AppRadius.card,  // was BorderRadius.circular(12/16/20/24)
padding: AppSpacing.card,  // was EdgeInsets.all(12/16/24)
margin: AppSpacing.md,  // was EdgeInsets.all(12)
boxShadow: AppShadow.soft / AppShadow.medium / AppShadow.strong,  // based on elevation
gradient: AppColors.primaryGradient,  // for gradient cards
color: AppColors.surface,  // for card background
color: AppColors.purpleTint,  // for glass tint (10%)
duration: AppMotion.normal,  // was Duration(milliseconds: 300)
```

### **app_selects.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppSelectColors class
// DELETE AppSelectMetrics class

// REPLACE:
borderRadius: AppRadius.input,  // was BorderRadius.circular(16)
borderRadius: AppRadius.medium,  // for options list (was 12)
padding: AppSpacing.input,  // for select field
padding: AppSpacing.md,  // for options (was EdgeInsets.symmetric(16, 12))
boxShadow: AppShadow.medium,  // for dropdown
color: AppColors.surface,  // for background
color: AppColors.primary,  // for focused border
color: AppColors.purpleTint,  // for selected background
style: AppTypography.bodyLarge,  // for option text
style: AppTypography.bodySmall,  // for sublabel
duration: AppMotion.normal,  // was Duration(milliseconds: 300)
duration: AppMotion.fast,  // was Duration(milliseconds: 200)
```

### **app_toggles.dart**

**Remove internal color/metrics classes, use tokens:**

```dart
// DELETE AppToggleColors class
// DELETE AppRadioColors class
// DELETE AppToggleMetrics class
// DELETE AppRadioMetrics class

// REPLACE:
gradient: AppColors.primaryGradient,  // for active toggle track
color: AppColors.primary,  // for active radio
color: AppColors.textSecondary,  // for inactive labels
style: AppTypography.bodyLarge,  // for labels
style: AppTypography.bodySmall,  // for sublabels
duration: AppMotion.normal,  // was Duration(milliseconds: 300)
```

### **app_forms.dart**

**Typography only (no internal classes to remove):**

```dart
// REPLACE text styles where hardcoded:
style: AppTypography.bodyMedium,  // for error messages (was fontSize: 12)
style: AppTypography.labelMedium,  // for labels
duration: AppMotion.fast,  // was Duration(milliseconds: 200)
```

### **app_sheets.dart**

**Remove internal metrics, use tokens:**

```dart
// No internal color classes, but replace hardcoded values:

borderRadius: AppRadius.sheet,  // was BorderRadius.vertical(top: Radius.circular(24))
padding: AppSpacing.card,  // for content padding
boxShadow: AppShadow.strong,  // for sheet elevation
color: AppColors.surface,  // for sheet background
duration: AppMotion.normal,  // was Duration(milliseconds: 300)
duration: AppMotion.fast,  // was Duration(milliseconds: 200)
curve: AppMotion.elastic,  // was Curves.elasticOut
```

---

## ✅ Validation Checklist

After updating each file:

1. **Import the tokens file:**
   ```dart
   import '_theme/ui_tokens.dart';
   ```

2. **Delete internal color/metrics classes** (if any exist)

3. **Replace all hardcoded values** using the mapping tables above

4. **Run flutter analyze** to ensure zero issues

5. **Verify visual consistency** - all components should now share the same aesthetic

6. **Check dark mode** - use `AppColors.*For(brightness)` where needed

7. **Update file header comments** to indicate Phase 4.5.2 compliance:
   ```dart
   /// ✅ Phase 4.5.2 — Harmonized with unified design tokens
   ```

---

## 🎯 Priority Order

1. **app_modals.dart** (highest visual impact)
2. **app_buttons.dart** (most frequently used)
3. **app_inputs.dart** (critical for forms)
4. **app_cards.dart** (layout foundation)
5. **app_selects.dart** (form inputs)
6. **app_toggles.dart** (form inputs)
7. **app_sheets.dart** (modal patterns)
8. **app_forms.dart** (minimal changes needed)

---

## 📝 Example: Before/After

### BEFORE (app_modals.dart):
```dart
class AppDialogColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color title = Color(0xFF1A1A1A);
  static const Color primaryStart = Color(0xFF512DA8);
}

class AppDialogMetrics {
  static const double radius = 24.0;
  static const EdgeInsets padding = EdgeInsets.all(24);
}

decoration: BoxDecoration(
  color: AppDialogColors.background,
  borderRadius: BorderRadius.circular(AppDialogMetrics.radius),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ],
),
child: Padding(
  padding: AppDialogMetrics.padding,
  child: Text(
    title!,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppDialogColors.title,
    ),
  ),
),
```

### AFTER (app_modals.dart):
```dart
// Classes deleted - using unified tokens

decoration: BoxDecoration(
  color: AppColors.surface,
  borderRadius: AppRadius.modal,
  boxShadow: AppShadow.extraStrong,
),
child: Padding(
  padding: AppSpacing.dialog,
  child: Text(
    title!,
    style: AppTypography.headlineSmall.copyWith(
      color: AppColors.textPrimary,
    ),
  ),
),
```

---

## 🚀 Completion

Once all files are harmonized:
- Run full analysis: `flutter analyze lib/core/ui_components/`
- Verify visual consistency across all components
- Update this guide's status to "COMPLETE"
- Proceed to Phase 4.5.3 (Documentation Generation)

---

**Last Updated**: Phase 4.5.2 Initial  
**Status**: Ready for Implementation  
**Target**: Zero hardcoded visual values across all UI components
