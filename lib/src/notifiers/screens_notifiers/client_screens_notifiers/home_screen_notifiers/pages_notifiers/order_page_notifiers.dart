import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/order.dart';

class OrderPageNotifiers with ChangeNotifier {
  bool _isLoading = true;

  List<Order> _orders;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Order> get orders => _orders;

  set orders(List<Order> value) {
    _orders = value;
  }
}
