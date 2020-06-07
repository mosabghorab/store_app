import 'package:flutter/foundation.dart';

class SignInScreenNotifiers with ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isRememberMe = false;
  bool _isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }
}
