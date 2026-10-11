import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelpers {
  const TestHelpers._();

  static Future<void> pumpApp(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: child),
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }

  static Future<void> pumpScreen(WidgetTester tester, Widget screen) async {
    await tester.pumpWidget(MaterialApp(home: screen));
  }
}
