typedef FormFieldValidator<T> = String? Function(T? value);

FormFieldValidator<T> validate<T>(List<FormFieldValidator<T>> validators) {
  return (value) {
    for (var validator in validators) {
      var validation = validator(value);
      if (validation != null) {
        return validation;
      }
    }
    return null;
  };
}

FormFieldValidator<String> notEmpty({String? message}) {
  return (value) {
    if (value == null || value.isEmpty) {
      return message ?? 'Campo obrigatório.';
    }
    return null;
  };
}

FormFieldValidator<String> length({
  int? min,
  int? max,
  String? message,
}) {
  return (value) {
    if (value == null) return null;
    if (min != null && value.length < min) {
      return message ?? 'Mínimo de $min caracteres.';
    }
    if (max != null && value.length > max) {
      return message ?? 'Máximo de $max caracteres.';
    }
    return null;
  };
}

