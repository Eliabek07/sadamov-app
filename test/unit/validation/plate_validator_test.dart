import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/view/components/form/validation/plate_validator.dart';

void main() {
  group('PlateValidator', () {
    test('deve retornar null para placa antiga válida (AAA-1234)', () {
      final validator = plateFieldValidator;
      expect(validator('ABC-1234'), isNull);
    });

    test('deve retornar null para placa nova válida (AAA1A23)', () {
      final validator = plateFieldValidator;
      expect(validator('ABC1A23'), isNull);
    });

    test('deve retornar null para placa com espaços (deve limpar)', () {
      final validator = plateFieldValidator;
      expect(validator('ABC 1234'), isNull);
    });

    test('deve retornar null para placa sem hífen (deve limpar)', () {
      final validator = plateFieldValidator;
      expect(validator('ABC1234'), isNull);
    });

    test('deve retornar erro para placa vazia', () {
      final validator = plateFieldValidator;
      expect(validator(''), isNotNull);
      expect(validator(''), contains('obrigatório'));
    });

    test('deve retornar erro para placa null', () {
      final validator = plateFieldValidator;
      expect(validator(null), isNotNull);
      expect(validator(null), contains('obrigatório'));
    });

    test('deve retornar erro para placa inválida (formato errado)', () {
      final validator = plateFieldValidator;
      expect(validator('ABC123'), isNotNull);
      expect(validator('ABC123'), contains('inválida'));
    });

    test('deve retornar erro para placa com menos caracteres', () {
      final validator = plateFieldValidator;
      expect(validator('AB-123'), isNotNull);
    });

    test('deve retornar erro para placa com mais caracteres', () {
      final validator = plateFieldValidator;
      expect(validator('ABCD-12345'), isNotNull);
    });

    test('deve aceitar placa em minúsculas (converte para maiúsculas)', () {
      final validator = plateFieldValidator;
      expect(validator('abc-1234'), isNull);
    });
  });
}

