import 'package:sadamov/view/components/form/validation/validation.dart';

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

final plateFieldValidator = validate([
  notEmpty(),
  plateValidator(),
]);

