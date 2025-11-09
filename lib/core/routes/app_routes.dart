import 'package:flutter/material.dart';
import '../../screens/agenda/agenda_screen.dart';
import '../../screens/casos/casos_screen.dart';
import '../../screens/comunicacion/comunicacion_screen.dart';
import '../../screens/formularios/formularios_screen.dart';
import '../../screens/firma/firma_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/adaptive_home/adaptive_home.dart';

/// Application routes configuration
/// Defines all route paths and their corresponding screens
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route path constants
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String agenda = '/agenda';
  static const String casos = '/casos';
  static const String comunicacion = '/comunicacion';
  static const String formularios = '/formularios';
  static const String firma = '/firma';

  /// Map of route paths to their corresponding screen builders
  ///
  /// **Phase 9.1.2 Enhancement:**
  /// Home route now uses AdaptiveHome to switch between Corporate and Social layouts
  static Map<String, WidgetBuilder> routes = {
    // Phase 9.1.2: Adaptive home switches layout based on theme variant
    home: (context) => const AdaptiveHome(userName: 'Oscar Fausto'),
    onboarding: (context) => const OnboardingScreen(),
    agenda: (context) => const AgendaScreen(),
    casos: (context) => const CasosScreen(),
    comunicacion: (context) => const ComunicacionScreen(),
    formularios: (context) => const FormulariosScreen(),
    firma: (context) => const FirmaScreen(),
  };
}