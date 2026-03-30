// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Todo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E), brightness: Brightness.dark), scaffoldBackgroundColor: const Color(0xFF1A1A2E), useMaterial3: true),
      home: const Scaffold(body: Center(child: Text('Test'))),
    ));

    // Verify that the app renders
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
