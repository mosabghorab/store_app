import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class CartProduct {
  int _id;
  String _merchantId;
  String _productId;
  int _quantity;

  //Read Only
  User _merchant;
  Product _product;

  CartProduct({
    int id,
    String merchantId,
    String productId,
    int quantity,
  }) {
    this._id = id;
    this._merchantId = merchantId;
    this._productId = productId;
    this._quantity = quantity;
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_ID],
        quantity: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY],
        merchantId:
            json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_MERCHANT_ID],
        productId: json[Constants.APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_ID: _id,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_MERCHANT_ID: _merchantId,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_PRODUCT_ID: _productId,
        Constants.APP_DATABASE_FIELD_CART_PRODUCTS_QUANTITY: _quantity,
      };

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  String get productId => _productId;

  set productId(String value) {
    _productId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  User get merchant => _merchant;

  set merchant(User value) {
    _merchant = value;
  }

  String get merchantId => _merchantId;

  set merchantId(String value) {
    _merchantId = value;
  }
}
