import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/product.dart';

class ProductsScreenNotifiers with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
