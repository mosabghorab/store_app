import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderProduct {
  String _id;
  int _quantity;
  String _productId;

  //Read Only
  Product _product;

  OrderProduct({
    String id,
    int quantity,
    String productId,
  }) {
    this._id = id;
    this._productId = productId;
    this._quantity = quantity;
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json[Constants.FIREBASE_OrderProducts_FIELD_ID],
        quantity: json[Constants.FIREBASE_OrderProducts_FIELD_QUANTITY],
        productId: json[Constants.FIREBASE_OrderProducts_FIELD_PRODUCT_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.FIREBASE_OrderProducts_FIELD_ID: _id,
        Constants.FIREBASE_OrderProducts_FIELD_QUANTITY: _quantity,
        Constants.FIREBASE_OrderProducts_FIELD_PRODUCT_ID: _productId,
      };

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }

  String get productId => _productId;

  set productId(String value) {
    _productId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }
}
