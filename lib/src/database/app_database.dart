import 'package:sqflite/sqflite.dart';
import 'package:storeapp/src/utils/constants.dart';

class AppDatabase {
  // ||.. private constructor ..||
  AppDatabase._();

  // ||. init database  .||
  static Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    try {
      return await openDatabase('$databasePath/store.db', version: 7,
          onCreate: (Database db, int version) async {
        // When creating the db, create those tables.
        await db
            .execute(Constants.APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY);
      }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
        db.execute(
            'DROP TABLE IF EXISTS ${Constants.APP_DATABASE_TABLE_CART_PRODUCTS}');
        await db
            .execute(Constants.APP_DATABASE_TABLE_CART_PRODUCTS_CREATION_QUERY);
      });
    } catch (error) {
      throw error;
    }
  }
}
