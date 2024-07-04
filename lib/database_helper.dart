import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'questions.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');
  }

  Future<int> insertQuestion(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('questions', row);
  }

  Future<List<Map<String, dynamic>>> queryAllQuestions() async {
    Database db = await database;
    return await db.query('questions');
  }

  Future<int> updateQuestion(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('questions', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteQuestion(int id) async {
    Database db = await database;
    return await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }
}
