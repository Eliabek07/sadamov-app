import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/view/components/form/custom_text_form_field.dart';

void main() {
  group('CustomTextFormField', () {
    testWidgets('deve exibir labelText quando fornecido', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              labelText: 'Placa',
              hintText: 'Digite a placa',
            ),
          ),
        ),
      );

      expect(find.text('Placa'), findsOneWidget);
    });

    testWidgets('deve exibir hintText quando fornecido', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              hintText: 'Digite a placa',
            ),
          ),
        ),
      );

      expect(find.text('Digite a placa'), findsOneWidget);
    });

    testWidgets('deve atualizar valor quando texto é digitado', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: controller,
              hintText: 'Digite a placa',
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'ABC-1234');
      await tester.pump();

      expect(controller.text, equals('ABC-1234'));
    });

    testWidgets('deve chamar onChanged quando texto é alterado', (WidgetTester tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              hintText: 'Digite a placa',
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'ABC-1234');
      await tester.pump();

      expect(changedValue, equals('ABC-1234'));
    });

    testWidgets('deve exibir erro quando validator retorna mensagem', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextFormField(
                hintText: 'Digite a placa',
                validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Campo obrigatório'), findsOneWidget);
    });

    testWidgets('deve estar readonly quando readOnly é true', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'ABC-1234');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: controller,
              hintText: 'Digite a placa',
              readOnly: true,
            ),
          ),
        ),
      );

      final textField = find.byType(TextFormField);
      expect(textField, findsOneWidget);
      
      await tester.tap(textField);
      await tester.pump();
      
      expect(controller.text, equals('ABC-1234'));
    });
  });
}

