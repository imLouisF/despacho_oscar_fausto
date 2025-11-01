// Basic Flutter widget test for Despacho Oscar Fausto app

import 'package:flutter_test/flutter_test.dart';
import 'package:despacho_oscar_fausto/app.dart';

void main() {
  testWidgets('App launches and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title appears
    expect(find.text('Despacho Oscar Fausto'), findsOneWidget);
    expect(find.text('Home Screen'), findsOneWidget);
  });
}
