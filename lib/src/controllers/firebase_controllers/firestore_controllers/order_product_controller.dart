import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/product_controller.dart';
import 'package:storeapp/src/models/local_models/order_products.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderProductController {
  static OrderProductController _instance;
  CollectionReference _orderReference;
  ProductController _productController;

  //||... private constructor ...||
  OrderProductController._() {
    _orderReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_ORDERS);
    _productController = ProductController.instance;
  }

  // ||.. singleton pattern ..||
  static OrderProductController get instance {
    if (_instance != null) return _instance;
    return _instance = OrderProductController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // get order products for an order.
  Future<List<OrderProduct>> getAllOrderProductsForOrder(String orderId) async {
    QuerySnapshot querySnapshot = await _orderReference
        .document(orderId)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_ORDER_PRODUCTS)
        .getDocuments();

    List<OrderProduct> orderProducts = querySnapshot.documents
        .map<OrderProduct>((document) =>
            OrderProduct.fromJson(document.data)..id = document.documentID)
        .toList();
    for (int i = 0; i < orderProducts.length; i++) {
      orderProducts[i].product =
          await _productController.getProduct(orderProducts[i].productId);
    }

    return orderProducts;
  }

  // create order products.
  Future<void> createOrderProduct(
      String orderId, OrderProduct orderProduct) async {
    await _orderReference
        .document(orderId)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_ORDER_PRODUCTS)
        .document()
        .setData(orderProduct.toJson());
  }
}
