import 'dart:math';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'package:sadamov/utils/secure_logger.dart';

/// Cliente responsável por simular comunicação com API
/// Implementa lógica de envio de ocorrências com taxa de sucesso simulada
class OccurrenceClient {
  final Random _random = Random();

  /// Simula envio para API local
  /// Retorna sucesso/falha aleatória (70% sucesso)
  /// Utiliza Future.delayed para simular delay de rede
  Future<bool> sendOccurrence(OccurrenceModel occurrence) async {
    SecureLogger.debug('📤 Enviando ocorrência ${occurrence.id}...');

    await Future.delayed(const Duration(seconds: 1));

    final success = _random.nextDouble() < 0.7;

    if (!success) {
      SecureLogger.debug(
          '❌ Falha simulada no envio da ocorrência ${occurrence.id}');
      return false;
    }

    SecureLogger.debug('✅ Ocorrência ${occurrence.id} enviada com sucesso');
    return true;
  }
}
