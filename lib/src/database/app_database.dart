import 'package:sqflite/sqflite.dart';
import 'package:storeapp/src/utils/constants.dart';

class AppDatabase {
  // ||.. private constructor ..||
  AppDatabase._();

  // ||. init database  .||
  static Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    try {
      return await openDatabase('$databasePath/store.db', version: 6,
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
        await db
            .execute(Constants.APP_DATABASE_TABLE_CATEGORIES_CREATION_QUERY);
      }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_USERS}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_PRODUCTS}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_CART_PRODUCTS}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_ORDERS}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_ADDRESSES}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_ORDERS_DETAILS}');
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_CATEGORIES}');
        await db.execute(Constants.APP_DATABASE_TABLE_USERS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_ORDERS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_PRODUCTS_CREATION_QUERY);
        await db.execute(
            Constants.APP_DATABASE_TABLE_ORDERS_DETAILS_CREATION_QUERY);
        await db.execute(Constants.APP_DATABASE_TABLE_ADDRESSES_CREATION_QUERY);
        await db
            .execute(Constants.APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY);
        await db
            .execute(Constants.APP_DATABASE_TABLE_CATEGORIES_CREATION_QUERY);
      });
    } catch (error) {
      throw error;
    }
  }
}
