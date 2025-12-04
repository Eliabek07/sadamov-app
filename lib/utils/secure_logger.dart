import 'package:flutter/foundation.dart';

class SecureLogger {
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

  static void info(String message) {
    debugPrint('ℹ️ INFO: $message');
  }
}

