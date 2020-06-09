import 'package:storeapp/src/controllers/local_controllers/database_controllers/category_controller.dart';
import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class ProductController {
  static ProductController _instance;
  CategoryController _categoryController;

  //||... private constructor ...||
  ProductController._() {
    _categoryController = CategoryController.instance;
  }

  // ||.. singleton pattern ..||
  static ProductController get instance {
    if (_instance != null) return _instance;
    return _instance = ProductController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Product.
  Future<int> createProduct(Product product) async {
    return await AppShared.db
        .insert(Constants.APP_DATABASE_TABLE_PRODUCTS, product.toJson());
  }

  //get all Products.
  Future<List<Product>> getAllProducts() async {
    List<Map> productsJson = await AppShared.db
        .rawQuery('SELECT * FROM ${Constants.APP_DATABASE_TABLE_PRODUCTS}');
    List<Product> products =
        productsJson.map<Product>((value) => Product.fromJson(value)).toList();
    for (int i = 0; i < products.length; i++) {
      products[i].category =
          await _categoryController.getCategory(products[i].categoryId);
    }
    return products;
  }

  //get all Products.
  Future<Product> getProduct(int id) async {
    List<Map> productsJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_PRODUCTS} where id=?',
        [id]);
    Product product = Product.fromJson(productsJson[0]);
    product.category =
        await _categoryController.getCategory(product.categoryId);
    return product;
  }

  //delete Product.
  Future<int> deleteProduct(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_PRODUCTS,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //update Product.
  Future<int> updateProduct(int id, Product product) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_CATEGORIES,
      product.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
