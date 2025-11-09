import 'package:flutter/material.dart';
import 'app.dart';
import 'core/theme/theme_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Entry point of the application
/// Initializes theme controller and runs the MyApp widget
void main() async {
  print('[Main] 🚀 Starting Purple Jurídico...');

  WidgetsFlutterBinding.ensureInitialized();
  print('[Main] ✓ Flutter binding initialized');

  await initializeDateFormatting('es_MX', null);
  print('[Main] ✓ Date formatting initialized (es_MX)');

  // Phase 9: Initialize theme controller
  print('[Main] Initializing theme system...');
  final themeController = ThemeModeController();
  await themeController.initialize();
  print('[Main] ✓ Theme controller ready');

  print('[Main] 🌟 Launching app...');
  runApp(MyApp(themeController: themeController));
}
