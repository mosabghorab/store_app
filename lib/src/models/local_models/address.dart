import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class Address {
  int _id;
  String _name;
  int _streetNo;
  int _houseNo;
  int _clientId;
  String _country;
  String _city;

  User _client;

  Address({
    int id,
    String name,
    int clientId,
    int streetNo,
    int houseNo,
    String country,
    String city,
  }) {
    this._streetNo = streetNo;
    this._id = id;
    this._name = name;
    this._houseNo = houseNo;
    this._city = city;
    this._country = country;
    this._clientId = clientId;
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json[Constants.APP_DATABASE_FIELD_ADDRESSES_ID],
        name: json[Constants.APP_DATABASE_FIELD_ADDRESSES_NAME],
        clientId: json[Constants.APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID],
        city: json[Constants.APP_DATABASE_FIELD_ADDRESSES_CITY],
        country: json[Constants.APP_DATABASE_FIELD_ADDRESSES_COUNTRY],
        houseNo: json[Constants.APP_DATABASE_FIELD_ADDRESSES_HOUSE_NO],
        streetNo: json[Constants.APP_DATABASE_FIELD_ADDRESSES_STREET_NO],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_ADDRESSES_ID: _id,
        Constants.APP_DATABASE_FIELD_ADDRESSES_NAME: _name,
        Constants.APP_DATABASE_FIELD_ADDRESSES_COUNTRY: _country,
        Constants.APP_DATABASE_FIELD_ADDRESSES_CITY: _city,
        Constants.APP_DATABASE_FIELD_ADDRESSES_STREET_NO: _streetNo,
        Constants.APP_DATABASE_FIELD_ADDRESSES_HOUSE_NO: _houseNo,
        Constants.APP_DATABASE_FIELD_ADDRESSES_CLIENT_ID: _clientId,
      };

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  int get clientId => _clientId;

  set clientId(int value) {
    _clientId = value;
  }

  int get houseNo => _houseNo;

  set houseNo(int value) {
    _houseNo = value;
  }

  int get streetNo => _streetNo;

  set streetNo(int value) {
    _streetNo = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  User get client => _client;

  set client(User value) {
    _client = value;
  }
}
