import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/view/components/button/custom_button.dart';

void main() {
  group('CustomButton', () {
    testWidgets('deve exibir texto do botão', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Teste',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Teste'), findsOneWidget);
    });

    testWidgets('deve chamar onPressed quando habilitado e clicado', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Teste',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Teste'));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('não deve chamar onPressed quando desabilitado', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Teste',
              isEnabled: false,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Teste'));
      await tester.pump();

      expect(wasPressed, isFalse);
    });

    testWidgets('deve exibir CircularProgressIndicator quando isLoading é true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Teste',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Teste'), findsNothing);
    });

    testWidgets('não deve chamar onPressed quando isLoading é true', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Teste',
              isLoading: true,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      expect(wasPressed, isFalse);
    });
  });
}

