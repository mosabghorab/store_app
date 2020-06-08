import 'package:storeapp/src/utils/constants.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _password;
  int _type;
  String _personalImage;

  User({
    int id,
    String name,
    String email,
    String password,
    int type,
    String personalImage,
  }) {
    this._email = email;
    this._id = id;
    this._name = name;
    this._password = password;
    this._personalImage = personalImage;
    this._type = type;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json[Constants.APP_DATABASE_FIELD_USERS_ID],
        name: json[Constants.APP_DATABASE_FIELD_USERS_NAME],
        email: json[Constants.APP_DATABASE_FIELD_USERS_EMAIL],
        password: json[Constants.APP_DATABASE_FIELD_USERS_PASSWORD],
        type: json[Constants.APP_DATABASE_FIELD_USERS_TYPE],
        personalImage: json[Constants.APP_DATABASE_FIELD_USERS_PERSONAL_IMAGE],
      );

  Map<String, dynamic> toJson() => {
//        Constants.APP_DATABASE_FIELD_USERS_ID: _id,
        Constants.APP_DATABASE_FIELD_USERS_NAME: _name,
        Constants.APP_DATABASE_FIELD_USERS_EMAIL: _email,
        Constants.APP_DATABASE_FIELD_USERS_PASSWORD: _password,
        Constants.APP_DATABASE_FIELD_USERS_TYPE: _type,
        Constants.APP_DATABASE_FIELD_USERS_PERSONAL_IMAGE: _personalImage,
      };

  String get personalImage => _personalImage;

  set personalImage(String value) {
    _personalImage = value;
  }

  int get type => _type;

  set type(int value) {
    _type = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
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
