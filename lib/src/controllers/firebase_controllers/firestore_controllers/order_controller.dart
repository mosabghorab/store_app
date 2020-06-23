import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/addresses_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/order_product_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/user_controller.dart';
import 'package:storeapp/src/models/local_models/order.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderController {
  static OrderController _instance;
  UserController _userController;
  AddressController _addressController;
  OrderProductController _orderProductController;
  CollectionReference _orderReference;

  //||... private constructor ...||
  OrderController._() {
    _userController = UserController.instance;
    _addressController = AddressController.instance;
    _orderProductController = OrderProductController.instance;
    _orderReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_ORDERS);
  }

  // ||.. singleton pattern ..||
  static OrderController get instance {
    if (_instance != null) return _instance;
    return _instance = OrderController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  Future<void> createOrder(Order order) {
    return _orderReference.document().setData(order.toJson());
  }

  Future<List<Order>> getOrdersForClient(String clientId) async {
    QuerySnapshot querySnapshot = await _orderReference
        .where(Constants.FIREBASE_ORDERS_FIELD_CLIENT_ID, isEqualTo: clientId)
        .getDocuments();
    List<Order> orders = querySnapshot.documents
        .map((o) => Order.fromJson(o.data)..id = o.documentID)
        .toList();
    orders.forEach((o) async {
      o.client = await _userController.getUser(o.clientId);
      o.address = await _addressController.getAddress(o.addressId);
      o.merchant = await _userController.getUser(o.merchantId);
      o.orderProducts =
          await _orderProductController.getAllOrderProductsForOrder(o.id);
    });
    return orders;
  }
}
