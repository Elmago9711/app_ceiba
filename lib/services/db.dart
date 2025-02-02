// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static Database? _database;

  DatabaseService._internal();

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseIfNeeded() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'Ceiba.db');
    await deleteDatabase(path);
  }

  Future<Database?> get db async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, 'Ceiba.db');

    return await openDatabase(
      fullPath,
      version: 7,
      onCreate: (Database db, int version) async {
        print("🔴 Creando tablas...");

        await db.execute('''CREATE TABLE Users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    username TEXT,
    email TEXT,
    phone TEXT,
    website TEXT
)''');

        await db.execute('''CREATE TABLE Address (
    
    userId INTEGER,
    street TEXT,
    suite TEXT,
    city TEXT,
    zipcode TEXT,
    geoId INTEGER,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
    FOREIGN KEY (geoId) REFERENCES Geo(id) ON DELETE CASCADE
)''');

        await db.execute('''CREATE TABLE Posts (
    id INTEGER PRIMARY KEY,
    userId INTEGER,
    title TEXT,
    body TEXT
)''');

        await db.execute('''CREATE TABLE Company (
    userId INTEGER,
    name TEXT,
    catchPhrase TEXT,
    bs TEXT,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
)''');

        await db.execute('''CREATE TABLE Comments (
    id INTEGER PRIMARY KEY,
    postId INTEGER,
    name TEXT,
    email TEXT,
    body TEXT
)''');

        await db.execute('''CREATE TABLE Albums (
    id INTEGER PRIMARY KEY,
    userId INTEGER,
    title TEXT
)''');

        await db.execute('''CREATE TABLE Photos (
    id INTEGER PRIMARY KEY,
    albumId INTEGER,
    title TEXT,
    url TEXT,
    thumbnailUrl TEXT
)''');

        await db.execute('''CREATE TABLE Todos (
    id INTEGER PRIMARY KEY,
    userId INTEGER,
    title TEXT,
    completed INTEGER
)''');

        await db.execute('''CREATE TABLE Geo (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lat TEXT,
  lng TEXT
)''');

        print("🔴 Tablas creadas.");
      },
    );
  }
}
