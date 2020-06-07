//||... File for app routes ...||
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeapp/src/controllers/local_controllers/shared_preferences_controller.dart';
import 'package:storeapp/src/models/local_models/user.dart';

class AppShared {
  // ||... shared var for SharedPreferencesController ...||
  static SharedPreferencesController sharedPreferencesController;
  // ||... app lang ...||
  static Map<String, String> appLang;
  // ||... screen_utils ...||
  static ScreenUtil screenUtil;
  // ||... current_user ...||
  static User currentUser;
}
