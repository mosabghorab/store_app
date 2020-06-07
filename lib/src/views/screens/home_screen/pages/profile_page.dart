import 'package:flutter/material.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfilePageBody();
  }
}

class ProfilePageBody extends StatefulWidget {
  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
//  AuthController _authController;
//  UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _authController = AuthController.instance;
//    _userController = UserController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                AppShared.currentUser.personalImage != null
                    ? Container(
                        padding: AppStyles.defaultPadding1,
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(80),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(AppShared.currentUser.personalImage),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppShared.currentUser.name
                              .substring(0, 1)
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(80),
                          ),
                        ),
                      ),
                Positioned(
                  bottom: 0.0,
                  left: 30.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 20,
                    width: 20,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton.icon(
            onPressed: () {
//              _authController.signOut();
//              AppShared.currentUser.lastSeen =
//                  DateTime.now().millisecondsSinceEpoch;
//              AppShared.currentUser.status =
//                  Helpers.getUserStatus(UserStatus.OFFLINE);
//              _userController.updateUser(
//                  AppShared.currentUser.uid, AppShared.currentUser);
//              Navigator.pushReplacementNamed(
//                  context, Constants.SCREENS_SPLASH_SCREEN);
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            label: Text(
              'Sign out',
              style: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Name'),
            subtitle: Text(AppShared.currentUser.name),
            trailing: Icon(Icons.edit),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text(AppShared.currentUser.email),
            trailing: Icon(Icons.edit),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.transfer_within_a_station),
            title: Text('Status'),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Text(""),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Icon(Icons.edit),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
