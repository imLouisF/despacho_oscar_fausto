/// App Routes — Phase 6.3
///
/// Centralized routing system for Purple Jurídico with Cupertino transitions,
/// Spanish localization, and unified navigation hierarchy.
///
/// Navigation Flow:
/// ```
/// [Root]
///   ├─ /feed          → Feed Activity (tab 0)
///   ├─ /profile       → User Profile (tab 1)
///   ├─ /event_detail  → Event Detail (modal)
///   │
///   └─ [Modals]
///       ├─ /new_case        → New Legal Case Form
///       ├─ /quick_note      → Quick Note Entry
///       └─ /client_message  → Client Message Composer
/// ```
///
/// Example:
/// ```dart
/// Navigator.pushNamed(context, AppRoutes.eventDetail, arguments: event);
/// AppRouter.showNewCaseModal(context);
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_components/ui_components_index.dart';
import '../../features/feed/models/feed_event.dart';
import 'app_modals.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ROUTE DEFINITIONS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Centralized route path definitions.
///
/// All navigation paths in Purple Jurídico are defined here for consistency
/// and maintainability. Routes follow lowercase + underscore naming convention.
class AppRoutes {
  AppRoutes._();

  // ─── Core Screens ───────────────────────────────────────────────────────────

  /// Feed activity stream
  /// Displays case updates, court dates, and team activity
  /// File: lib/features/feed/widgets/feed_list.dart
  static const String feed = '/feed';

  /// User profile view
  /// Shows metrics, bio, highlights, and professional information
  /// File: lib/features/profile/profile_view.dart
  static const String profile = '/profile';

  /// Event detail modal
  /// Displays full information about a feed event
  /// Arguments: FeedEvent
  static const String eventDetail = '/event_detail';

  // ─── Modal Sheets ───────────────────────────────────────────────────────────

  /// New legal case form modal
  /// Creates new case with title, client, and court information
  /// File: lib/core/navigation/app_modals.dart (NewCaseModalSheet)
  static const String newCase = '/new_case';

  /// Quick note entry modal
  /// Captures brief notes with multiline text input
  /// File: lib/core/navigation/app_modals.dart (QuickNoteModalSheet)
  static const String quickNote = '/quick_note';

  /// Client message composer modal
  /// Sends messages to clients with recipient selection
  /// File: lib/core/navigation/app_modals.dart (ClientMessageModalSheet)
  static const String clientMessage = '/client_message';

  // ─── Route Metadata ─────────────────────────────────────────────────────────

  /// Spanish titles for navigation bars
  static const Map<String, String> titles = {
    feed: 'Actividad',
    profile: 'Perfil',
    eventDetail: 'Detalle del evento',
    newCase: 'Nuevo caso jurídico',
    quickNote: 'Nota rápida',
    clientMessage: 'Mensaje al cliente',
  };

  /// All available routes
  static const List<String> all = [
    feed,
    profile,
    eventDetail,
    newCase,
    quickNote,
    clientMessage,
  ];
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ROUTE GENERATOR
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Main route generator for the application.
///
/// Handles all named route navigation with proper transitions, titles,
/// and argument validation. Uses Cupertino-style transitions for iOS aesthetic.
class AppRouter {
  AppRouter._();

  /// Generates routes for named navigation
  ///
  /// Returns CupertinoPageRoute with:
  /// - Custom page transitions (350ms slide, 200ms fade)
  /// - Spanish titles from AppRoutes.titles
  /// - Argument validation
  /// - Error handling for unknown routes
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    switch (name) {
      // ─── Event Detail ─────────────────────────────────────────────────────
      case AppRoutes.eventDetail:
        if (args is FeedEvent) {
          return _buildCupertinoRoute(
            page: _EventDetailPage(event: args),
            title: AppRoutes.titles[AppRoutes.eventDetail]!,
            settings: settings,
          );
        }
        return _buildErrorRoute('EventDetail requires FeedEvent argument');

      // ─── Unknown Route ────────────────────────────────────────────────────
      default:
        return _buildErrorRoute('Route not found: $name');
    }
  }

  // ─── Route Builders ─────────────────────────────────────────────────────────

