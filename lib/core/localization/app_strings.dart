/// App Strings — Phase 8.1.5
///
/// Centralized localization and string management for Purple Jurídico.
/// Contains global app strings and contextual messaging system.
///
/// **Architecture:**
/// - `AppStrings`: Static class containing all localized strings
/// - `_ContextualMessages`: Context-aware microcopy system (Phase 8.2)
///
/// Example:
/// ```dart
/// // Global strings
/// Text(AppStrings.appName)
///
/// // Contextual messages (Phase 8.2)
/// final message = AppStrings.contextualMessages.getMessage(AppContext.cases);
/// ```
library;

import 'microcopy_contexts.dart';

/// Global application strings and localization.
///
/// **Purpose:**
/// This class serves as the single source of truth for all user-facing
/// text in the application. It enables:
/// - Consistent terminology across features
/// - Easy localization/translation in the future
/// - Centralized string management
///
/// **Structure:**
/// - Global constants (app name, common labels)
/// - Contextual messaging system via `contextualMessages`
///
/// **Future Enhancement:**
/// Can be extended to support multiple languages by implementing
/// locale-based string selection (e.g., using Flutter's `Intl` package).
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // ─────────────────────────── Global Constants ───────────────────────────

  /// Application name displayed in UI
  static const String appName = 'LegalTech Premium';

  /// Application tagline or subtitle
  static const String appTagline = 'Purple Jurídico';

  // ─────────────────────────── Contextual Messaging ───────────────────────────

  /// Contextual messaging system instance.
  ///
  /// Provides context-aware microcopy based on current app screen/feature.
  /// Will be fully implemented in Phase 8.2 with dynamic message selection.
  static final ContextualMessages contextualMessages = ContextualMessages();
}

/// Contextual messaging system for adaptive microcopy.
///
/// **Purpose:**
/// Delivers relevant, context-specific messages to users based on their
/// current location in the app. This creates a more personalized and
/// helpful user experience.
///
/// **Phase 8.2 Implementation:**
/// All contexts now include Spanish professional microcopy aligned with
/// "LegalTech Premium" tone: trust, professionalism, precision, and humanity.
///
/// **Tone Attributes:**
/// - Formal and professional
/// - Confident and serene
/// - Precise and organized
/// - Human warmth without losing formality
/// - Moderate inspiration without empty phrases
class ContextualMessages {
  /// Retrieves primary contextual message for a given app context.
  ///
  /// **Parameters:**
  /// - `context`: The current application context (enum)
  ///
  /// **Returns:**
  /// A localized, context-appropriate motivational message in Spanish.
  ///
  /// **Implementation:**
  /// Each context returns a single primary message that reflects the
  /// professional legal tone and provides contextual relevance.
  String getMessage(AppContext context) {
    switch (context) {
      case AppContext.onboarding:
        return 'Tu despacho digital comienza con orden y claridad.';
      case AppContext.home:
        return 'Organiza tu día con enfoque y precisión profesional.';
      case AppContext.agenda:
        return 'Cada cita representa un compromiso con la excelencia.';
      case AppContext.cases:
        return 'Cada caso merece atención detallada y estrategia clara.';
      case AppContext.clients:
        return 'Tus clientes confían en tu profesionalismo y dedicación.';
      case AppContext.profile:
        return 'La mejora continua define tu práctica profesional.';
    }
  }

  /// Retrieves multiple contextual messages for a given context.
  ///
  /// **Purpose:**
  /// Provides 3-5 short professional micro-messages for message rotation,
  /// tips, or contextual hints within each application area.
  ///
  /// **Returns:**
  /// List of Spanish messages suitable for sequential or random display.
  ///
  /// **Implementation:**
  /// Messages are crafted to maintain professional tone while providing
  /// practical guidance and contextual awareness.
  List<String> getMessages(AppContext context) {
    switch (context) {
      case AppContext.onboarding:
        return [
          'Configura tu espacio de trabajo con precisión desde el inicio.',
          'El orden en tu práctica inicia con buenas bases digitales.',
          'Cada herramienta está diseñada para optimizar tu gestión.',
          'La claridad en tus procesos mejora la calidad de tu servicio.',
        ];

      case AppContext.home:
        return [
          'Revisa tus prioridades y organiza tu agenda para hoy.',
          'La planificación diaria define resultados consistentes.',
          'Mantén el control de tus tareas con visión estratégica.',
          'El enfoque diario construye tu reputación profesional.',
          'Cada decisión organizada refleja tu compromiso con la excelencia.',
        ];

      case AppContext.agenda:
        return [
          'Confirma cada cita con antelación para evitar contratiempos.',
          'La puntualidad demuestra respeto hacia tus clientes.',
          'Organiza tu calendario con anticipación y claridad.',
          'Cada reunión es una oportunidad de fortalecer la confianza.',
        ];

      case AppContext.cases:
        return [
          'Documenta cada detalle para construir estrategias sólidas.',
          'La atención al detalle diferencia tu práctica profesional.',
          'Mantén actualizado el estado de cada expediente activo.',
          'La organización meticulosa previene errores y retrasos.',
          'Cada caso refleja tu compromiso con la justicia y precisión.',
        ];

      case AppContext.clients:
        return [
          'La comunicación clara fortalece la relación con tus clientes.',
          'Responde con prontitud para mantener la confianza profesional.',
          'Cada interacción refleja el valor de tu servicio legal.',
          'Documenta las conversaciones importantes para referencia futura.',
        ];

      case AppContext.profile:
        return [
          'Actualiza tu información para reflejar tu crecimiento profesional.',
          'La formación continua mejora tu capacidad de servir mejor.',
          'Revisa tus métricas para identificar áreas de mejora.',
          'Tu perfil profesional comunica tu compromiso con la excelencia.',
        ];
    }
  }

  /// Retrieves empty state message for a given context.
  ///
  /// **Purpose:**
  /// Provides helpful, non-alarming messages when lists or screens are empty,
  /// guiding users on next actions without creating unnecessary concern.
  ///
  /// **Returns:**
  /// A Spanish message appropriate for the empty state of each context.
  ///
  /// **Implementation:**
  /// Messages maintain professional tone while being informative and
  /// subtly actionable without being pushy.
  String getEmptyStateMessage(AppContext context) {
    switch (context) {
      case AppContext.onboarding:
        return 'Tu experiencia de configuración está lista para comenzar.';
      case AppContext.home:
        return 'No hay pendientes registrados en este momento.';
      case AppContext.agenda:
        return 'Tu agenda está disponible para nuevas citas.';
      case AppContext.cases:
        return 'No hay casos activos. Comienza agregando un nuevo expediente.';
      case AppContext.clients:
        return 'Tu directorio de clientes está listo para crecer.';
      case AppContext.profile:
        return 'Tu perfil profesional está configurado correctamente.';
    }
  }
}
