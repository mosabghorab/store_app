import 'package:storeapp/src/utils/constants.dart';

class Category {
  String _id;
  String _name;

  Category({
    String id,
    String name,
  }) {
    this._id = id;
    this._name = name;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json[Constants.FIREBASE_CATEGORIES_FIELD_ID],
        name: json[Constants.FIREBASE_CATEGORIES_FIELD_NAME],
      );

  Map<String, dynamic> toJson() => {
        Constants.FIREBASE_CATEGORIES_FIELD_NAME: _name,
      };

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
