import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

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
    return await AppShared.appDatabase.db
        .insert(Constants.APP_DATABASE_TABLE_USERS, user.toJson());
  }

  //login user.
  Future<User> loginUser(String email, String password) async {
    List<Map> users = await AppShared.appDatabase.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS} where email=? and password=?',
        [email, password]);
    return User.fromJson(users[0]);
  }

  //logout.
  void logoutUser() {
    AppShared.sharedPreferencesController.setIsLogin(false);
    AppShared.sharedPreferencesController.setUserId(-1);
    AppShared.sharedPreferencesController.setRememberedUser(false);
  }

  //get user data.
  Future<User> getUser(int id) async {
    List<Map> users = await AppShared.appDatabase.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS} where id=?', [id]);
    return User.fromJson(users[0]);
  }

  //get all users.
  Future<User> getAllUsers() async {
    List<Map> users = await AppShared.appDatabase.db
        .rawQuery('SELECT * FROM ${Constants.APP_DATABASE_TABLE_USERS}');
    print(users);
    return User.fromJson(users[0]);
  }
}
