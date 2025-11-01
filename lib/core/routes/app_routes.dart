import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/agenda/agenda_screen.dart';
import '../../screens/casos/casos_screen.dart';
import '../../screens/comunicacion/comunicacion_screen.dart';
import '../../screens/formularios/formularios_screen.dart';
import '../../screens/firma/firma_screen.dart';

/// Application routes configuration
/// Defines all route paths and their corresponding screens
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route path constants
  static const String home = '/';
  static const String agenda = '/agenda';
  static const String casos = '/casos';
  static const String comunicacion = '/comunicacion';
  static const String formularios = '/formularios';
  static const String firma = '/firma';

  /// Map of route paths to their corresponding screen builders
  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    agenda: (context) => const AgendaScreen(),
    casos: (context) => const CasosScreen(),
    comunicacion: (context) => const ComunicacionScreen(),
    formularios: (context) => const FormulariosScreen(),
    firma: (context) => const FirmaScreen(),
  };
}