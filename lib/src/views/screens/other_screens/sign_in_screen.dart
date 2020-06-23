import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/auth_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/other_screens_notifiers/sign_in_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SignInScreenNotifiers>(
        create: (_) => SignInScreenNotifiers(),
        child: SignInScreenBody(),
      ),
    );
  }
}

class SignInScreenBody extends StatefulWidget {
  @override
  _SignInScreenBodyState createState() => _SignInScreenBodyState();
}

class _SignInScreenBodyState extends State<SignInScreenBody> {
  GlobalKey<FormState> _formKey;
  SignInScreenNotifiers _signInScreenNotifiers;
  AuthController _authController;

  String _email;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey();
    _authController = AuthController.instance;
    _signInScreenNotifiers =
        Provider.of<SignInScreenNotifiers>(context, listen: false);
  }

  // ||.. sign in ..||
  Future<void> _signInWithEmailAndPassword() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    try {
      _signInScreenNotifiers.isLoading = true;
      await _authController.signInWithEmailAndPassword(
          _email, _password, _signInScreenNotifiers.isRememberMe);
      _signInScreenNotifiers.isLoading = false;
      if (AppShared.currentUser.type ==
          Helpers.getUserType(UserType.USER_TYPE_MERCHANT))
        Navigator.pushReplacementNamed(
            context, Constants.SCREENS_DASHBOARD_SCREEN);
      else
        Navigator.pushReplacementNamed(context, Constants.SCREENS_HOME_SCREEN);
    } catch (error) {
      _signInScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          padding: AppStyles.defaultPadding3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Selector<SignInScreenNotifiers, bool>(
                  selector: (_, value) => value.isLoading,
                  builder: (_, isLoading, __) =>
                      _signInScreenNotifiers.isLoading
                          ? LinearProgressIndicator()
                          : Container(),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppShared.appLang['Login'],
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 45,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding: AppStyles.defaultPadding3,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: AppShared.appLang['EmailAddress'],
                                hintText:
                                    AppShared.appLang['EnterEmailAddress'],
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "This field is required";
                                return null;
                              },
                              onSaved: (value) {
                                _email = value;
                              },
                            ),
                            Selector<SignInScreenNotifiers, bool>(
                              selector: (_, value) => value.isPasswordVisible,
                              builder: (_, isPasswordVisible, __) =>
                                  TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: AppShared.appLang['Password'],
                                  hintText: AppShared.appLang['EnterPassword'],
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _signInScreenNotifiers.isPasswordVisible =
                                          !isPasswordVisible;
                                    },
                                    child: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "This field is required";
                                  return null;
                                },
                                onSaved: (value) {
                                  _password = value;
                                },
                              ),
                            ),
                            Selector<SignInScreenNotifiers, bool>(
                              selector: (_, value) => value.isRememberMe,
                              builder: (_, isRememberMe, __) =>
                                  CheckboxListTile(
                                value: isRememberMe,
                                onChanged: (value) {
                                  _signInScreenNotifiers.isRememberMe =
                                      !isRememberMe;
                                },
                                title: Text('Remeber me'),
                                selected: isRememberMe,
                                controlAffinity:
                                    ListTileControlAffinity.platform,
                                subtitle: Text('Remeber this account'),
                                dense: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      AppShared.appLang['ForgotPassword'],
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                    ),
                    onPressed: _signInWithEmailAndPassword,
                    color: Colors.blue,
                    child: Text(
                      AppShared.appLang['Login'],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Constants.SCREENS_SIGN_UP_SCREEN);
                    },
                    child: Text('Sign up'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
