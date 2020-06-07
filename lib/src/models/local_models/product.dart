import 'package:storeapp/src/utils/constants.dart';

class Product {
  int _id;
  String _name;
  double _price;
  String _image;
  int _merchantId;
  String _description;

  Product({
    int id,
    String name,
    String description,
    double price,
    int merchantId,
    String image,
  }) {
    this._description = description;
    this._id = id;
    this._name = name;
    this._price = price;
    this._image = image;
    this._merchantId = merchantId;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json[Constants.APP_DATABASE_FIELD_PRODUCTS_ID],
        name: json[Constants.APP_DATABASE_FIELD_PRODUCTS_NAME],
        price: json[Constants.APP_DATABASE_FIELD_PRODUCTS_PRICE],
        description: json[Constants.APP_DATABASE_FIELD_PRODUCTS_DESCRIPTION],
        image: json[Constants.APP_DATABASE_FIELD_PRODUCTS_IMAGE],
        merchantId: json[Constants.APP_DATABASE_FIELD_PRODUCTS_MERCHANT_ID],
      );

  Map<String, dynamic> toJson() => {
        Constants.APP_DATABASE_FIELD_PRODUCTS_ID: _id,
        Constants.APP_DATABASE_FIELD_PRODUCTS_NAME: _name,
        Constants.APP_DATABASE_FIELD_PRODUCTS_PRICE: _price,
        Constants.APP_DATABASE_FIELD_PRODUCTS_MERCHANT_ID: _merchantId,
        Constants.APP_DATABASE_FIELD_PRODUCTS_DESCRIPTION: _description,
        Constants.APP_DATABASE_FIELD_PRODUCTS_IMAGE: _image,
      };

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  int get merchantId => _merchantId;

  set merchantId(int value) {
    _merchantId = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
