import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/main.dart';
import 'package:sadamov/core/di/app_module.dart';

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      Modular.destroy();
    } catch (e) {
      // Ignora se não estiver inicializado
    }
    Modular.init(AppModule());
  });

  testWidgets('deve iniciar na tela de Checklist', (WidgetTester tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: AppModule(),
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Checklist'), findsOneWidget);
    expect(find.text('Ocorrência'), findsOneWidget);
  });
}
