# Phase 4.5.2 — Quick Reference Card

## 🚀 Fast Lookup Table

### Common Replacements

```dart
// SPACING
EdgeInsets.all(16) → AppSpacing.lg
EdgeInsets.all(24) → AppSpacing.xl
EdgeInsets.symmetric(horizontal: 16, vertical: 12) → AppSpacing.content
const SizedBox(height: 12) → const SizedBox(height: AppSpacing.spacing12)

// RADIUS
BorderRadius.circular(12) → AppRadius.medium
BorderRadius.circular(16) → AppRadius.large
BorderRadius.circular(24) → AppRadius.extraLarge

// COLORS
Color(0xFFFFFFFF) → AppColors.surface
Color(0xFF512DA8) → AppColors.primary
Color(0xFF3949AB) → AppColors.primaryDark
Color(0xFF757575) → AppColors.textSecondary
Color(0x1A512DA8) → AppColors.purpleTint

// GRADIENTS
LinearGradient(colors: [Color(0xFF512DA8), Color(0xFF3949AB)], ...) → AppColors.primaryGradient

// SHADOWS
BoxShadow(color: Color(0x1A000000), blurRadius: 3, ...) → AppShadow.soft
BoxShadow(color: Color(0x33000000), blurRadius: 12, ...) → AppShadow.strong

// TYPOGRAPHY
TextStyle(fontSize: 20, fontWeight: FontWeight.w600) → AppTypography.headlineSmall
TextStyle(fontSize: 16, fontWeight: FontWeight.w400) → AppTypography.bodyLarge
TextStyle(fontSize: 14, fontWeight: FontWeight.w500) → AppTypography.titleSmall

// MOTION
Duration(milliseconds: 200) → AppMotion.fast
Duration(milliseconds: 300) → AppMotion.normal
Curves.easeOut → AppMotion.easeOut
Curves.elasticOut → AppMotion.elastic
```

---

## 📦 Import Statement

```dart
import '_theme/ui_tokens.dart';
```

---

## 🗑️ Classes to Delete

```dart
// DELETE these entire classes:
class AppDialogColors { ... }      // app_modals.dart
class AppDialogMetrics { ... }     // app_modals.dart
class AppButtonColors { ... }      // app_buttons.dart
class AppButtonMetrics { ... }     // app_buttons.dart
class AppInputColors { ... }       // app_inputs.dart
class AppInputMetrics { ... }      // app_inputs.dart
class AppCardColors { ... }        // app_cards.dart
class AppCardMetrics { ... }       // app_cards.dart
class AppSelectColors { ... }      // app_selects.dart
class AppSelectMetrics { ... }     // app_selects.dart
class AppToggleColors { ... }      // app_toggles.dart
class AppRadioColors { ... }       // app_toggles.dart
class AppToggleMetrics { ... }     // app_toggles.dart
class AppRadioMetrics { ... }      // app_toggles.dart
```

---

## ✅ Header Comment

Add to each harmonized file:

```dart
/// ✅ Phase 4.5.2 — Harmonized with unified design tokens
```

---

## 🧪 Verification Command

```bash
flutter analyze lib/core/ui_components/
```

Expected output: `No issues found!`

---

## 📋 File Priority Order

1. `app_modals.dart` ← Start here
2. `app_buttons.dart`
3. `app_inputs.dart`
4. `app_cards.dart`
5. `app_selects.dart`
6. `app_toggles.dart`
7. `app_sheets.dart`
8. `app_forms.dart`

---

## 🎯 Token Categories

| Category | Usage |
|---|---|
| `AppSpacing.*` | All padding, margin, gaps |
| `AppRadius.*` | All border radius |
| `AppColors.*` | All colors (background, text, borders) |
| `AppShadow.*` | All box shadows |
| `AppTypography.*` | All text styles |
| `AppMotion.*` | All animation timing and curves |

---

## 💡 Tips

- Use Find & Replace for bulk changes
- Delete internal classes first
- Update imports at the top
- Run analysis after each file
- Commit after each successful file
