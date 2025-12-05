import 'package:sadamov/view/components/form/validation/validation.dart';

/// Validador específico para placa de veículo
/// Aceita formatos antigo (AAA-1234) e novo (AAA1A23)
FormFieldValidator<String> plateValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }

    final cleanedValue = value.replaceAll(RegExp(r'[-\s]'), '').toUpperCase();
    final oldPattern = RegExp(r'^[A-Z]{3}[0-9]{4}$');
    final newPattern = RegExp(r'^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$');

    if (!oldPattern.hasMatch(cleanedValue) && 
        !newPattern.hasMatch(cleanedValue)) {
      return 'Placa inválida. Use o formato AAA-1234 ou AAA1A23.';
    }

    return null;
  };
}

/// Validador completo para campo de placa
/// Combina validação de campo obrigatório e formato de placa
final plateFieldValidator = validate([
  notEmpty(),
  plateValidator(),
]);

