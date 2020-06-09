import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/user_controller.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _userController = UserController.instance;
    _route();
  }

  void _route() async {
    await Future.delayed(Duration(seconds: 2));
    if (AppShared.sharedPreferencesController.getIsLogin()) {
      if (AppShared.sharedPreferencesController.isRememberedUser()) {
        int id = AppShared.sharedPreferencesController.getUserId();
        if (id != -5) {
          AppShared.currentUser = await _userController.getUser(id);
          Navigator.pushReplacementNamed(
              context, Constants.SCREENS_HOME_SCREEN);
        } else {
          AppShared.currentUser = User(
              id: -5,
              name: 'Merchant',
              email: 'merchant@gmail.com',
              password: 'merchant',
              type: Helpers.getUserType(UserType.USER_TYPE_MERCHANT));
          Navigator.pushReplacementNamed(
              context, Constants.SCREENS_DASHBOARD_SCREEN);
        }
      } else {
        _userController.logoutUser();
        Navigator.pushReplacementNamed(
            context, Constants.SCREENS_SIGN_IN_SCREEN);
      }
    } else {
      Navigator.pushReplacementNamed(context, Constants.SCREENS_SIGN_IN_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    AppShared.screenUtil = ScreenUtil();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              '${Constants.ASSETS_IMAGES_PATH}store.png',
              width: 250,
              height: 250,
            ),
            Text(
              'STORE APP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 200,
              height: 5,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
