import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/model/client/occurrence/occurrence_client.dart';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'dart:typed_data';

void main() {
  group('OccurrenceClient', () {
    late OccurrenceClient client;
    late OccurrenceModel occurrence;

    setUp(() {
      client = OccurrenceClient();
      occurrence = OccurrenceModel(
        plate: 'ABC-1234',
        photos: [Uint8List.fromList([1, 2, 3])],
        responsibleName: 'João Silva',
        createdAt: DateTime.now(),
      );
    });

    test('sendOccurrence deve retornar Future<bool>', () async {
      final result = await client.sendOccurrence(occurrence);
      expect(result, isA<bool>());
    });

    test('sendOccurrence deve simular delay de rede', () async {
      final stopwatch = Stopwatch()..start();
      await client.sendOccurrence(occurrence);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(900));
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });

    test('sendOccurrence deve retornar sucesso ou falha (70% sucesso)', () async {
      int successCount = 0;
      int totalTests = 20;

      for (int i = 0; i < totalTests; i++) {
        final result = await client.sendOccurrence(occurrence);
        if (result) successCount++;
      }

      final successRate = successCount / totalTests;
      expect(successRate, greaterThan(0.5));
      expect(successRate, lessThan(0.9));
    }, timeout: const Timeout(Duration(minutes: 1)));

    test('sendOccurrence deve funcionar com ocorrência sem assinatura', () async {
      final occurrenceWithoutSignature = OccurrenceModel(
        plate: 'XYZ-5678',
        photos: [Uint8List.fromList([4, 5, 6])],
        createdAt: DateTime.now(),
      );

      final result = await client.sendOccurrence(occurrenceWithoutSignature);
      expect(result, isA<bool>());
    });

    test('sendOccurrence deve funcionar com múltiplas fotos', () async {
      final occurrenceWithMultiplePhotos = OccurrenceModel(
        plate: 'ABC-1234',
        photos: [
          Uint8List.fromList([1, 2, 3]),
          Uint8List.fromList([4, 5, 6]),
          Uint8List.fromList([7, 8, 9]),
        ],
        createdAt: DateTime.now(),
      );

      final result = await client.sendOccurrence(occurrenceWithMultiplePhotos);
      expect(result, isA<bool>());
    });
  });
}

