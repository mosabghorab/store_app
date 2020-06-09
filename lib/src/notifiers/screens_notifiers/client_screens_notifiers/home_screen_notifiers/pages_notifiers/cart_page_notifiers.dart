import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/cart_products.dart';

class CartPageNotifiers with ChangeNotifier {
  bool _isLoading = true;

  List<CartProduct> _cartProducts;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<CartProduct> get cartProducts => _cartProducts;

  set cartProducts(List<CartProduct> value) {
    _cartProducts = value;
  }
}
