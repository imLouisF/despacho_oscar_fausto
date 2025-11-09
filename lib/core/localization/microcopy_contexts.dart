/// Microcopy Contexts — Phase 8.1.5
///
/// Defines application contexts for contextual messaging system.
/// Used to determine appropriate microcopy based on user location in the app.
///
/// Example:
/// ```dart
/// final context = AppContext.cases;
/// final message = AppStrings.contextualMessages.getMessage(context);
/// ```
library;

/// Application context enumeration for contextual messaging.
///
/// Each context represents a major screen or feature area where
/// context-specific messages, hints, or microcopy may be displayed.
///
/// **Usage:**
/// - Helps deliver relevant, contextual messages to users
/// - Enables adaptive UI copy based on current screen
/// - Supports personalized onboarding and guidance
///
/// **Phase 8.2 Implementation:**
/// This enum will be used by the `_ContextualMessages` class to
/// provide appropriate microcopy for each application context.
enum AppContext {
  /// Onboarding flow (first-time user experience)
  onboarding,

  /// Home/Dashboard screen (main landing page)
  home,

  /// Agenda/Calendar screen (appointments and deadlines)
  agenda,

  /// Cases screen (case management and tracking)
  cases,

  /// Clients screen (client directory and communication)
  clients,

  /// Profile screen (user settings and preferences)
  profile,
}
