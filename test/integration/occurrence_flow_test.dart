import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/main.dart';
import 'package:sadamov/core/di/app_module.dart';
import 'package:sadamov/store/occurrence/occurrence_store.dart';
import 'dart:typed_data';

void main() {
  group('Fluxo Completo de Ocorrência', () {
    late OccurrenceStore store;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      Modular.destroy();
    } catch (e) {
      // Ignora se não estiver inicializado
    }
    Modular.init(AppModule());
  });

    setUp(() {
      store = Modular.get<OccurrenceStore>();
      store.reset();
    });

    tearDown(() {
      store.reset();
    });

    testWidgets('deve completar fluxo completo: checklist → ocorrência → revisão → sucesso', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Checklist'), findsOneWidget);
      expect(find.text('Ocorrência'), findsOneWidget);

      await tester.tap(find.text('Ocorrência'));
      await tester.pumpAndSettle();

      expect(find.text('Ocorrência'), findsWidgets);
      expect(find.text('Placa Veículo'), findsOneWidget);

      final plateField = find.byType(TextFormField).first;
      await tester.enterText(plateField, 'ABC-1234');
      await tester.pump();

      expect(store.plateNumber, equals('ABC-1234'));
      expect(store.isPlateValid, isTrue);

      store.addPhoto(Uint8List.fromList([1, 2, 3, 4, 5]));
      await tester.pump();

      expect(store.hasMinimumPhotos, isTrue);
      expect(store.canProceedToNextStep, isTrue);

      final avancarButton = find.text('Avançar');
      expect(avancarButton, findsOneWidget);

      await tester.tap(avancarButton);
      await tester.pumpAndSettle();

      expect(find.text('Assinatura'), findsWidgets);
      expect(find.text('Responsável'), findsOneWidget);

      final responsibleField = find.byType(TextFormField).first;
      await tester.enterText(responsibleField, 'João Silva');
      await tester.pump();

      store.setResponsibleName('João Silva');
      store.setSignature(Uint8List.fromList([1, 2, 3, 4, 5]));

      await tester.pump();

      expect(store.canFinalize, isTrue);

      final finalizarButton = find.text('Finalizar');
      expect(finalizarButton, findsOneWidget);

      await tester.tap(finalizarButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Concluído'), findsOneWidget);
      expect(find.text('Registrado'), findsOneWidget);
    });

    testWidgets('deve validar que botão Avançar está desabilitado quando placa inválida', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Ocorrência'));
      await tester.pumpAndSettle();

      final plateField = find.byType(TextFormField).first;
      await tester.enterText(plateField, 'ABC123');
      await tester.pump();

      expect(store.isPlateValid, isFalse);
      expect(store.canProceedToNextStep, isFalse);
    });

    testWidgets('deve validar que botão Avançar está desabilitado quando não há fotos', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Ocorrência'));
      await tester.pumpAndSettle();

      final plateField = find.byType(TextFormField).first;
      await tester.enterText(plateField, 'ABC-1234');
      await tester.pump();

      expect(store.isPlateValid, isTrue);
      expect(store.hasMinimumPhotos, isFalse);
      expect(store.canProceedToNextStep, isFalse);
    });

    testWidgets('deve validar que botão Finalizar está desabilitado quando responsável vazio', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Ocorrência'));
      await tester.pumpAndSettle();

      final plateField = find.byType(TextFormField).first;
      await tester.enterText(plateField, 'ABC-1234');
      await tester.pump();

      store.addPhoto(Uint8List.fromList([1, 2, 3]));
      await tester.pump();

      await tester.tap(find.text('Avançar'));
      await tester.pumpAndSettle();

      store.setSignature(Uint8List.fromList([1, 2, 3]));

      await tester.pump();

      expect(store.responsibleName, isEmpty);
      expect(store.canFinalize, isFalse);
    });

    testWidgets('deve validar que botão Finalizar está desabilitado quando assinatura vazia', (WidgetTester tester) async {
      await tester.pumpWidget(
        ModularApp(
          module: AppModule(),
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Ocorrência'));
      await tester.pumpAndSettle();

      final plateField = find.byType(TextFormField).first;
      await tester.enterText(plateField, 'ABC-1234');
      await tester.pump();

      store.addPhoto(Uint8List.fromList([1, 2, 3]));
      await tester.pump();

      await tester.tap(find.text('Avançar'));
      await tester.pumpAndSettle();

      final responsibleField = find.byType(TextFormField).first;
      await tester.enterText(responsibleField, 'João Silva');
      await tester.pump();

      store.setResponsibleName('João Silva');

      await tester.pump();

      expect(store.signature, isNull);
      expect(store.canFinalize, isFalse);
    });
  });
}

