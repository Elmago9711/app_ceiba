// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  static Database? _database;

  DatabaseService._internal();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database?> get db async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, 'Ceiba.db');

    return openDatabase(
      fullPath,
      version: 1,
      onCreate: (Database db, int version) async {
       await db.execute('''CREATE TABLE Users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    username TEXT,
    email TEXT,
    phone TEXT,
    website TEXT
)''');

await db.execute('''CREATE TABLE Address (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER,
    street TEXT,
    suite TEXT,
    city TEXT,
    zipcode TEXT,
    lat TEXT,
    lng TEXT,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
)''');

await db.execute('''CREATE TABLE Company (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER,
    name TEXT,
    catchPhrase TEXT,
    bs TEXT,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
)''');

        await db.execute('''CREATE TABLE Companies (
    id INTEGER PRIMARY KEY ,
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



      },
    );
  }
}
