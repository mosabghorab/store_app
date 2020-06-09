//||... Controller for controlling the shared preferences ...||
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/helpers.dart';

class SharedPreferencesController {
  static Future<SharedPreferencesController> _instance;
  static SharedPreferences _sharedPreferences;
  static Completer<SharedPreferencesController> _completer;

  // ||.. private constructor ..||
  SharedPreferencesController._();

  // ||.. singleton pattern ..||
  static Future<SharedPreferencesController> get instance async {
    if (_instance != null) return _instance;
    _completer = Completer<SharedPreferencesController>();
    await _init();
    _completer.complete(SharedPreferencesController._());
    return _instance = _completer.future;
  }

  // ||. init the shared preferences object .||
  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //       ------------------ || .. usable  methods ..|| ----------------------

  //------------- ||. app lang .||
  // get the current app lang
  String getAppLang() {
    return _sharedPreferences.getString(Constants.SHARED_APP_LANG) ??
        Constants.SHARED_APP_LANG_DEFAULT_VALUE;
  }

  // set the current app lang
  Future<void> setAppLang(String lang) async {
    await _sharedPreferences.setString(Constants.SHARED_APP_LANG, lang);
    Helpers.changeAppLang(lang);
  }

  //------------- ||. is login .||

  // get the current user login status.
  bool getIsLogin() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_LOGIN) ??
        Constants.SHARED_IS_LOGIN_DEFAULT_VALUE;
  }

  // set the current user login status.
  Future<void> setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(Constants.SHARED_IS_LOGIN, isLogin);
  }

  //------------- ||. user id .||

  // get the current user id.
  int getUserId() {
    return _sharedPreferences.getInt(Constants.SHARED_USER_ID) ??
        Constants.SHARED_USER_ID_DEFAULT_VALUE;
  }

  // set the current user id.
  Future<void> setUserId(int userId) async {
    await _sharedPreferences.setInt(Constants.SHARED_USER_ID, userId);
  }

  //------------- ||. is remember me .||

  // method for setting the user status is remembered or not  >>>
  Future<void> setRememberedUser(bool value) async {
    return _sharedPreferences.setBool(Constants.SHARED_IS_REMEMBER_ME, value);
  }

// method for getting the user status is remembered or not  >>>
  bool isRememberedUser() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_REMEMBER_ME) ??
        Constants.SHARED_REMEMBER_ME_DEFAULT_VALUE;
  }

//------------- ||. clear all shared preferences.||
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
