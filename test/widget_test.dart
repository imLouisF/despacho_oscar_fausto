// Basic Flutter widget test for Despacho Oscar Fausto app

import 'package:flutter_test/flutter_test.dart';
import 'package:despacho_oscar_fausto/app.dart';
import 'package:despacho_oscar_fausto/core/theme/theme_controller.dart';

void main() {
  testWidgets('App launches with theme controller', (WidgetTester tester) async {
    // Create and initialize theme controller
    final themeController = ThemeModeController();
    await themeController.initialize();

    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp(themeController: themeController));

    // Verify that the app builds without errors
    expect(find.byType(MyApp), findsOneWidget);
  });
}
