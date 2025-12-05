import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/store/occurrence/occurrence_store.dart';
import 'dart:typed_data';

void main() {
  late OccurrenceStore store;

  setUp(() {
    store = OccurrenceStore();
  });

  tearDown(() {
    store.reset();
  });

  group('OccurrenceStore', () {
    group('Plate Number', () {
      test('deve inicializar com placa vazia', () {
        expect(store.plateNumber, isEmpty);
      });

      test('deve atualizar placa quando setPlateNumber é chamado', () {
        store.setPlateNumber('ABC-1234');
        expect(store.plateNumber, equals('ABC-1234'));
      });

      test('isPlateValid deve retornar true para placa antiga válida', () {
        store.setPlateNumber('ABC-1234');
        expect(store.isPlateValid, isTrue);
      });

      test('isPlateValid deve retornar true para placa nova válida', () {
        store.setPlateNumber('ABC1A23');
        expect(store.isPlateValid, isTrue);
      });

      test('isPlateValid deve retornar false para placa inválida', () {
        store.setPlateNumber('ABC123');
        expect(store.isPlateValid, isFalse);
      });

      test('isPlateValid deve retornar false para placa vazia', () {
        expect(store.isPlateValid, isFalse);
      });
    });

    group('Photos', () {
      test('deve inicializar com lista vazia de fotos', () {
        expect(store.photos, isEmpty);
      });

      test('deve adicionar foto quando addPhoto é chamado', () {
        final photo = Uint8List.fromList([1, 2, 3]);
        store.addPhoto(photo);
        expect(store.photos.length, equals(1));
        expect(store.photos.first, equals(photo));
      });

      test('hasMinimumPhotos deve retornar false quando não há fotos', () {
        expect(store.hasMinimumPhotos, isFalse);
      });

      test('hasMinimumPhotos deve retornar true quando há pelo menos 1 foto', () {
        store.addPhoto(Uint8List.fromList([1, 2, 3]));
        expect(store.hasMinimumPhotos, isTrue);
      });

      test('deve remover foto quando removePhoto é chamado', () {
        final photo1 = Uint8List.fromList([1, 2, 3]);
        final photo2 = Uint8List.fromList([4, 5, 6]);
        store.addPhoto(photo1);
        store.addPhoto(photo2);
        expect(store.photos.length, equals(2));
        
        store.removePhoto(0);
        expect(store.photos.length, equals(1));
        expect(store.photos.first, equals(photo2));
      });

      test('removePhoto não deve fazer nada se índice inválido', () {
        store.addPhoto(Uint8List.fromList([1, 2, 3]));
        store.removePhoto(10);
        expect(store.photos.length, equals(1));
      });
    });

    group('Responsible Name', () {
      test('deve inicializar com nome vazio', () {
        expect(store.responsibleName, isEmpty);
      });

      test('deve atualizar nome quando setResponsibleName é chamado', () {
        store.setResponsibleName('João Silva');
        expect(store.responsibleName, equals('João Silva'));
      });
    });

    group('Signature', () {
      test('deve inicializar com assinatura null', () {
        expect(store.signature, isNull);
      });

      test('deve atualizar assinatura quando setSignature é chamado', () {
        final signature = Uint8List.fromList([1, 2, 3]);
        store.setSignature(signature);
        expect(store.signature, equals(signature));
      });
    });

    group('Computed Properties', () {
      test('canProceedToNextStep deve retornar false quando placa inválida', () {
        store.setPlateNumber('ABC123');
        store.addPhoto(Uint8List.fromList([1, 2, 3]));
        expect(store.canProceedToNextStep, isFalse);
      });

      test('canProceedToNextStep deve retornar false quando não há fotos', () {
        store.setPlateNumber('ABC-1234');
        expect(store.canProceedToNextStep, isFalse);
      });

      test('canProceedToNextStep deve retornar true quando tudo válido', () {
        store.setPlateNumber('ABC-1234');
        store.addPhoto(Uint8List.fromList([1, 2, 3]));
        expect(store.canProceedToNextStep, isTrue);
      });

      test('canFinalize deve retornar false quando responsável vazio', () {
        store.setResponsibleName('');
        store.setSignature(Uint8List.fromList([1, 2, 3]));
        expect(store.canFinalize, isFalse);
      });

      test('canFinalize deve retornar false quando assinatura null', () {
        store.setResponsibleName('João Silva');
        expect(store.canFinalize, isFalse);
      });

      test('canFinalize deve retornar false quando assinatura vazia', () {
        store.setResponsibleName('João Silva');
        store.setSignature(Uint8List.fromList([]));
        expect(store.canFinalize, isFalse);
      });

      test('canFinalize deve retornar true quando tudo preenchido', () {
        store.setResponsibleName('João Silva');
        store.setSignature(Uint8List.fromList([1, 2, 3]));
        expect(store.canFinalize, isTrue);
      });
    });

    group('Reset', () {
      test('reset deve limpar todos os campos', () {
        store.setPlateNumber('ABC-1234');
        store.addPhoto(Uint8List.fromList([1, 2, 3]));
        store.setResponsibleName('João Silva');
        store.setSignature(Uint8List.fromList([1, 2, 3]));

        store.reset();

        expect(store.plateNumber, isEmpty);
        expect(store.photos, isEmpty);
        expect(store.responsibleName, isEmpty);
        expect(store.signature, isNull);
      });
    });
  });
}

