/// Exceção customizada para erros de negócio
/// Utilizada para representar erros de validação e regras de negócio
class BusinessException implements Exception {
  final String message;

  /// Cria uma exceção de negócio com a mensagem especificada
  BusinessException(this.message);

  @override
  String toString() => message;
}

