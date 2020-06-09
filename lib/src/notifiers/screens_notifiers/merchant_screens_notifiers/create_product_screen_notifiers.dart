import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/category.dart' as c;

class CreateProductScreenNotifiers with ChangeNotifier {
  List<c.Category> _categories = [];
  bool _isLoading = true;
  File _image;
  int _categoryId = 1;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  File get image => _image;

  set image(File value) {
    _image = value;
    notifyListeners();
  }

  List<c.Category> get categories => _categories;

  set categories(List<c.Category> value) {
    _categories = value;
  }

  int get categoryId => _categoryId;

  set categoryId(int value) {
    _categoryId = value;
    notifyListeners();
  }
}
