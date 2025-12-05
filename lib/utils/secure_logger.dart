import 'package:flutter/foundation.dart';

/// Logger seguro que substitui print() por debugPrint()
/// Fornece métodos para diferentes níveis de log (debug, error, info)
class SecureLogger {
  /// Registra mensagem de debug
  /// Aceita erro opcional e stack trace para logs detalhados
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (error != null) {
      debugPrint('🔍 DEBUG: $message $error');
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    } else {
      debugPrint('🔍 DEBUG: $message');
    }
  }

  /// Registra mensagem de erro
  /// Aceita erro opcional e stack trace para logs detalhados
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (error != null) {
      debugPrint('❌ ERROR: $message $error');
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    } else {
      debugPrint('❌ ERROR: $message');
    }
  }

  /// Registra mensagem informativa
  static void info(String message) {
    debugPrint('ℹ️ INFO: $message');
  }
}

