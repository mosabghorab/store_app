import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/auth_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/storage_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/other_screens_notifiers/sign_up_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/dialogs/image_source_dialog.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SignUpScreenNotifiers>(
        create: (_) => SignUpScreenNotifiers(),
        child: SignUpScreenBody(),
      ),
    );
  }
}

class SignUpScreenBody extends StatefulWidget {
  @override
  _SignUpScreenBodyState createState() => _SignUpScreenBodyState();
}

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  SignUpScreenNotifiers _signUpScreenNotifiers;
  AuthController _authController;
  StorageController _storageController;

  String _name;
  String _email;
  String _password;
  String _confirmPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey();
    _scaffoldKey = GlobalKey();
    _authController = AuthController.instance;
    _storageController = StorageController.instance;
    _signUpScreenNotifiers =
        Provider.of<SignUpScreenNotifiers>(context, listen: false);
  }

  // ||.. get user personal image from [ Gallery | Camera ] ..||
  void _getPersonalImage(ImageSource imageSource) async {
    Navigator.pop(context);
    if (imageSource == ImageSource.gallery)
      _signUpScreenNotifiers.personalImage =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      _signUpScreenNotifiers.personalImage =
          await ImagePicker.pickImage(source: ImageSource.camera);
  }

  // ||.. create new user ..||
  void _createUser() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    try {
      if (_confirmPassword != _password) {
        Helpers.showMessage('Confirm password does not match password',
            MessageType.MESSAGE_FAILED);
        return;
      }
      _signUpScreenNotifiers.isLoading = true;
      String _personalImagePath;
      if (_signUpScreenNotifiers.personalImage != null) {
        _personalImagePath = await _storageController.uploadFile(
          '${Constants.FIREBASE_STORAGE_USERS_IMAGES_PATH}${_name}_${DateTime.now().millisecondsSinceEpoch}',
          _signUpScreenNotifiers.personalImage,
        );
      }
      await _authController.createUserWithEmailAndPassword(_email, _password,
          _name, _personalImagePath, _signUpScreenNotifiers.userType);
      _signUpScreenNotifiers.isLoading = false;
      if (_signUpScreenNotifiers.userType ==
          Helpers.getUserType(UserType.USER_TYPE_MERCHANT))
        Navigator.pushNamedAndRemoveUntil(
          context,
          Constants.SCREENS_DASHBOARD_SCREEN,
          (_) => false,
        );
      else
        Navigator.pushNamedAndRemoveUntil(
          context,
          Constants.SCREENS_HOME_SCREEN,
          (_) => false,
        );
    } catch (error) {
      _signUpScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Selector<SignUpScreenNotifiers, bool>(
                selector: (_, value) => value.isLoading,
                builder: (_, isLoading, __) => _signUpScreenNotifiers.isLoading
                    ? LinearProgressIndicator()
                    : Container(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: AppStyles.defaultPadding3,
                alignment: Alignment.center,
                child: Text(
                  AppShared.appLang['SignUp'],
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 45,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
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
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState.showBottomSheet(
                                        (_) => ImageSourceDialog(
                                          onCameraTap: () {
                                            _getPersonalImage(
                                                ImageSource.camera);
                                          },
                                          onGalleryTap: () {
                                            _getPersonalImage(
                                                ImageSource.gallery);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child:
                                          Selector<SignUpScreenNotifiers, File>(
                                        selector: (_, value) =>
                                            value.personalImage,
                                        builder: (_, personalImage, __) =>
                                            personalImage == null
                                                ? Icon(
                                                    Icons.person,
                                                    size: 70,
                                                    color: Colors.blue,
                                                  )
                                                : Container(
                                                    height: 130,
                                                    width: 130,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(
                                                        personalImage,
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text('Account Type : '),
                                  ),
                                  Selector<SignUpScreenNotifiers, int>(
                                    selector: (_, value) => value.userType,
                                    builder: (_, userType, __) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Radio(
                                              value: Constants.USER_TYPE_CLIENT,
                                              groupValue: userType,
                                              onChanged: (value) {
                                                _signUpScreenNotifiers
                                                    .userType = value;
                                              },
                                            ),
                                            Text('Client')
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Radio(
                                              value:
                                                  Constants.USER_TYPE_MERCHANT,
                                              groupValue: userType,
                                              onChanged: (value) {
                                                _signUpScreenNotifiers
                                                    .userType = value;
                                              },
                                            ),
                                            Text('Merchant')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'Enter full name',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "This field is required";
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _name = value;
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText:
                                          AppShared.appLang['EmailAddress'],
                                      hintText: AppShared
                                          .appLang['EnterEmailAddress'],
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
                                  Selector<SignUpScreenNotifiers, bool>(
                                    selector: (_, value) =>
                                        value.isPasswordVisible,
                                    builder: (_, isPasswordVisible, __) =>
                                        (TextFormField(
                                      keyboardType: TextInputType.text,
                                      obscureText: !isPasswordVisible,
                                      decoration: InputDecoration(
                                        labelText:
                                            AppShared.appLang['Password'],
                                        hintText:
                                            AppShared.appLang['EnterPassword'],
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _signUpScreenNotifiers
                                                    .isPasswordVisible =
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
                                    )),
                                  ),
                                  Selector<SignUpScreenNotifiers, bool>(
                                    selector: (_, value) =>
                                        value.isConfirmPasswordVisible,
                                    builder:
                                        (_, isConfirmPasswordVisible, __) =>
                                            TextFormField(
                                      obscureText: !isConfirmPasswordVisible,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm password',
                                        hintText:
                                            AppShared.appLang['EnterPassword'],
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            _signUpScreenNotifiers
                                                    .isConfirmPasswordVisible =
                                                !isConfirmPasswordVisible;
                                          },
                                          child: Icon(
                                            isConfirmPasswordVisible
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
                                        _confirmPassword = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                        onPressed: _createUser,
                        color: Colors.blue,
                        child: Text(
                          AppShared.appLang['SignUp'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
