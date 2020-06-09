import 'package:flutter/foundation.dart' as F;
import 'package:storeapp/src/models/local_models/category.dart';

class CategoriesScreenNotifiers with F.ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
