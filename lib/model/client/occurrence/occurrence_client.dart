import 'dart:math';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'package:sadamov/model/exception/business_exception.dart';
import 'package:sadamov/utils/secure_logger.dart';

class OccurrenceClient {
  final Random _random = Random();

  /// Simula envio para API (70% sucesso)
  Future<bool> sendOccurrence(OccurrenceModel occurrence) async {
    SecureLogger.debug('📤 Enviando ocorrência ${occurrence.id}...');
    
    // Simular delay de rede
    await Future.delayed(const Duration(seconds: 1));

    // 70% de chance de sucesso
    final success = _random.nextDouble() < 0.7;

    if (!success) {
      SecureLogger.debug('❌ Falha simulada no envio');
      throw BusinessException('Erro ao enviar ocorrência. Tente novamente.');
    }

    SecureLogger.debug('✅ Ocorrência enviada com sucesso');
    return true;
  }
}

