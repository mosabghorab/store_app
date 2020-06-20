import 'package:storeapp/src/utils/constants.dart';

class User {
  String _uid;
  String _name;
  String _email;
  String _password;
  int _type;
  String _personalImage;

  User({
    String uid,
    String name,
    String email,
    String password,
    int type,
    String personalImage,
  }) {
    this._email = email;
    this._uid = uid;
    this._name = name;
    this._password = password;
    this._personalImage = personalImage;
    this._type = type;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json[Constants.FIREBASE_USERS_FIELD_UID],
        name: json[Constants.FIREBASE_USERS_FIELD_NAME],
        email: json[Constants.FIREBASE_USERS_FIELD_EMAIL],
        password: json[Constants.FIREBASE_USERS_FIELD_PASSWORD],
        type: json[Constants.FIREBASE_USERS_FIELD_TYPE],
        personalImage: json[Constants.FIREBASE_USERS_FIELD_PERSONAL_IMAGE],
      );

  Map<String, dynamic> toJson() => {
//        Constants.FIREBASE_USERS_FIELD_UID: _uid,
        Constants.FIREBASE_USERS_FIELD_NAME: _name,
        Constants.FIREBASE_USERS_FIELD_EMAIL: _email,
        Constants.FIREBASE_USERS_FIELD_PASSWORD: _password,
        Constants.FIREBASE_USERS_FIELD_TYPE: _type,
        Constants.FIREBASE_USERS_FIELD_PERSONAL_IMAGE: _personalImage,
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

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }
}
