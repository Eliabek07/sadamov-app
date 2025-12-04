import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';

class OccurrenceDatabase {
  static final OccurrenceDatabase instance = OccurrenceDatabase._init();
  static Database? _database;

  OccurrenceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('occurrences.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE occurrences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plate TEXT NOT NULL,
        photos TEXT NOT NULL,
        responsible_name TEXT,
        signature TEXT,
        created_at TEXT NOT NULL,
        synced_at TEXT,
        is_synced INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<int> insert(OccurrenceModel occurrence) async {
    final db = await database;
    return await db.insert('occurrences', occurrence.toJson());
  }

  Future<List<OccurrenceModel>> getPendingSync() async {
    final db = await database;
    final maps = await db.query(
      'occurrences',
      where: 'is_synced = ?',
      whereArgs: [0],
    );
    return maps.map((map) => OccurrenceModel.fromJson(map)).toList();
  }

  Future<void> markAsSynced(int id) async {
    final db = await database;
    await db.update(
      'occurrences',
      {
        'is_synced': 1,
        'synced_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      'occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

