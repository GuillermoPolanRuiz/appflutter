import 'package:appflutter/entities/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_sqflite_database.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE favoritos(
        id INTEGER PRIMARY KEY, 
        name TEXT NOT NULL, 
        desc TEXT NOT NULL, 
        image TEXT NOT NULL, 
        cor1 TEXT NOT NULL, 
        cor2 TEXT NOT NULL, 
        es TEXT NOT NULL, 
        price TEXT, 
        ubc TEXT)''',
    );
  }


  Future<void> insertSitio(Sitio sitio) async {
    final db = await _databaseService.database;
    await db.insert(
      'favoritos',
      sitio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Sitio>> favs() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('favoritos');
    return List.generate(maps.length, (index) => Sitio.fromMap(maps[index]));
  }


  Future<void> updateFav(Sitio sitio) async {
    final db = await _databaseService.database;
    await db.update('favoritos', sitio.toMap(), where: 'id = ?', whereArgs: [sitio.id]);
  }


  Future<void> deleteFav(int id) async {
    final db = await _databaseService.database;
    await db.delete('favoritos', where: 'id = ?', whereArgs: [id]);
  }
}