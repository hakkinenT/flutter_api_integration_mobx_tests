import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_widget_integration_unit/controllers/album_controller.dart';
import 'package:flutter_test_widget_integration_unit/injection_container.dart';
import 'package:flutter_test_widget_integration_unit/pages/register_album_page.dart';
import 'package:provider/provider.dart';

Widget createRegisterAlbumPage() => Provider(
      create: (_) => sl<AlbumController>(),
      child: const MaterialApp(
        home: RegisterAlbumPage(),
      ),
    );

void main() {
  testWidgets(
    "should show a error message if none title is informed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createRegisterAlbumPage());

      await tester.enterText(find.byType(TextFormField), "");

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(find.text("Este campo é obrigatório!"), findsOneWidget);
    },
  );

  testWidgets(
    "should show a error message if title has less than 4 caracter",
    (WidgetTester tester) async {
      await tester.pumpWidget(createRegisterAlbumPage());

      await tester.enterText(find.byType(TextFormField), "tit");

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(find.text("Informe um nome válido"), findsOneWidget);
    },
  );

  testWidgets(
    "should show a error message if title has less than 4 caracter without press button",
    (WidgetTester tester) async {
      await tester.pumpWidget(createRegisterAlbumPage());

      await tester.enterText(find.byType(TextFormField), "ti");

      await tester.pump();

      expect(find.text("Informe um nome válido"), findsOneWidget);
    },
  );

  testWidgets(
    "should not show a error message if title is informed and has more than 3 caracter",
    (WidgetTester tester) async {
      await tester.pumpWidget(createRegisterAlbumPage());

      await tester.enterText(find.byType(TextFormField), "titulo");

      await tester.pump();

      expect(find.text("Este campo é obrigatório!"), findsNothing);
      expect(find.text("Informe um nome válido"), findsNothing);
    },
  );
}
