import 'package:flutter/foundation.dart';
import 'package:storeapp/src/models/local_models/address.dart';

class BillScreenNotifiers with ChangeNotifier {
  bool _isLoading = true;
  int _selectedAddress = 0;

  List<Address> _addresses;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Address> get addresses => _addresses;

  set addresses(List<Address> value) {
    _addresses = value;
  }

  int get selectedAddress => _selectedAddress;

  set selectedAddress(int value) {
    _selectedAddress = value;
    notifyListeners();
  }
}
