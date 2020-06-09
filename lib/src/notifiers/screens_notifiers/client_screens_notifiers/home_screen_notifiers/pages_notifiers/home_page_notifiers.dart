import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/category.dart' as c;
import 'package:storeapp/src/models/local_models/product.dart';

class HomePageNotifiers with ChangeNotifier {
  bool _productsIsLoading = true;
  bool _categoriesIsLoading = true;
  int _selectedCategory = 0;

  List<c.Category> _categories;
  List<Product> _products;

  bool get productsIsLoading => _productsIsLoading;

  set productsIsLoading(bool value) {
    _productsIsLoading = value;
    notifyListeners();
  }

  List<c.Category> get categories => _categories;

  set categories(List<c.Category> value) {
    _categories = value;
  }

  bool get categoriesIsLoading => _categoriesIsLoading;

  set categoriesIsLoading(bool value) {
    _categoriesIsLoading = value;
    notifyListeners();
  }

  int get selectedCategory => _selectedCategory;

  set selectedCategory(int value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }
}
