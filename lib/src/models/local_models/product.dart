import 'package:storeapp/src/models/local_models/category.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

class Product {
  String _id;
  String _name;
  double _price;
  String _image;
  String _merchantId;
  String _categoryId;
  String _description;

  // Read Only
  User _merchant;
  Category _category;

  Product({
    String id,
    String name,
    String description,
    double price,
    String merchantId,
    String categoryId,
    String image,
  }) {
    this._description = description;
    this._id = id;
    this._name = name;
    this._price = price;
    this._image = image;
    this._merchantId = merchantId;
    this._categoryId = categoryId;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json[Constants.FIREBASE_PRODUCTS_FIELD_ID],
        name: json[Constants.FIREBASE_PRODUCTS_FIELD_NAME],
        price: json[Constants.FIREBASE_PRODUCTS_FIELD_PRICE],
        description: json[Constants.FIREBASE_PRODUCTS_FIELD_DESCRIPTION],
        image: json[Constants.FIREBASE_PRODUCTS_FIELD_IMAGE],
        merchantId: json[Constants.FIREBASE_PRODUCTS_FIELD_MERCHANT_ID],
        categoryId: json[Constants.FIREBASE_PRODUCTS_FIELD_CATEGORY_ID],
      );

  Map<String, dynamic> toJson() => {
//        Constants.FIREBASE_PRODUCTS_FIELD_ID: _id,
        Constants.FIREBASE_PRODUCTS_FIELD_NAME: _name,
        Constants.FIREBASE_PRODUCTS_FIELD_PRICE: _price,
        Constants.FIREBASE_PRODUCTS_FIELD_MERCHANT_ID: _merchantId,
        Constants.FIREBASE_PRODUCTS_FIELD_DESCRIPTION: _description,
        Constants.FIREBASE_PRODUCTS_FIELD_IMAGE: _image,
        Constants.FIREBASE_PRODUCTS_FIELD_CATEGORY_ID: _categoryId,
      };

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get merchantId => _merchantId;

  set merchantId(String value) {
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

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  User get merchant => _merchant;

  set merchant(User value) {
    _merchant = value;
  }

  Category get category => _category;

  set category(Category value) {
    _category = value;
  }

  String get categoryId => _categoryId;

  set categoryId(String value) {
    _categoryId = value;
  }
}
