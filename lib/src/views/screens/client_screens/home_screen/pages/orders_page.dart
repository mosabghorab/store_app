import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/order_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/pages_notifiers/order_page_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderPageNotifiers>(
      create: (_) => OrderPageNotifiers(),
      child: OrdersPageBody(),
    );
  }
}

class OrdersPageBody extends StatefulWidget {
  @override
  _OrdersPageBodyState createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  OrderPageNotifiers _orderPageNotifiers;
  OrderController _orderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderController = OrderController.instance;
    _orderPageNotifiers =
        Provider.of<OrderPageNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _orderPageNotifiers.orders =
        await _orderController.getAllOrdersByClientId(AppShared.currentUser.id);
    _orderPageNotifiers.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.defaultPadding2,
      child: Selector<OrderPageNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => Container(
          child: isLoading
              ? Container(
                  child: Center(
                    child: LoadingComponent(),
                  ),
                )
              : _orderPageNotifiers.orders.isEmpty
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
                        itemCount: _orderPageNotifiers.orders.length,
                        itemBuilder: (_, index1) => Card(
                          elevation: 4,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text('Order number : ${index1 + 1}'),
                                  subtitle: Text(
                                      '${DateTime.fromMillisecondsSinceEpoch(_orderPageNotifiers.orders[index1].date).toString()}'),
                                  trailing: Container(
                                    color: _orderPageNotifiers
                                                .orders[index1].status ==
                                            1
                                        ? Colors.orange
                                        : _orderPageNotifiers
                                                    .orders[index1].status ==
                                                2
                                            ? Colors.red
                                            : Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      "${_orderPageNotifiers.orders[index1].status == 1 ? 'Pending' : _orderPageNotifiers.orders[index1].status == 2 ? "Rejected" : 'Approved'}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                          _orderPageNotifiers
                                              .orders[index1].address.name,
                                          style: TextStyle(
                                            fontSize: 23,
                                          ),
                                        ),
                                        Text(
                                          "${_orderPageNotifiers.orders[index1].address.country} , ${_orderPageNotifiers.orders[index1].address.city} , ${_orderPageNotifiers.orders[index1].address.streetNo} , ${_orderPageNotifiers.orders[index1].address.houseNo}",
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text('Products'),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: ListView.builder(
                                    itemCount: _orderPageNotifiers
                                        .orders[index1].orderDetailsList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index2) => ListTile(
                                      title: Row(
                                        children: <Widget>[
                                          _orderPageNotifiers
                                                      .orders[index1]
                                                      .orderDetailsList[index2]
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
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Image.memory(
                                                      base64Decode(
                                                          _orderPageNotifiers
                                                              .orders[index1]
                                                              .orderDetailsList[
                                                                  index2]
                                                              .product
                                                              .image),
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
                                                    _orderPageNotifiers
                                                        .orders[index1]
                                                        .orderDetailsList[
                                                            index2]
                                                        .product
                                                        .name,
                                                    style: TextStyle(
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$${_orderPageNotifiers.orders[index1].orderDetailsList[index2].product.price}",
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
                                                        "${_orderPageNotifiers.orders[index1].orderDetailsList[index2].product.category.name} "),
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
    );
  }
}
