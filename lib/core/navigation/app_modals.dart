/// App Modals System — Phase 6.2
///
/// Cupertino-style modal sheets for creating cases, notes, and messages.
/// Integrated with Purple Jurídico design language and smooth iOS animations.
///
/// Example:
/// ```dart
/// AppModalUtils.showNewCaseModal(
///   context,
///   onSave: (title, client, court) {
///     // Handle case creation
///   },
/// );
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_components/ui_components_index.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// NEW CASE MODAL
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Modal sheet for creating a new legal case.
///
/// Provides form fields for case title, client name, and court information.
class NewCaseModalSheet extends StatefulWidget {
  /// Callback when case is saved
  final void Function(String title, String client, String court)? onSave;

  const NewCaseModalSheet({
    super.key,
    this.onSave,
  });

  @override
  State<NewCaseModalSheet> createState() => _NewCaseModalSheetState();
}

class _NewCaseModalSheetState extends State<NewCaseModalSheet> {
  final _titleController = TextEditingController();
  final _clientController = TextEditingController();
  final _courtController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _clientController.dispose();
    _courtController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_titleController.text.isEmpty) {
      _showAlert('Por favor ingresa un título para el caso');
      return;
    }

    widget.onSave?.call(
      _titleController.text,
      _clientController.text,
      _courtController.text,
    );
    Navigator.of(context).pop();
  }

  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Campo requerido'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return _BaseModalSheet(
      title: 'Nuevo caso jurídico',
      isDark: isDark,
      primaryActionLabel: 'Guardar',
      onPrimaryAction: _handleSave,
      child: Column(
        children: [
          _ModalTextField(
            controller: _titleController,
            label: 'Título del caso',
            placeholder: 'Ej: Smith vs. Johnson',
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.spacing16),
          _ModalTextField(
            controller: _clientController,
            label: 'Cliente',
            placeholder: 'Nombre del cliente',
            isDark: isDark,
          ),
          const SizedBox(height: AppSpacing.spacing16),
          _ModalTextField(
            controller: _courtController,
            label: 'Juzgado',
            placeholder: 'Ej: Juzgado Civil 5°',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// QUICK NOTE MODAL
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Modal sheet for creating a quick note.
///
/// Provides a multiline text field for capturing notes quickly.
class QuickNoteModalSheet extends StatefulWidget {
  /// Callback when note is saved
  final void Function(String note)? onSave;

  const QuickNoteModalSheet({
    super.key,
    this.onSave,
  });

  @override
  State<QuickNoteModalSheet> createState() => _QuickNoteModalSheetState();
}

class _QuickNoteModalSheetState extends State<QuickNoteModalSheet> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_noteController.text.isEmpty) {
      _showAlert('Por favor escribe una nota');
      return;
    }

    widget.onSave?.call(_noteController.text);
    Navigator.of(context).pop();
  }

  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Campo requerido'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return _BaseModalSheet(
      title: 'Nota rápida',
      isDark: isDark,
      primaryActionLabel: 'Guardar nota',
      onPrimaryAction: _handleSave,
      child: _ModalTextField(
        controller: _noteController,
        label: 'Contenido',
        placeholder: 'Escribe tu nota aquí...',
        isDark: isDark,
        maxLines: 6,
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// CLIENT MESSAGE MODAL
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Modal sheet for sending a client message.
///
/// Provides recipient selection and message composition.
class ClientMessageModalSheet extends StatefulWidget {
  /// Callback when message is sent
  final void Function(String recipient, String message)? onSend;

  const ClientMessageModalSheet({
    super.key,
    this.onSend,
  });

  @override
  State<ClientMessageModalSheet> createState() =>
      _ClientMessageModalSheetState();
}

class _ClientMessageModalSheetState extends State<ClientMessageModalSheet> {
  final _messageController = TextEditingController();
  String _selectedRecipient = 'García Corp';

  final List<String> _recipients = [
    'García Corp',
    'Industrias Medina',
    'Familia López',
    'Constructora Silva',
    'TechStart Solutions',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_messageController.text.isEmpty) {
      _showAlert('Por favor escribe un mensaje');
      return;
    }

    widget.onSend?.call(_selectedRecipient, _messageController.text);
    Navigator.of(context).pop();
  }

  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Campo requerido'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showRecipientPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(
              initialItem: _recipients.indexOf(_selectedRecipient),
            ),
            onSelectedItemChanged: (index) {
              setState(() => _selectedRecipient = _recipients[index]);
            },
            children: _recipients
                .map((name) => Center(child: Text(name)))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return _BaseModalSheet(
      title: 'Mensaje al cliente',
      isDark: isDark,
      primaryActionLabel: 'Enviar mensaje',
      onPrimaryAction: _handleSend,
      child: Column(
        children: [
          // Recipient selector
          GestureDetector(
            onTap: _showRecipientPicker,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.spacing12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceDark
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: (isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary)
                      .withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Para: ',
                    style: AppTypography.bodyMedium.copyWith(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _selectedRecipient,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 16,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spacing16),
          _ModalTextField(
            controller: _messageController,
            label: 'Mensaje',
            placeholder: 'Escribe tu mensaje aquí...',
            isDark: isDark,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// BASE MODAL SHEET
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Base modal sheet structure with common header, content, and footer.
///
/// Provides consistent Purple Jurídico styling across all modals.
class _BaseModalSheet extends StatelessWidget {
  final String title;
  final bool isDark;
  final String primaryActionLabel;
  final VoidCallback onPrimaryAction;
  final Widget child;

  const _BaseModalSheet({
    required this.title,
    required this.isDark,
    required this.primaryActionLabel,
    required this.onPrimaryAction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              _buildGradientDivider(),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing20),
                child: child,
              ),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds modal header with title and close button
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.spacing20,
        AppSpacing.spacing16,
        AppSpacing.spacing12,
        AppSpacing.spacing12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTypography.titleLarge.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(
              CupertinoIcons.xmark_circle_fill,
              color: isDark ? AppColors.textSecondary : AppColors.textSecondary,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds gradient divider accent line
  Widget _buildGradientDivider() {
    return Container(
      height: 4,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  /// Builds modal footer with action button
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.spacing20,
        AppSpacing.spacing12,
        AppSpacing.spacing20,
        AppSpacing.spacing20,
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing12),
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.md),
        onPressed: onPrimaryAction,
        child: Text(
          primaryActionLabel,
          style: AppTypography.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// MODAL TEXT FIELD
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Reusable text field for modal forms.
///
/// Styled with Purple Jurídico design tokens and Cupertino components.
class _ModalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final bool isDark;
  final int maxLines;

  const _ModalTextField({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.isDark,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing8),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          maxLines: maxLines,
          padding: const EdgeInsets.all(AppSpacing.spacing12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: (isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary)
                  .withOpacity(0.2),
            ),
          ),
          style: AppTypography.bodyMedium.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
          placeholderStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// MODAL UTILITIES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Utility functions for showing modal sheets.
///
/// Provides consistent presentation with blur backdrop and smooth animations.
class AppModalUtils {
  AppModalUtils._();

  /// Shows the New Case modal sheet
  static Future<void> showNewCaseModal(
    BuildContext context, {
    void Function(String title, String client, String court)? onSave,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => NewCaseModalSheet(onSave: onSave),
    );
  }

  /// Shows the Quick Note modal sheet
  static Future<void> showQuickNoteModal(
    BuildContext context, {
    void Function(String note)? onSave,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => QuickNoteModalSheet(onSave: onSave),
    );
  }

  /// Shows the Client Message modal sheet
  static Future<void> showClientMessageModal(
    BuildContext context, {
    void Function(String recipient, String message)? onSend,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => ClientMessageModalSheet(onSend: onSend),
    );
  }
}
