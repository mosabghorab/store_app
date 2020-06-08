import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class Order {
  int _id;
  int _clientId;
  int _status;
  int _date;

  User _client;

  Order({
    int id,
    int clientId,
    int status,
    int date,
  }) {
    this._id = id;
    this._status = status;
    this._clientId = clientId;
    this._date = date;
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json[Constants.APP_DATABASE_FIELD_ORDERS_ID],
        clientId: json[Constants.APP_DATABASE_FIELD_ORDERS_CLIENT_ID],
        status: json[Constants.APP_DATABASE_FIELD_ORDERS_STATUS],
        date: json[Constants.APP_DATABASE_FIELD_ORDERS_DATE],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_ORDERS_ID: _id,
        Constants.APP_DATABASE_FIELD_ORDERS_CLIENT_ID: _clientId,
        Constants.APP_DATABASE_FIELD_ORDERS_STATUS: _status,
        Constants.APP_DATABASE_FIELD_ORDERS_DATE: _date,
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

  int get clientId => _clientId;

  set clientId(int value) {
    _clientId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
