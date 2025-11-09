/// Auto-generated index — Phase 4.5.3
///
/// Purple Jurídico UI Component Library
/// A cohesive, token-driven UI kit with elegant motion, soft shadows, and
/// Deep Purple → Indigo gradients. Import this index to access all harmonized
/// components, design tokens, and form utilities in one place.
///
/// Usage
/// ```dart
/// import 'package:your_app/core/ui_components/ui_components_index.dart';
///
/// // Button + Card example
/// Scaffold(
///   body: Center(
///     child: AppCard(
///       child: Padding(
///         padding: AppSpacing.card,
///         child: Column(
///           mainAxisSize: MainAxisSize.min,
///           children: [
///             Text('Welcome', style: AppTypography.headlineMedium),
///             const SizedBox(height: 12),
///             AppButton.primary(label: 'Create Case', onPressed: () {}),
///           ],
///         ),
///       ),
///     ),
///   ),
/// );
///
/// // Form example
/// final controller = AppFormController();
/// AppFormContainer(
///   controller: controller,
///   onSubmit: (values) => print(values),
///   children: [
///     AppFormField<String>(
///       name: 'caseTitle',
///       initialValue: '',
///       builder: (context, state) => AppTextField(
///         label: 'Case title',
///         onChanged: state.didChange,
///         errorText: state.errorText,
///       ),
///     ),
///     const SizedBox(height: 12),
///     AppFormSubmitButton(
///       label: 'Submit',
///       icon: Icons.check,
///       onPressed: () => controller.validateAll(),
///     ),
///   ],
/// );
/// ```
library;

// Theme tokens
export '_theme/ui_tokens.dart';

// Primitives
export 'app_buttons.dart';
export 'app_inputs.dart';
export 'app_selects.dart';
export 'app_toggles.dart';

// Layouts & Containers
export 'app_cards.dart';
export 'extended_containers.dart' hide AppFormContainer;

// Overlays
export 'app_modals.dart';
export 'app_sheets.dart';

// Brand Visual System (Phase 7.1)
export 'animated_background.dart';
export 'brand_header.dart';
export 'footer_signature.dart';

// Dark Mode Jurídico Shimmer (Phase 8.3)
export 'animated_shimmer.dart';

// Contextual Messaging (Phase 8.4)
export 'contextual_toast.dart';

// Forms & Utilities
export 'app_forms.dart';

// QA / Preview (dev only)
// export 'app_components_preview.dart' show ComponentPreviewPanel; // enable in dev only
