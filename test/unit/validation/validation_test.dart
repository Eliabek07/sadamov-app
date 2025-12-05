import 'package:flutter_test/flutter_test.dart';
import 'package:sadamov/view/components/form/validation/validation.dart';

void main() {
  group('Validation', () {
    group('notEmpty', () {
      test('deve retornar null para valor não vazio', () {
        final validator = notEmpty();
        expect(validator('teste'), isNull);
      });

      test('deve retornar erro para string vazia', () {
        final validator = notEmpty();
        expect(validator(''), isNotNull);
        expect(validator(''), contains('obrigatório'));
      });

      test('deve retornar erro para null', () {
        final validator = notEmpty();
        expect(validator(null), isNotNull);
        expect(validator(null), contains('obrigatório'));
      });

      test('deve usar mensagem customizada quando fornecida', () {
        final validator = notEmpty(message: 'Campo requerido');
        expect(validator(''), contains('requerido'));
      });
    });

    group('length', () {
      test('deve retornar null para valor dentro do tamanho mínimo e máximo', () {
        final validator = length(min: 3, max: 10);
        expect(validator('teste'), isNull);
      });

      test('deve retornar erro para valor menor que mínimo', () {
        final validator = length(min: 3, max: 10);
        expect(validator('ab'), isNotNull);
        expect(validator('ab'), contains('Mínimo'));
      });

      test('deve retornar erro para valor maior que máximo', () {
        final validator = length(min: 3, max: 10);
        expect(validator('teste muito longo'), isNotNull);
        expect(validator('teste muito longo'), contains('Máximo'));
      });

      test('deve retornar null para null quando não há mínimo', () {
        final validator = length(max: 10);
        expect(validator(null), isNull);
      });

      test('deve usar mensagem customizada quando fornecida', () {
        final validator = length(min: 3, message: 'Mínimo 3 caracteres');
        expect(validator('ab'), contains('Mínimo 3 caracteres'));
      });
    });

    group('validate (combinador)', () {
      test('deve retornar null quando todos os validadores passam', () {
        final validator = validate([
          notEmpty(),
          length(min: 3, max: 10),
        ]);
        expect(validator('teste'), isNull);
      });

      test('deve retornar primeiro erro encontrado', () {
        final validator = validate([
          notEmpty(),
          length(min: 3, max: 10),
        ]);
        expect(validator('ab'), contains('Mínimo'));
      });

      test('deve parar no primeiro erro', () {
        final validator = validate([
          notEmpty(),
          length(min: 3, max: 10),
        ]);
        final result = validator('');
        expect(result, isNotNull);
        expect(result, contains('obrigatório'));
      });
    });
  });
}

