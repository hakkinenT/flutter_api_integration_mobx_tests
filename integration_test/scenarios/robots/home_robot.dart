import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  const HomeRobot();

  Future<void> navigateToRegisterPage(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  Future<void> checkHomePageIsOpen(WidgetTester tester) async {
    expect(find.text("Home"), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  Future<void> checkApiResponse(WidgetTester tester) async {
    expect(find.text("quidem molestiae enim"), findsOneWidget);
  }
}
