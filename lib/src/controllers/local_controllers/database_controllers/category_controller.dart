import 'package:storeapp/src/models/local_models/category.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class CategoryController {
  static CategoryController _instance;

  //||... private constructor ...||
  CategoryController._();

  // ||.. singleton pattern ..||
  static CategoryController get instance {
    if (_instance != null) return _instance;
    return _instance = CategoryController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Category.
  Future<int> createCategory(Category category) async {
    return await AppShared.db
        .insert(Constants.APP_DATABASE_TABLE_CATEGORIES, category.toJson());
  }

  //get all Categories.
  Future<List<Category>> getAllCategories() async {
    List<Map> categories = await AppShared.db
        .rawQuery('SELECT * FROM ${Constants.APP_DATABASE_TABLE_CATEGORIES}');
    return categories
        .map<Category>((value) => Category.fromJson(value))
        .toList();
  }

  //get Category.
  Future<Category> getCategory(int id) async {
    List<Map> categories = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_CATEGORIES} where id=?',
        [id]);
    return Category.fromJson(categories[0]);
  }

  //delete Category.
  Future<int> deleteCategory(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_CATEGORIES,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //update Category.
  Future<int> updateCategory(int id, Category category) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_CATEGORIES,
      category.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
