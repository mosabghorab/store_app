import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:storeapp/src/utils/constants.dart';

class AppDatabase {
  Database db;

  // ||.. private constructor ..||
  AppDatabase() {
    _init();
  }

  // ||. init the app database object .||
  Future<void> _init() async {
    String databasePath = await getDatabasesPath();
    try {
      db = await openDatabase('$databasePath/store.db', version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create those tables.
        await db.execute(Constants.APP_DATABASE_TABLE_USERS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_ORDERS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_PRODUCTS_CREATION_QUERY);
        await db.execute(
            Constants.APP_DATABASE_TABLE_ORDERS_DETAILS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_ADDRESSES_CREATION_QUERY);
        await db
            .execute(Constants.APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY);
      });
    } catch (error) {
      throw error;
    }
  }
}
