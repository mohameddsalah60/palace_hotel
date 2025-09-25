import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  // 🟢 Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('palace_system_management.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, fileName);

    print("✅ Database created/opened at: $path");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
     CREATE TABLE rooms(
        roomId INTEGER PRIMARY KEY AUTOINCREMENT,
        typeRoom TEXT NOT NULL,
        floorRoom TEXT NOT NULL,
        descriptionRoom TEXT,
        pricePerNight INTEGER NOT NULL,
        statusRoom TEXT NOT NULL
      )
    ''');
  }

  // 🟢 Insert
  Future<int> insertData({
    required String table,
    required Map<String, dynamic> row,
  }) async {
    final db = await instance.database;
    return await db.insert(table, row);
  }

  // 🟢 Select
  Future<List<Map<String, dynamic>>> queryAllData({
    required String table,
  }) async {
    final db = await instance.database;
    return await db.query(table);
  }

  // 🟢 Update
  Future<int> updateData({
    required String table,
    required Map<String, dynamic> row,
    required String idColumn,
    required int id,
  }) async {
    final db = await instance.database;
    return await db.update(table, row, where: '$idColumn = ?', whereArgs: [id]);
  }

  // 🟢 Delete
  Future<int> deleteData({
    required String table,
    required String idColumn,
    required int id,
  }) async {
    final db = await instance.database;
    return await db.delete(table, where: '$idColumn = ?', whereArgs: [id]);
  }

  // 🟢 Close DB
  Future close() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}
