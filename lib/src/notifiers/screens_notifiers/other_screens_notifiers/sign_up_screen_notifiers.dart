import 'dart:io';

import 'package:flutter/foundation.dart';

class SignUpScreenNotifiers with ChangeNotifier {
  File _personalImage;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  int _userType = 1;

  File get personalImage => _personalImage;

  set personalImage(File value) {
    _personalImage = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  set isConfirmPasswordVisible(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  int get userType => _userType;

  set userType(int value) {
    _userType = value;
    notifyListeners();
  }
}
