import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/order_controller.dart';
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
        await _orderController.getAllOrders(AppShared.currentUser.id);
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
                                  title: Text('Order number ${index1 + 1}'),
                                  trailing: Container(
                                    child: Text(
                                        '${_orderPageNotifiers.orders[index1].status}'),
                                  ),
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
//                                                      _decrementCartProduct(
//                                                          index);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Icon(
                                                              Icons.minimize,
                                                              size: 17,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("2"),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
//                                                      _incrementCartProduct(
//                                                          index);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 17,
                                                            color: Colors.grey,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text('Delete product'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
//                                              _deleteCartProduct(index);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
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
