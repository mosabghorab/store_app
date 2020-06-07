import 'dart:async';

import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Database db;

  // ||.. private constructor ..||
  AppDatabase() {
    _init();
  }

  // ||. init the app database object .||
  Future<void> _init() async {
    String databasePath = await getDatabasesPath();
    db = await openDatabase('$databasePath/store.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }
}
