import 'package:storeapp/src/controllers/local_controllers/database_controllers/addresses_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/order_details_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/user_controller.dart';
import 'package:storeapp/src/models/local_models/order.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';

class OrderController {
  static OrderController _instance;
  UserController _userController;
  AddressController _addressController;
  OrderDetailsController _orderDetailsController;

  //||... private constructor ...||
  OrderController._() {
    _userController = UserController.instance;
    _addressController = AddressController.instance;
    _orderDetailsController = OrderDetailsController.instance;
  }

  // ||.. singleton pattern ..||
  static OrderController get instance {
    if (_instance != null) return _instance;
    return _instance = OrderController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Cart Product.
  Future<int> createOrder(Order order) async {
    return await AppShared.db
        .insert(Constants.APP_DATABASE_TABLE_ORDERS, order.toJson());
  }

  //get all Cart Products.
  Future<List<Order>> getAllOrders(int clientId) async {
    List<Map> ordersJson = await AppShared.db.rawQuery(
        'SELECT * FROM ${Constants.APP_DATABASE_TABLE_ORDERS} where clientId=? order by id desc',
        [clientId]);
    List<Order> orders =
        ordersJson.map<Order>((value) => Order.fromJson(value)).toList();
    for (int i = 0; i < orders.length; i++) {
      orders[i].client = await _userController.getUser(orders[i].clientId);
      orders[i].address =
          await _addressController.getAddress(orders[i].addressId);
      orders[i].orderDetailsList = await _orderDetailsController
          .getAllOrderDetails(clientId, orders[i].id);
    }
    return orders;
  }

  //delete Cart Product.
  Future<int> deleteOrder(int id) async {
    return await AppShared.db.delete(
      Constants.APP_DATABASE_TABLE_ORDERS,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  //update Cart Product.
  Future<int> updateOrder(int id, Order order) async {
    return await AppShared.db.update(
      Constants.APP_DATABASE_TABLE_ORDERS,
      order.toJson(),
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
