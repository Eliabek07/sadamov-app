import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sadamov/model/data/occurrence/occurrence_model.dart';

/// Singleton responsável por gerenciar o banco de dados SQLite
/// Implementa operações CRUD para ocorrências
class OccurrenceDatabase {
  static final OccurrenceDatabase instance = OccurrenceDatabase._init();
  static Database? _database;

  OccurrenceDatabase._init();

  /// Retorna a instância do banco de dados
  /// Inicializa o banco se ainda não foi criado
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('occurrences.db');
    return _database!;
  }

  /// Inicializa o banco de dados SQLite
  /// Cria o arquivo do banco no diretório padrão do sistema
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Cria a estrutura da tabela de ocorrências
  /// Executado apenas na primeira inicialização do banco
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

  /// Insere uma nova ocorrência no banco de dados
  /// Retorna o ID da ocorrência inserida
  Future<int> insert(OccurrenceModel occurrence) async {
    final db = await database;
    return await db.insert('occurrences', occurrence.toJson());
  }

  /// Busca todas as ocorrências pendentes de sincronização
  /// Retorna apenas ocorrências onde is_synced = 0
  Future<List<OccurrenceModel>> getPendingSync() async {
    final db = await database;
    final maps = await db.query(
      'occurrences',
      where: 'is_synced = ?',
      whereArgs: [0],
    );
    return maps.map((map) => OccurrenceModel.fromJson(map)).toList();
  }

  /// Marca uma ocorrência como sincronizada
  /// Atualiza is_synced para 1 e registra synced_at com timestamp atual
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

  /// Remove uma ocorrência do banco de dados pelo ID
  /// Usado após sincronização bem-sucedida
  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      'occurrences',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Fecha a conexão com o banco de dados
  /// Deve ser chamado quando o app for encerrado
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

