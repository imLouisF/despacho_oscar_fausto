import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/routes/app_routes.dart';
import 'core/navigation/theme_switcher.dart';

/// Root widget of the application
/// Configures the MaterialApp with theme, routes, and initial settings
///
/// **Phase 9 Enhancement:**
/// Integrates ThemeModeController for A/B visual perception testing
/// with seamless animated theme switching (Corporate vs Social).
class MyApp extends StatelessWidget {
  /// Theme controller for variant management
  final ThemeModeController themeController;

  const MyApp({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    // Phase 9: AnimatedBuilder for live theme switching
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        // Select theme variant based on controller state
        final themeVariant =
            themeController.currentVariant.value == AppThemeVariant.corporate
                ? AppTheme.corporate
                : AppTheme.social;

        return ThemeControllerProvider(
          controller: themeController,
          child: MaterialApp(
            // Application title
            title: 'Despacho Oscar Fausto',

            // Theme configuration (Phase 9: A/B variants)
            theme: themeVariant.light,
            darkTheme: themeVariant.dark,
            themeMode: ThemeMode.system, // Follows system preference

            // Remove debug banner in top-right corner
            debugShowCheckedModeBanner: false,

            // Set initial route to home screen
            initialRoute: AppRoutes.home,

            // Define all application routes
            routes: AppRoutes.routes,

            // Phase 9: Smooth theme transition animation
            builder: (context, child) {
              // Phase 9.1.1: Safe error handling for ThemeSwitcher
              try {
                return Stack(
                  children: [
                    AnimatedTheme(
                      data: Theme.of(context),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      child: child!,
                    ),
                    // Phase 9.1: Theme switcher FAB with safe mount
                    ThemeSwitcher(
                      themeController: themeController,
                      style: ThemeSwitcherStyle.fab,
                    ),
                  ],
                );
              } catch (e, stackTrace) {
                // Phase 9.1.1: Fallback on error - show content without switcher
                debugPrint('[ThemeSwitcher] Build error: $e');
                debugPrint('[ThemeSwitcher] Stack trace: $stackTrace');
                return AnimatedTheme(
                  data: Theme.of(context),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  child: child!,
                );
              }
            },
          ),
        );
      },
    );
  }
}

/// InheritedWidget to provide ThemeModeController down the widget tree.
///
/// **Phase 9.1:**
/// Allows any descendant widget to access the theme controller
/// without explicit parameter passing.
class ThemeControllerProvider extends InheritedWidget {
  final ThemeModeController controller;

  const ThemeControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Access theme controller from context
  static ThemeModeController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeControllerProvider>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(ThemeControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
