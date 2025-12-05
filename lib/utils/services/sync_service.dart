import 'dart:async';
import 'dart:io';
import 'package:workmanager/workmanager.dart';
import 'package:sadamov/model/repository/occurrence_repository.dart';
import 'package:sadamov/model/client/occurrence/occurrence_client.dart';
import 'package:sadamov/utils/secure_logger.dart';

/// Callback dispatcher para tarefas em background
/// Deve ser uma função top-level para ser acessível pelo Workmanager
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    SecureLogger.debug('🔄 [Background] Iniciando sincronização...');
    
    try {
      final repository = OccurrenceRepository();
      final client = OccurrenceClient();

      final pending = await repository.getPendingOccurrences();
      SecureLogger.debug('📦 [Background] Ocorrências pendentes: ${pending.length}');

      if (pending.isEmpty) {
        SecureLogger.debug('ℹ️ [Background] Nenhuma ocorrência pendente');
        return Future.value(true);
      }

      for (final occurrence in pending) {
        try {
          final success = await client.sendOccurrence(occurrence);

          if (success) {
            await repository.markAsSynced(occurrence.id!);
            await repository.deleteOccurrence(occurrence.id!);
            SecureLogger.debug('✅ [Background] Ocorrência ${occurrence.id} sincronizada e removida');
          } else {
            SecureLogger.debug('❌ [Background] Falha ao sincronizar ocorrência ${occurrence.id}');
          }
        } catch (e) {
          SecureLogger.error('[Background] Erro ao sincronizar ocorrência ${occurrence.id}: ', e);
        }
      }

      SecureLogger.debug('✅ [Background] Sincronização concluída');
      return Future.value(true);
    } catch (e) {
      SecureLogger.error('[Background] Erro na sincronização: ', e);
      return Future.value(false);
    }
  });
}

/// Serviço responsável por sincronização periódica de ocorrências
/// Utiliza Timer.periodic para executar sincronização a cada 7 minutos
/// Complementa com Workmanager no Android para execução em background
class SyncService {
  static const String taskName = 'syncOccurrencesTask';
  static Timer? _periodicTimer;
  static const Duration _syncInterval = Duration(minutes: 7);

  /// Inicializa o serviço de sincronização periódica
  /// Executa sincronização a cada 7 minutos (dentro do intervalo 5-10 minutos)
  static Future<void> initialize() async {
    SecureLogger.debug('🔄 Inicializando serviço de sincronização...');
    
    _periodicTimer?.cancel();
    await syncNow();
    
    _periodicTimer = Timer.periodic(_syncInterval, (_) async {
      SecureLogger.debug('⏰ Timer disparado - Iniciando sincronização periódica...');
      await syncNow();
    });
    
    SecureLogger.debug('✅ Sincronização periódica agendada (a cada ${_syncInterval.inMinutes} minutos)');
    
    if (Platform.isAndroid) {
      try {
        await Workmanager().initialize(
          callbackDispatcher,
          isInDebugMode: false,
        );
        SecureLogger.debug('✅ Workmanager inicializado');
      } catch (e) {
        SecureLogger.error('Erro ao inicializar Workmanager: ', e);
      }
    }
  }

  /// Cancela a sincronização periódica
  static void cancel() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
    SecureLogger.debug('🛑 Sincronização periódica cancelada');
  }

  /// Executa a sincronização das ocorrências pendentes
  /// Busca ocorrências não sincronizadas, tenta enviar para API simulada (70% sucesso)
  /// Em caso de sucesso: marca como sincronizada e deleta da base local
  static Future<void> syncNow() async {
    SecureLogger.debug('🔄 Iniciando sincronização...');
    
    try {
      final repository = OccurrenceRepository();
      final client = OccurrenceClient();

      final pending = await repository.getPendingOccurrences();
      SecureLogger.debug('📦 Ocorrências pendentes: ${pending.length}');

      if (pending.isEmpty) {
        SecureLogger.debug('ℹ️ Nenhuma ocorrência pendente para sincronizar');
        return;
      }

      for (final occurrence in pending) {
        try {
          final success = await client.sendOccurrence(occurrence);

          if (success) {
            await repository.markAsSynced(occurrence.id!);
            await repository.deleteOccurrence(occurrence.id!);
            SecureLogger.debug('✅ Ocorrência ${occurrence.id} sincronizada e removida');
          } else {
            SecureLogger.debug('❌ Falha ao sincronizar ocorrência ${occurrence.id}');
          }
        } catch (e) {
          SecureLogger.error('Erro ao sincronizar ocorrência ${occurrence.id}: ', e);
        }
      }
      
      SecureLogger.debug('✅ Sincronização concluída');
    } catch (e) {
      SecureLogger.error('Erro na sincronização: ', e);
    }
  }
}

