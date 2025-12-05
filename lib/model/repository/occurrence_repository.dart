import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'package:sadamov/utils/database/occurrence_database.dart';

/// Repositório responsável por gerenciar operações de persistência de ocorrências
/// Abstrai o acesso ao banco de dados e fornece interface de alto nível
class OccurrenceRepository {
  final OccurrenceDatabase _database = OccurrenceDatabase.instance;

  /// Salva uma ocorrência no banco de dados local
  /// Retorna o ID da ocorrência inserida
  Future<int> saveOccurrence(OccurrenceModel occurrence) async {
    return await _database.insert(occurrence);
  }

  /// Busca todas as ocorrências pendentes de sincronização
  /// Retorna lista de ocorrências onde isSynced = false
  Future<List<OccurrenceModel>> getPendingOccurrences() async {
    return await _database.getPendingSync();
  }

  /// Marca uma ocorrência como sincronizada
  /// Atualiza o campo isSynced e registra a data de sincronização
  Future<void> markAsSynced(int id) async {
    await _database.markAsSynced(id);
  }

  /// Remove uma ocorrência do banco de dados
  /// Usado após sincronização bem-sucedida
  Future<void> deleteOccurrence(int id) async {
    await _database.delete(id);
  }
}

