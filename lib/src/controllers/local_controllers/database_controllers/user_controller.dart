import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';

class UserController {
  static UserController _instance;

  //||... private constructor ...||
  UserController._();

  // ||.. singleton pattern ..||
  static UserController get instance {
    if (_instance != null) return _instance;
    return _instance = UserController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new user.
  Future<int> createUser(User user) async {
    int result = await AppShared.db
        .insert(Constants.APP_DATABASE_TABLE_USERS, user.toJson());
    AppShared.sharedPreferencesController.setIsLogin(true);
    AppShared.sharedPreferencesController.setRememberedUser(true);
    AppShared.sharedPreferencesController.setUserId(result);
    AppShared.currentUser = await getUser(result);
    return result;
  }

  //login user.
  Future<User> loginUser(
      String email, String password, bool isRemembered) async {
    if (email == 'merchant@gmail.com' && password == 'merchant') {
      AppShared.sharedPreferencesController.setIsLogin(true);
      AppShared.sharedPreferencesController.setRememberedUser(isRemembered);
      AppShared.sharedPreferencesController.setUserId(-5);
      return User(
          id: -5,
          name: 'Merchant',
          email: email,
          password: password,
          type: Helpers.getUserType(UserType.USER_TYPE_MERCHANT));
    }
    List<Map> users = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS} where email = ? and password = ?',
        [email, password]);
    AppShared.sharedPreferencesController.setIsLogin(true);
    AppShared.sharedPreferencesController.setRememberedUser(isRemembered);
    AppShared.sharedPreferencesController
        .setUserId(users[0][Constants.APP_DATABASE_FIELD_USERS_ID]);
    return users.isEmpty ? null : User.fromJson(users[0]);
  }

  //logout.
  void logoutUser() {
    AppShared.sharedPreferencesController.setIsLogin(false);
    AppShared.sharedPreferencesController.setUserId(-1);
    AppShared.sharedPreferencesController.setRememberedUser(false);
  }

  //get user data.
  Future<User> getUser(int id) async {
    List<Map> users = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS} where id=?', [id]);
    return User.fromJson(users[0]);
  }

  //get all users.
  Future<User> getAllUsers() async {
    List<Map> users = await AppShared.db
        .rawQuery('SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS}');
    return User.fromJson(users[0]);
  }
}
