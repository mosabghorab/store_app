import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/order_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/merchant_screens_notifiers/orders_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<OrdersScreenNotifiers>(
        create: (_) => OrdersScreenNotifiers(),
        child: OrdersScreenBody(),
      ),
    );
  }
}

class OrdersScreenBody extends StatefulWidget {
  @override
  _OrdersScreenBodyState createState() => _OrdersScreenBodyState();
}

class _OrdersScreenBodyState extends State<OrdersScreenBody> {
  OrdersScreenNotifiers _ordersScreenNotifiers;
  OrderController _orderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderController = OrderController.instance;
    _ordersScreenNotifiers =
        Provider.of<OrdersScreenNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _ordersScreenNotifiers.orders =
        await _orderController.getOrdersForMerchant(AppShared.currentUser.uid);
    _ordersScreenNotifiers.isLoading = false;
  }

  void _updateOrder(String id, int index, int status) async {
//    _ordersScreenNotifiers.isLoading = true;
//    try {
//      int result = await _orderController.updateOrder(
//        id,
//        Order(
//          clientId: _ordersScreenNotifiers.orders[index].clientId,
//          status: status,
//          date: _ordersScreenNotifiers.orders[index].date,
//          addressId: _ordersScreenNotifiers.orders[index].addressId,
//        ),
//      );
//      _ordersScreenNotifiers.orders = await _orderController.getAllOrders();
//      _ordersScreenNotifiers.isLoading = false;
//      if (result > 0)
//        Helpers.showMessage(
//            'Order updated successfully', MessageType.MESSAGE_SUCCESS);
//      else
//        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
//    } catch (error) {
//      _ordersScreenNotifiers.isLoading = false;
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Container(
        padding: AppStyles.defaultPadding2,
        child: Selector<OrdersScreenNotifiers, bool>(
          selector: (_, value) => value.isLoading,
          builder: (_, isLoading, __) => Container(
            child: isLoading
                ? Container(
                    child: Center(
                      child: LoadingComponent(),
                    ),
                  )
                : _ordersScreenNotifiers.orders.isEmpty
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.card_travel,
                                color: Colors.grey[700],
                                size: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'No Orders Found!!',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        padding: AppStyles.defaultPadding2,
                        child: ListView.builder(
                          itemCount: _ordersScreenNotifiers.orders.length,
                          itemBuilder: (_, index1) => Card(
                            elevation: 4,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Order number : ${index1 + 1}'),
                                    subtitle: Text(
                                        '${DateTime.fromMillisecondsSinceEpoch(_ordersScreenNotifiers.orders[index1].date).toString()}'),
                                    trailing: Container(
                                      width: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            color: _ordersScreenNotifiers
                                                        .orders[index1]
                                                        .status ==
                                                    1
                                                ? Colors.orange
                                                : _ordersScreenNotifiers
                                                            .orders[index1]
                                                            .status ==
                                                        2
                                                    ? Colors.red
                                                    : Colors.green,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            child: Text(
                                              "${_ordersScreenNotifiers.orders[index1].status == 1 ? 'Pending' : _ordersScreenNotifiers.orders[index1].status == 2 ? "Rejected" : 'Approved'}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          _ordersScreenNotifiers
                                                      .orders[index1].status ==
                                                  1
                                              ? Row(
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () {
                                                        _updateOrder(
                                                            _ordersScreenNotifiers
                                                                .orders[index1]
                                                                .id,
                                                            index1,
                                                            Helpers.getOrderStatus(
                                                                OrderStatus
                                                                    .ORDER_STATUS_APPROVED));
                                                      },
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _updateOrder(
                                                            _ordersScreenNotifiers
                                                                .orders[index1]
                                                                .id,
                                                            index1,
                                                            Helpers.getOrderStatus(
                                                                OrderStatus
                                                                    .ORDER_STATUS_REJECTED));
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text('Address'),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            _ordersScreenNotifiers
                                                .orders[index1].address.name,
                                            style: TextStyle(
                                              fontSize: 23,
                                            ),
                                          ),
                                          Text(
                                            "${_ordersScreenNotifiers.orders[index1].address.country} , ${_ordersScreenNotifiers.orders[index1].address.city} , ${_ordersScreenNotifiers.orders[index1].address.streetNo} , ${_ordersScreenNotifiers.orders[index1].address.houseNo}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text('Products'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      itemCount: _ordersScreenNotifiers
                                          .orders[index1].orderProducts.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index2) => ListTile(
                                        title: Row(
                                          children: <Widget>[
                                            _ordersScreenNotifiers
                                                        .orders[index1]
                                                        .orderProducts[index2]
                                                        .product
                                                        .image ==
                                                    null
                                                ? Container(
                                                    height: 120,
                                                    width: 120,
                                                    color: Colors.red,
                                                  )
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: Image.network(
                                                        _ordersScreenNotifiers
                                                            .orders[index1]
                                                            .orderProducts[
                                                                index2]
                                                            .product
                                                            .image,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Text(
                                                      _ordersScreenNotifiers
                                                          .orders[index1]
                                                          .orderProducts[index2]
                                                          .product
                                                          .name,
                                                      style: TextStyle(
                                                        fontSize: 23,
                                                      ),
                                                    ),
                                                    Text(
                                                      "\$${_ordersScreenNotifiers.orders[index1].orderProducts[index2].product.price}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Colors.grey[100],
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2,
                                                      ),
                                                      child: Text(
                                                          "${_ordersScreenNotifiers.orders[index1].orderProducts[index2].product.category.name} "),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      color: Colors.grey[100],
                                                      width: 100,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2,
                                                      ),
                                                      child: Container(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .center,
                                                          child: Text("2")),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
