//||... File for app routes ...||
import 'package:flutter/cupertino.dart';
import 'package:storeapp/src/views/screens/home_screen/home_screen.dart';
import 'package:storeapp/src/views/screens/sign_in_screen.dart';
import 'package:storeapp/src/views/screens/sign_up_screen.dart';
import 'package:storeapp/src/views/screens/splash_screen.dart';

import 'constants.dart';

Map<String, Widget Function(BuildContext context)> appRoutes = {
  Constants.SCREENS_HOME_SCREEN: (_) => HomeScreen(),
  Constants.SCREENS_SIGN_IN_SCREEN: (_) => SignInScreen(),
  Constants.SCREENS_SIGN_UP_SCREEN: (_) => SignUpScreen(),
  Constants.SCREENS_SPLASH_SCREEN: (_) => SplashScreen(),
};
