import 'package:flutter/material.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/user_controller.dart';
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
  UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController = UserController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _userController.logoutUser();
              Navigator.pushReplacementNamed(
                  context, Constants.SCREENS_SPLASH_SCREEN);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: ListView(
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
//                  Navigator.pushNamed(
//                      context, Constants.SCREENS_CONTINENT_VIDEOS_SCREEN);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, Constants.SCREENS_CATEGORIES_SCREEN);
                },
                child: Container(
                  height: AppShared.screenUtil.setHeight(700),
                  width: 250,
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
                      Text('Categories'),
                      Image.asset(
                        '${Constants.ASSETS_IMAGES_PATH}categories.png',
                        width: 150,
                        height: 150,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
