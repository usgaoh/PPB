import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fomus/pertanyaan.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final String tablePertanyaan = 'tablePertanyaan';
  final String columnId = 'id';
  final String columntitleController = 'titleController';
  final String columnnameController = 'nameController';
  final String columnemailController = 'emailController';
  final String columnphoneController = 'phoneController';
  final String columnquestion1Controller = 'question1Controller';
  final String columnquestion2Controller = 'question2Controller';
  final String columnquestion3Controller = 'question3Controller';

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pertanyaan.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = '''
      CREATE TABLE $tablePertanyaan (
        $columnId INTEGER PRIMARY KEY, 
        $columntitleController TEXT, 
        $columnnameController TEXT, 
        $columnemailController TEXT, 
        $columnphoneController TEXT, 
        $columnquestion1Controller TEXT, 
        $columnquestion2Controller TEXT, 
        $columnquestion3Controller TEXT
      )
    ''';
    await db.execute(sql);
  }

  Future<int?> savePertanyaan(Pertanyaan pertanyaan) async {
    var dbClient = await _db;
    return await dbClient.insert(tablePertanyaan, pertanyaan.toMap());
  }

  Future<List?> getAllPertanyaan() async {
    var dbClient = await _db;
    var result = await dbClient.query(tablePertanyaan, columns: [
      columnId,
      columntitleController,
      columnnameController,
      columnemailController,
      columnphoneController,
      columnquestion1Controller,
      columnquestion2Controller,
      columnquestion3Controller
    ]);

    return result.toList();
  }

  Future<int?> updatePertanyaan(Pertanyaan pertanyaan) async {
    var dbClient = await _db;
    return await dbClient.update(tablePertanyaan, pertanyaan.toMap(), where: '$columnId = ?', whereArgs: [pertanyaan.id]);
  }

  Future<int?> deletePertanyaan(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(tablePertanyaan, where: '$columnId = ?', whereArgs: [id]);
  }
}
