import 'package:storeapp/src/utils/constants.dart';

class Category {
  int _id;
  String _name;

  Category({
    int id,
    String name,
  }) {
    this._id = id;
    this._name = name;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json[Constants.APP_DATABASE_FIELD_CATEGORIES_ID],
        name: json[Constants.APP_DATABASE_FIELD_CATEGORIES_NAME],
      );

  Map<String, dynamic> toJson() => {
        Constants.APP_DATABASE_FIELD_CATEGORIES_NAME: _name,
      };

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
