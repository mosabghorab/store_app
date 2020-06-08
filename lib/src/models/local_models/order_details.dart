import 'package:storeapp/src/models/local_models/order.dart';
import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderDetails {
  int _id;
  int _clientId;
  int _orderId;
  int _productId;

  Product _product;
  User _client;
  Order _order;

  OrderDetails({
    int id,
    int clientId,
    int orderId,
    int productId,
  }) {
    this._id = id;
    this._productId = productId;
    this._clientId = clientId;
    this._orderId = orderId;
  }

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json[Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_ID],
        clientId: json[Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_CLIENT_ID],
        orderId: json[Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_ORDER_ID],
        productId: json[Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_PRODUCT_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_ID: _id,
        Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_CLIENT_ID: _clientId,
        Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_ORDER_ID: _orderId,
        Constants.APP_DATABASE_FIELD_ORDERS_DETAILS_PRODUCT_ID: _productId,
      };

  Order get order => _order;

  set order(Order value) {
    _order = value;
  }

  User get client => _client;

  set client(User value) {
    _client = value;
  }

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }

  int get productId => _productId;

  set productId(int value) {
    _productId = value;
  }

  int get orderId => _orderId;

  set orderId(int value) {
    _orderId = value;
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
