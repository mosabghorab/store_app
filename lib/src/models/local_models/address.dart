import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class Address {
  String _id;
  String _name;
  int _streetNo;
  int _houseNo;
  String _clientId;
  String _country;
  String _city;

  // Read Only
  User _client;

  Address({
    String id,
    String name,
    String clientId,
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
        id: json[Constants.FIREBASE_ADDRESSES_FIELD_ID],
        name: json[Constants.FIREBASE_ADDRESSES_FIELD_NAME],
        clientId: json[Constants.FIREBASE_ADDRESSES_FIELD_CLIENT_ID],
        city: json[Constants.FIREBASE_ADDRESSES_FIELD_CITY],
        country: json[Constants.FIREBASE_ADDRESSES_FIELD_COUNTRY],
        houseNo: json[Constants.FIREBASE_ADDRESSES_FIELD_HOUSE_NO],
        streetNo: json[Constants.FIREBASE_ADDRESSES_FIELD_STREET_NO],
      );

  Map<String, dynamic> toJson() => {
//        Constants.FIREBASE_ADDRESSES_FIELD_ID: _id,
        Constants.FIREBASE_ADDRESSES_FIELD_NAME: _name,
        Constants.FIREBASE_ADDRESSES_FIELD_COUNTRY: _country,
        Constants.FIREBASE_ADDRESSES_FIELD_CITY: _city,
        Constants.FIREBASE_ADDRESSES_FIELD_STREET_NO: _streetNo,
        Constants.FIREBASE_ADDRESSES_FIELD_HOUSE_NO: _houseNo,
        Constants.FIREBASE_ADDRESSES_FIELD_CLIENT_ID: _clientId,
      };

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get clientId => _clientId;

  set clientId(String value) {
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

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  User get client => _client;

  set client(User value) {
    _client = value;
  }
}
