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
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'flutter_sqflite_database.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {dogs} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE dogs2(id INTEGER PRIMARY KEY, name TEXT, desc TEXT, image TEXT, cor1 TEXT, cor2 TEXT, es TEXT',
    );
  }


  Future<void> insertDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.insert(
      'dogs2',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Dog>> dogs() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs2');
    return List.generate(maps.length, (index) => Dog.fromMap(maps[index]));
  }


  Future<void> updateDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.update('dogs2', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }


  Future<void> deleteDog(int id) async {
    final db = await _databaseService.database;
    await db.delete('dogs2', where: 'id = ?', whereArgs: [id]);
  }
}