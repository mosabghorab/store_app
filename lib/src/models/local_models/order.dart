import 'package:storeapp/src/models/local_models/address.dart';
import 'package:storeapp/src/models/local_models/order_products.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class Order {
  String _id;
  String _clientId;
  String _merchantId;
  String _addressId;
  int _status;
  int _date;
  List<OrderProducts> _orderProducts;

  // Read Only
  User _client;
  User _merchant;
  Address _address;

  Order({
    String id,
    String clientId,
    String merchantId,
    String addressId,
    int status,
    int date,
  }) {
    this._id = id;
    this._status = status;
    this._clientId = clientId;
    this._merchantId = merchantId;
    this._addressId = addressId;
    this._date = date;
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json[Constants.FIREBASE_ORDERS_FIELD_ID],
        clientId: json[Constants.FIREBASE_ORDERS_FIELD_CLIENT_ID],
        merchantId: json[Constants.FIREBASE_ORDERS_FIELD_MERCHANT_ID],
        status: json[Constants.FIREBASE_ORDERS_FIELD_STATUS],
        date: json[Constants.FIREBASE_ORDERS_FIELD_DATE],
        addressId: json[Constants.FIREBASE_ORDERS_FIELD_ADDRESS_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.FIREBASE_ORDERS_FIELD_ID: _id,
        Constants.FIREBASE_ORDERS_FIELD_CLIENT_ID: _clientId,
        Constants.FIREBASE_ORDERS_FIELD_MERCHANT_ID: _merchantId,
        Constants.FIREBASE_ORDERS_FIELD_ADDRESS_ID: _addressId,
        Constants.FIREBASE_ORDERS_FIELD_STATUS: _status,
        Constants.FIREBASE_ORDERS_FIELD_DATE: _date,
      };

  User get client => _client;

  set client(User value) {
    _client = value;
  }

  int get date => _date;

  set date(int value) {
    _date = value;
  }

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  String get clientId => _clientId;

  set clientId(String value) {
    _clientId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Address get address => _address;

  set address(Address value) {
    _address = value;
  }

  String get addressId => _addressId;

  set addressId(String value) {
    _addressId = value;
  }

  List<OrderProducts> get orderProducts => _orderProducts;

  set orderProducts(List<OrderProducts> value) {
    _orderProducts = value;
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
