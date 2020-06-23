import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/category.dart' as c;

class CreateProductScreenNotifiers with ChangeNotifier {
  List<c.Category> _categories = [];
  bool _isLoading = true;
  File _image;
  String _categoryId;

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

  String get categoryId => _categoryId;

  set categoryId(String value) {
    _categoryId = value;
    notifyListeners();
  }
}
