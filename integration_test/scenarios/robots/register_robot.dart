import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class RegisterRobot {
  const RegisterRobot();

  Future<void> enterAlbumName(WidgetTester tester, String albumName) async {
    await tester.enterText(find.byType(TextFormField), albumName);
  }

  Future<void> tapRegisterButton(WidgetTester tester) async {
    await tester.tap(find.byType(ElevatedButton));
  }

  Future<void> checkSuccessMessageIsShown(
      WidgetTester tester, String albumName) async {
    final albumNameFinder = find.byType(SnackBar);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(albumNameFinder, findsOneWidget);
  }

  Future<void> checkRequiredFieldMessageIsShown(WidgetTester tester) async {
    await tester.pump();

    expect(find.text("Este campo é obrigatório!"), findsOneWidget);
  }

  Future<void> checkInvalidFieldMessageIsShown(WidgetTester tester) async {
    await tester.pump();

    expect(find.text("Informe um nome válido"), findsOneWidget);
  }
}
