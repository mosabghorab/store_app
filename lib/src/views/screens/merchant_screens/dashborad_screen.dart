import 'package:flutter/material.dart';
import 'package:storeapp/src/controllers/firebase_controllers/auth_controller.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardScreenBody();
  }
}

class DashboardScreenBody extends StatefulWidget {
  @override
  _DashboardScreenBodyState createState() => _DashboardScreenBodyState();
}

class _DashboardScreenBodyState extends State<DashboardScreenBody> {
  AuthController _authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController = AuthController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () {
              _authController.signOut();
              Navigator.pushReplacementNamed(
                  context, Constants.SCREENS_SPLASH_SCREEN);
            },
            label: Text(
              'sign out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Container(
        padding: AppStyles.defaultPadding2,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Constants.SCREENS_PRODUCTS_SCREEN);
                    },
                    child: Container(
                      height: AppShared.screenUtil.setHeight(700),
                      padding: AppStyles.defaultPadding4,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Products'),
                          Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}products.png',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Constants.SCREENS_ORDERS_SCREEN);
                    },
                    child: Container(
                      height: AppShared.screenUtil.setHeight(700),
                      padding: AppStyles.defaultPadding4,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('Orders'),
                          Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}orders.png',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
