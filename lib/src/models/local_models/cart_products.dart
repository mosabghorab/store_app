import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class CartProduct {
  int _id;
  int _clientId;
  int _productId;
  int _quantity;

  User _client;
  Product _product;

  CartProduct({
    int id,
    int clientId,
    int productId,
    int quantity,
  }) {
    this._id = id;
    this._quantity = quantity;
    this._clientId = clientId;
    this._productId = productId;
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_ID],
        clientId: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_CLIENT_ID],
        quantity: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY],
        productId: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_ID: _id,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_CLIENT_ID: _clientId,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY: _quantity,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID: _productId,
      };

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }

  User get client => _client;

  set client(User value) {
    _client = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  int get productId => _productId;

  set productId(int value) {
    _productId = value;
  }

  int get clientId => _clientId;

  set clientId(int value) {
    _clientId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
