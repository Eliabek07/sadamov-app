import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:sadamov/model/repository/occurrence_repository.dart';
import 'package:sadamov/model/client/occurrence/occurrence_client.dart';
import 'package:sadamov/utils/secure_logger.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    SecureLogger.debug('🔄 Iniciando sincronização...');
    
    try {
      final repository = OccurrenceRepository();
      final client = OccurrenceClient();

      // Buscar ocorrências pendentes
      final pending = await repository.getPendingOccurrences();
      SecureLogger.debug('📦 Ocorrências pendentes: ${pending.length}');

      for (final occurrence in pending) {
        try {
          // Simular envio (70% sucesso)
          final success = await client.sendOccurrence(occurrence);

          if (success) {
            // Marcar como sincronizado e deletar
            await repository.markAsSynced(occurrence.id!);
            await repository.deleteOccurrence(occurrence.id!);
            SecureLogger.debug('✅ Ocorrência ${occurrence.id} sincronizada');
          } else {
            SecureLogger.debug('❌ Falha ao sincronizar ocorrência ${occurrence.id}');
          }
        } catch (e) {
          SecureLogger.error('Erro ao sincronizar ocorrência: ', e);
        }
      }

      return Future.value(true);
    } catch (e) {
      SecureLogger.error('Erro na sincronização: ', e);
      return Future.value(false);
    }
  });
}

class SyncService {
  static const String taskName = 'syncOccurrencesTask';

  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    // Agendar sincronização periódica (a cada 5 minutos)
    await Workmanager().registerPeriodicTask(
      taskName,
      taskName,
      frequency: const Duration(minutes: 5),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );

    SecureLogger.debug('✅ Sincronização agendada');
  }
}

