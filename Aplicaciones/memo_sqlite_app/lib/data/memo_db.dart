import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/memo.dart';

class MemoDb {
  MemoDb._();
  static final MemoDb instance = MemoDb._();

  static const _dbName = 'memos.db';
  static const _dbVersion = 1;
  static const _tableName = 'memos';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');
  }

  Future<List<Memo>> getAllMemos() async {
    final db = await database;
    final result = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );
    return result.map((map) => Memo.fromMap(map)).toList();
  }

  Future<int> insertMemo(Memo memo) async {
    final db = await database;
    return await db.insert(_tableName, memo.toMap());
  }

  Future<int> updateMemo(Memo memo) async {
    final db = await database;
    return await db.update(
      _tableName,
      memo.toMap(),
      where: 'id = ?',
      whereArgs: [memo.id],
    );
  }

  Future<int> deleteMemo(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<String> getDatabasePath() async {
    final db = await database;
    return db.path;
  }
}
