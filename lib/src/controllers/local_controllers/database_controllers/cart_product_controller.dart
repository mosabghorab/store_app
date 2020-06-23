import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/product_controller.dart';
import 'package:storeapp/src/models/local_models/cart_products.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class CartProductController {
  static CartProductController _instance;
  ProductController _productController;

  //||... private constructor ...||
  CartProductController._() {
    _productController = ProductController.instance;
  }

  // ||.. singleton pattern ..||
  static CartProductController get instance {
    if (_instance != null) return _instance;
    return _instance = CartProductController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Cart Product.
  Future<int> createCartProduct(CartProduct cartProduct) async {
    return await AppShared.db.insert(
        Constants.APP_DATABASE_TABLE_CART_PRODUCTS, cartProduct.toJson());
  }

  //get all Cart Products.
  Future<List<CartProduct>> getAllCartProducts(int clientId) async {
    List<Map> cartProductsJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_CART_PRODUCTS} where clientId=?',
        [clientId]);
    List<CartProduct> cartProducts = cartProductsJson
        .map<CartProduct>((value) => CartProduct.fromJson(value))
        .toList();
    for (int i = 0; i < cartProducts.length; i++) {
      cartProducts[i].product =
          await _productController.getProduct(cartProducts[i].productId);
    }
    return cartProducts;
  }

  //delete Cart Product.
  Future<int> deleteCartProduct(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_CART_PRODUCTS,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //delete Cart Product.
  Future<int> deleteAllCartProducts() async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_CART_PRODUCTS,
    );
  }

  //update Cart Product.
  Future<int> updateCartProduct(int id, CartProduct cartProduct) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_CART_PRODUCTS,
      cartProduct.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
