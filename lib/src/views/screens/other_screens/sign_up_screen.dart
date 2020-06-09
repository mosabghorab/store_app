import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/user_controller.dart';
import 'package:storeapp/src/models/local_models/user.dart';
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
  UserController _userController;

  String _name;
  String _email;
  String _password;
  String _confirmPassword;
  String _personalImageAsBase64String;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey();
    _scaffoldKey = GlobalKey();
    _userController = UserController.instance;
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
      _personalImageAsBase64String =
          base64Encode(_signUpScreenNotifiers.personalImage.readAsBytesSync());
      int result = await _userController.createUser(
        User(
          email: _email,
          password: _password,
          name: _name,
          personalImage: _personalImageAsBase64String,
          type: Helpers.getUserType(UserType.USER_TYPE_CLIENT),
        ),
      );
      _signUpScreenNotifiers.isLoading = false;
      if (result < 0) {
        Helpers.showMessage('Failed!!', MessageType.MESSAGE_FAILED);
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Constants.SCREENS_HOME_SCREEN,
          (_) => false,
        );
      }
    } catch (error) {
      _signUpScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.toString(), MessageType.MESSAGE_FAILED);
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
