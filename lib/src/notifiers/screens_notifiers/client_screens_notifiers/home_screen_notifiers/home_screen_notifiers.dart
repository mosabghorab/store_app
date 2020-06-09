import 'package:flutter/foundation.dart';

class HomeScreenNotifiers with ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