  /// Builds a CupertinoPageRoute with Purple Jurídico styling
  static CupertinoPageRoute<T> _buildCupertinoRoute<T>({
    required Widget page,
    required String title,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return CupertinoPageRoute<T>(
      builder: (_) => page,
      settings: settings,
      title: title,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// Builds error route for invalid navigation
  static Route<dynamic> _buildErrorRoute(String message) {
    return CupertinoPageRoute(
      builder: (_) => _ErrorPage(message: message),
    );
  }

  // ─── Modal Helpers ──────────────────────────────────────────────────────────

  /// Shows new case modal with callback
  static Future<void> showNewCaseModal(
    BuildContext context, {
    void Function(String title, String client, String court)? onSave,
  }) {
    return AppModalUtils.showNewCaseModal(context, onSave: onSave);
  }

  /// Shows quick note modal with callback
  static Future<void> showQuickNoteModal(
    BuildContext context, {
    void Function(String note)? onSave,
  }) {
    return AppModalUtils.showQuickNoteModal(context, onSave: onSave);
  }

  /// Shows client message modal with callback
  static Future<void> showClientMessageModal(
    BuildContext context, {
    void Function(String recipient, String message)? onSend,
  }) {
    return AppModalUtils.showClientMessageModal(context, onSend: onSend);
  }

  // ─── Push Helpers ───────────────────────────────────────────────────────────

  /// Pushes event detail page
  static Future<void> pushEventDetail(
    BuildContext context,
    FeedEvent event,
  ) {
    return Navigator.pushNamed(
      context,
      AppRoutes.eventDetail,
      arguments: event,
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// EVENT DETAIL PAGE
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Full-screen event detail page.
///
/// Displays comprehensive information about a feed event with Purple Jurídico
/// styling and Cupertino navigation.
class _EventDetailPage extends StatelessWidget {
  final FeedEvent event;

  const _EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Detalle del evento',
          style: AppTypography.titleMedium.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isDark
            ? AppColors.surfaceDark.withOpacity(0.8)
            : AppColors.surface.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                .withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event type badge
              _buildBadge(isDark),
              const SizedBox(height: AppSpacing.spacing16),

              // Title
              Text(
                event.title,
                style: AppTypography.headlineMedium.copyWith(
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.spacing12),

              // Timestamp
              Text(
                _formatTimestamp(event.timestamp),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.spacing24),

              // Description
              if (event.description != null) ...[
                Text(
                  'Descripción',
                  style: AppTypography.titleMedium.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing8),
                Text(
                  event.description!,
                  style: AppTypography.bodyLarge.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing24),
              ],

              // Metadata
              _buildMetadataSection(isDark),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds event type badge
  Widget _buildBadge(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing12,
        vertical: AppSpacing.spacing4,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        _getEventTypeLabel(event.type),
        style: AppTypography.labelSmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Builds metadata information section
  Widget _buildMetadataSection(bool isDark) {
    final caseId = event.metadata?['caseId'] as String?;
    final assignedTo = event.metadata?['assignedTo'] as String?;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
              .withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetadataRow('Categoría', _getCategoryLabel(event.category), isDark),
          _buildMetadataRow('Autor', event.author, isDark, isFirst: false),
          if (caseId != null) ...[
            const SizedBox(height: AppSpacing.spacing12),
            _buildMetadataRow('Caso', caseId, isDark),
          ],
          if (assignedTo != null) ...[
            const SizedBox(height: AppSpacing.spacing12),
            _buildMetadataRow('Asignado a', assignedTo, isDark),
          ],
        ],
      ),
    );
  }

  /// Builds a single metadata row
  Widget _buildMetadataRow(
    String label,
    String value,
    bool isDark, {
    bool isFirst = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : AppSpacing.spacing12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Formats timestamp for display
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Hace un momento';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  /// Gets Spanish label for event type
  String _getEventTypeLabel(FeedEventType type) {
    switch (type) {
      case FeedEventType.caseAdded:
        return 'Caso nuevo';
      case FeedEventType.documentUploaded:
        return 'Documento';
      case FeedEventType.meetingScheduled:
        return 'Reunión';
      case FeedEventType.caseClosed:
        return 'Caso cerrado';
      case FeedEventType.reminder:
        return 'Recordatorio';
      case FeedEventType.commentAdded:
        return 'Comentario';
      case FeedEventType.statusChanged:
        return 'Cambio de estado';
      case FeedEventType.clientUpdated:
        return 'Cliente actualizado';
      case FeedEventType.paymentReceived:
        return 'Pago recibido';
      case FeedEventType.hearingScheduled:
        return 'Audiencia';
    }
  }

  /// Gets Spanish label for category
  String _getCategoryLabel(FeedEventCategory category) {
    switch (category) {
      case FeedEventCategory.caseManagement:
        return 'Gestión de casos';
      case FeedEventCategory.documents:
        return 'Documentos';
      case FeedEventCategory.scheduling:
        return 'Calendario';
      case FeedEventCategory.financial:
        return 'Financiero';
      case FeedEventCategory.clientRelations:
        return 'Relaciones con clientes';
      case FeedEventCategory.courtProceedings:
        return 'Procedimientos judiciales';
      case FeedEventCategory.teamCollaboration:
        return 'Colaboración de equipo';
      case FeedEventCategory.notifications:
        return 'Notificaciones';
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ERROR PAGE
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Error page for invalid navigation.
///
/// Displayed when route generation fails or arguments are invalid.
class _ErrorPage extends StatelessWidget {
  final String message;

  const _ErrorPage({required this.message});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Error',
          style: AppTypography.titleMedium.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: isDark
            ? AppColors.surfaceDark.withOpacity(0.8)
            : AppColors.surface.withOpacity(0.8),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacing20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: AppSpacing.spacing20),
                Text(
                  'Error de navegación',
                  style: AppTypography.headlineMedium.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing24),
                CupertinoButton.filled(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Volver'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ROUTE TRANSITION CONFIG
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Transition timing and configuration.
///
/// Centralizes all animation durations for consistent motion across the app.
class AppRouteTransitions {
  AppRouteTransitions._();

  /// Page push transition duration (horizontal slide)
  /// Matches Cupertino default: ~350ms
  static const Duration pagePush = Duration(milliseconds: 350);

  /// Page pop transition duration (horizontal slide back)
  /// Matches Cupertino default: ~350ms
  static const Duration pagePop = Duration(milliseconds: 350);

  /// Modal presentation duration (slide up + fade)
  /// Matches Phase 6.2 modal system: 250ms
  static const Duration modalPresent = Duration(milliseconds: 250);

  /// Modal dismissal duration (fade out)
  /// Matches Phase 6.2 modal system: 200ms
  static const Duration modalDismiss = Duration(milliseconds: 200);

  /// Tab switch animation duration
  /// Matches Phase 6.1 navigation: ~200ms
  static const Duration tabSwitch = Duration(milliseconds: 200);

  /// Alert dialog fade duration
  /// Standard Cupertino animation
  static const Duration alertFade = Duration(milliseconds: 250);
}
