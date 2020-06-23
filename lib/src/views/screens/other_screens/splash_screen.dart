import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:storeapp/src/controllers/firebase_controllers/auth_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/user_controller.dart';
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
  AuthController _authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _userController = UserController.instance;
    _authController = AuthController.instance;
    _route();
  }

  void _route() async {
    await Future.delayed(Duration(seconds: 2));
    FirebaseUser currentUser = await _authController.getCurrentUser();
    if (currentUser != null) {
      if (AppShared.sharedPreferencesController.isRememberedUser()) {
        AppShared.currentUser = await _userController.getUser(currentUser.uid);
        if (AppShared.currentUser.type ==
            Helpers.getUserType(UserType.USER_TYPE_CLIENT))
          Navigator.pushReplacementNamed(
              context, Constants.SCREENS_HOME_SCREEN);
        else
          Navigator.pushReplacementNamed(
              context, Constants.SCREENS_DASHBOARD_SCREEN);
      } else {
        _authController.signOut();
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
