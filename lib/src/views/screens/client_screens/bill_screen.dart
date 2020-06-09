import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/addresses_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/cart_product_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/order_controller.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/order_details_controller.dart';
import 'package:storeapp/src/models/local_models/cart_products.dart';
import 'package:storeapp/src/models/local_models/order.dart';
import 'package:storeapp/src/models/local_models/order_details.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/bill_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

// ignore: must_be_immutable
class BillScreen extends StatelessWidget {
  List<CartProduct> cartProducts;
  @override
  Widget build(BuildContext context) {
    cartProducts = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
        child: ChangeNotifierProvider<BillScreenNotifiers>(
            create: (_) => BillScreenNotifiers(),
            child: BillScreenBody(cartProducts)));
  }
}

class BillScreenBody extends StatefulWidget {
  final List<CartProduct> cartProducts;

  BillScreenBody(this.cartProducts);

  @override
  _BillScreenBodyState createState() => _BillScreenBodyState();
}

class _BillScreenBodyState extends State<BillScreenBody> {
  BillScreenNotifiers _billScreenNotifiers;
  AddressController _addressController;
  OrderController _orderController;
  OrderDetailsController _orderDetailsController;
  CartProductController _cartProductController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController = AddressController.instance;
    _orderController = OrderController.instance;
    _cartProductController = CartProductController.instance;
    _orderDetailsController = OrderDetailsController.instance;
    _billScreenNotifiers =
        Provider.of<BillScreenNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _billScreenNotifiers.addresses =
        await _addressController.getAllAddresses(AppShared.currentUser.id);
    _billScreenNotifiers.isLoading = false;
  }

  void _createOrder() async {
    _billScreenNotifiers.isLoading = true;
    try {
      int result = await _orderController.createOrder(
        Order(
          clientId: AppShared.currentUser.id,
          addressId: _billScreenNotifiers
              .addresses[_billScreenNotifiers.selectedAddress].id,
          date: DateTime.now().millisecondsSinceEpoch,
          status: Helpers.getOrderStatus(OrderStatus.ORDER_STATUS_PENDING),
        ),
      );
      for (int i = 0; i < widget.cartProducts.length; i++) {
        await _orderDetailsController.createOrderDetails(OrderDetails(
            clientId: AppShared.currentUser.id,
            productId: widget.cartProducts[i].productId,
            orderId: result));
      }
      await _cartProductController.deleteAllCartProducts();
      _billScreenNotifiers.isLoading = false;
      if (result > 0) {
        Helpers.showMessage(
            'Order created successfully', MessageType.MESSAGE_SUCCESS);
        Navigator.pop(context);
      } else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _billScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill'),
      ),
      body: Container(
        padding: AppStyles.defaultPadding2,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                itemCount: widget.cartProducts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => Card(
                  elevation: 4,
                  child: Container(
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          widget.cartProducts[index].product.image == null
                              ? Container(
                                  height: 120,
                                  width: 120,
                                  color: Colors.red,
                                )
                              : Container(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.memory(
                                      base64Decode(widget
                                          .cartProducts[index].product.image),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    widget.cartProducts[index].product.name,
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),
                                  ),
                                  Text(
                                    "\$${widget.cartProducts[index].product.price}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[100],
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                        "${widget.cartProducts[index].product.category.name} "),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    alignment: Alignment.center,
                                    color: Colors.grey[100],
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                        "${widget.cartProducts[index].quantity} "),
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
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Addresses',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Selector<BillScreenNotifiers, bool>(
                selector: (_, value) => value.isLoading,
                builder: (_, isLoading, __) => Container(
                  child: isLoading
                      ? Container(
                          child: Center(
                            child: LoadingComponent(),
                          ),
                        )
                      : _billScreenNotifiers.addresses.isEmpty
                          ? Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_disabled,
                                      color: Colors.grey[700],
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'No Addresses Found!!',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _billScreenNotifiers.addresses.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) => Card(
                                elevation: 4,
                                child: Container(
                                  child: Selector<BillScreenNotifiers, int>(
                                    selector: (_, value) =>
                                        value.selectedAddress,
                                    builder: (_, selectedAddress, __) =>
                                        RadioListTile(
                                      value: index,
                                      groupValue: selectedAddress,
                                      onChanged: (value) {
                                        _billScreenNotifiers.selectedAddress =
                                            value;
                                      },
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            _billScreenNotifiers
                                                .addresses[index].name,
                                            style: TextStyle(
                                              fontSize: 23,
                                            ),
                                          ),
                                          Text(
                                            "${_billScreenNotifiers.addresses[index].country} , ${_billScreenNotifiers.addresses[index].city} , ${_billScreenNotifiers.addresses[index].streetNo} , ${_billScreenNotifiers.addresses[index].houseNo}",
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
                                ),
                              ),
                            ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                  ),
                  onPressed: _createOrder,
                  color: Colors.blue,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
