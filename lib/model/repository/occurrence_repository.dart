import 'package:sadamov/model/data/occurrence/occurrence_model.dart';
import 'package:sadamov/utils/database/occurrence_database.dart';

class OccurrenceRepository {
  final OccurrenceDatabase _database = OccurrenceDatabase.instance;

  Future<int> saveOccurrence(OccurrenceModel occurrence) async {
    return await _database.insert(occurrence);
  }

  Future<List<OccurrenceModel>> getPendingOccurrences() async {
    return await _database.getPendingSync();
  }

  Future<void> markAsSynced(int id) async {
    await _database.markAsSynced(id);
  }

  Future<void> deleteOccurrence(int id) async {
    await _database.delete(id);
  }
}

