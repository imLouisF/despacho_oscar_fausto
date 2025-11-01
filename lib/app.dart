import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

/// Root widget of the application
/// Configures the MaterialApp with theme, routes, and initial settings
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application title
      title: 'Despacho Oscar Fausto',
      
      // Custom theme configuration
      theme: AppTheme.lightTheme,
      
      // Remove debug banner in top-right corner
      debugShowCheckedModeBanner: false,
      
      // Set initial route to home screen
      initialRoute: AppRoutes.home,
      
      // Define all application routes
      routes: AppRoutes.routes,
    );
  }
}