import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:palace_systeam_managment/core/services/database_service.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqfliteLocalDatabase implements DatabaseService {
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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
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

    await db.execute('''
    CREATE TABLE bookings(
      bookingID INTEGER PRIMARY KEY AUTOINCREMENT,
      guestName TEXT NOT NULL,
      guestName2 TEXT,
      roomID INTEGER NOT NULL,
      checkInDate TEXT NOT NULL,
      checkOutDate TEXT NOT NULL,
      nightsCount INTEGER NOT NULL,       
      pricePerNight REAL NOT NULL,
      totalPrice REAL NOT NULL,
      employeeName TEXT NOT NULL,
      paidAmount REAL NOT NULL DEFAULT 0,
      paidType TEXT NOT NULL,
      notes TEXT,
      stutasBooking TEXT,
      FOREIGN KEY (roomID) REFERENCES rooms (roomId) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE custmers(
      nationalId TEXT PRIMARY KEY,
      nameCustmer TEXT NOT NULL,
      phoneCustmer TEXT NOT NULL,
      jobCustmer TEXT NOT NULL,
      addressCustmer TEXT NOT NULL
    )
  ''');
  }

  @override
  Future<void> initialize() async {
    await database;
    log("🟢 Database initialized successfully");
  }

  @override
  Future<void> addData({
    String? docId,
    required String path,
    String? subPath,
    required Map<String, dynamic> data,
  }) async {
    final db = await database;
    await db.insert(path, data);
    log("🟢 Data inserted into '$path' => $data");
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docId,
  }) async {
    final db = await database;
    final result = await db.query(
      path,
      where: 'rowid = ?',
      whereArgs: [docId],
      limit: 1,
    );
    final exists = result.isNotEmpty;
    log("🟢 checkIfDataExists('$path', $docId) => $exists");
    return exists;
  }

  @override
  Future<void> deleteData({
    required String path,
    String? supPath,
    dynamic value,
  }) async {
    final db = await database;
    if (supPath != null) {
      log("🟢 Deleted from '$path' where $supPath = $path");
      await db.delete(path, where: '$supPath = ?', whereArgs: [value]);
    } else {
      log("🟢 Deleted database '$path'");
      await db.delete(path);
    }
  }

  @override
  Future<List<Map<String, Object?>>> getData({
    required String path,
    String? uId,
    String? subPath,
    Map<String, dynamic>? query,
  }) async {
    final db = await database;
    return await db.query(path);
  }

  @override
  Future<void> updateData({
    dynamic newVALUE,
    required Map<String, dynamic> oldVALUE,
    required String path,
    String? supPath,
  }) async {
    final db = await database;
    await db.update(
      path,
      oldVALUE,
      where: supPath != null ? '$supPath = ?' : null,
      whereArgs: supPath != null ? [oldVALUE[supPath]] : null,
    );
    log("🟢 Updated '$path' with new value => $newVALUE");
  }

  @override
  Stream streamData({required String path, Map<String, dynamic>? query}) {
    throw UnimplementedError();
  }
}
