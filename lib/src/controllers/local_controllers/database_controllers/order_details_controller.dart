import 'package:storeapp/src/controllers/local_controllers/database_controllers/product_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/user_controller.dart';
import 'package:storeapp/src/models/local_models/order_details.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderDetailsController {
  static OrderDetailsController _instance;
  UserController _userController;
  ProductController _productController;

  //||... private constructor ...||
  OrderDetailsController._() {
    _userController = UserController.instance;
    _productController = ProductController.instance;
  }

  // ||.. singleton pattern ..||
  static OrderDetailsController get instance {
    if (_instance != null) return _instance;
    return _instance = OrderDetailsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Cart Product.
  Future<int> createOrderDetails(OrderDetails orderDetails) async {
    return await AppShared.db.insert(
        Constants.APP_DATABASE_TABLE_ORDERS_DETAILS, orderDetails.toJson());
  }

  //get all Cart Products.
  Future<List<OrderDetails>> getAllOrderDetails(
      int clientId, int orderId) async {
    List<Map> ordersJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_ORDERS_DETAILS} where clientId=? and orderId=?',
        [clientId, orderId]);
    List<OrderDetails> orderDetails = ordersJson
        .map<OrderDetails>((value) => OrderDetails.fromJson(value))
        .toList();
    for (int i = 0; i < orderDetails.length; i++) {
      orderDetails[i].client =
          await _userController.getUser(orderDetails[i].clientId);
      orderDetails[i].product =
          await _productController.getProduct(orderDetails[i].productId);
    }
    return orderDetails;
  }

  //delete Cart Product.
  Future<int> deleteOrderDetails(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_ORDERS_DETAILS,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //update Cart Product.
  Future<int> updateOrderDetails(int id, OrderDetails orderDetails) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_ORDERS_DETAILS,
      orderDetails.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
