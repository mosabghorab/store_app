import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/src/controllers/local_controllers/shared_preferences_controller.dart';
import 'package:storeapp/src/themes/light_theme.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/utils/routes.dart';

Future<void> _init() async {
  AppShared.sharedPreferencesController =
      await SharedPreferencesController.instance;
  Helpers.changeAppLang(AppShared.sharedPreferencesController.getAppLang());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(MyApp());
//  runApp(DevicePreview(builder: (_) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      builder: DevicePreview.appBuilder,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      title: Constants.APP_NAME,
      theme: lightTheme,
      routes: appRoutes,
      initialRoute: Constants.SCREENS_SPLASH_SCREEN,
    );
  }
}
