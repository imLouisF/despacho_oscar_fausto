# Purple Jurídico UI Component Library — Overview (Phase 4.5.3)

The Purple Jurídico UI Component Library is a cohesive, production-grade Flutter UI kit designed for elegant LegalTech interfaces. It unifies all visual attributes via design tokens, ensures smooth motion language, and prioritizes accessibility. Import a single index file to access all primitives, layouts, overlays, and form utilities.

Design Tokens (AppSpacing, AppRadius, AppShadow, AppTypography, AppColors, AppMotion) standardize spacing, radii, elevation, typography, color palettes, and animation timing/curves. Motion follows a calm, confident language: micro (150ms) for small interactions, fast (200ms) for toggles, normal (300ms) for main transitions, with elastic curves for soft, premium overshoot.

Accessibility is built-in: focus management for modals/sheets via PopScope, semantics-friendly labels, minimum 48px tap targets, brightness-aware color helpers, and clean text hierarchy for readability. The library embraces an iOS-inspired blur aesthetic with Deep Purple → Indigo gradients, layered soft shadows, and glassmorphism where appropriate.

## Table of Contents
- Theme Tokens: ui_tokens.dart
- Primitives: AppButton, AppTextField, AppDropdownSelect, AppSwitchToggle
- Layouts & Containers: AppCard, Extended Containers
- Overlays: AppModal, AppBottomSheet
- Forms: AppFormController, AppFormField, AppFormContainer
- Utilities: Submit buttons and helpers

## Quick Start

```dart
// Import once
import 'package:your_app/core/ui_components/ui_components_index.dart';
```

### Button + Card Example
```dart
Scaffold(
  body: Center(
    child: AppCard(
      child: Padding(
        padding: AppSpacing.card,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.spacing12),
            AppButton.primary(label: 'Create Case', onPressed: () {}),
          ],
        ),
      ),
    ),
  ),
);
```

### Form Example (Controller + Field)
```dart
final controller = AppFormController();
AppFormContainer(
  controller: controller,
  onSubmit: (values) => print(values),
  children: [
    AppFormField<String>(
      name: 'caseTitle',
      initialValue: '',
      builder: (context, state) => AppTextField(
        label: 'Case title',
        onChanged: state.didChange,
        errorText: state.errorText,
      ),
    ),
    const SizedBox(height: AppSpacing.spacing12),
    AppFormSubmitButton(label: 'Submit', icon: Icons.check, onPressed: () {
      if (controller.validateAll()) {
        // proceed
      }
    }),
  ],
);
```

## Integration Tips
- Replace all hardcoded values with tokens from ui_tokens.dart
- Use AppColors.*For(Brightness) helpers for light/dark parity
- Prefer AppMotion timing/curves for consistent motion
- For overlays, ensure PopScope handles back/ESC behavior

## Migration Notes
- Internal color/metrics classes in components have been removed in favor of ui_tokens.dart
- Replace direct Curves/Duration with AppMotion constants
- Replace hardcoded BorderRadius/EdgeInsets/BoxShadow/TextStyle with AppRadius/AppSpacing/AppShadow/AppTypography
