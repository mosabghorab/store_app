import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/cart_product_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/client_screens_notifiers/home_screen_notifiers/pages_notifiers/cart_page_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartPageNotifiers>(
      create: (_) => CartPageNotifiers(),
      child: CartPageBody(),
    );
  }
}

class CartPageBody extends StatefulWidget {
  @override
  _CartPageBodyState createState() => _CartPageBodyState();
}

class _CartPageBodyState extends State<CartPageBody> {
  CartProductController _cartProductController;
  CartPageNotifiers _cartPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartProductController = CartProductController.instance;
    _cartPageNotifiers = Provider.of<CartPageNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _cartPageNotifiers.cartProducts =
        await _cartProductController.getAllCartProducts();
    _cartPageNotifiers.isLoading = false;
  }

  void _deleteCartProduct(index) async {
    Navigator.pop(context);
    _cartPageNotifiers.isLoading = true;
    try {
      int result = await _cartProductController
          .deleteCartProduct(_cartPageNotifiers.cartProducts[index].id);
      _cartPageNotifiers.cartProducts =
          await _cartProductController.getAllCartProducts();
      _cartPageNotifiers.isLoading = false;
      if (result > 0)
        Helpers.showMessage(
            'Cart product deleted successfully', MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage('Operation failed', MessageType.MESSAGE_FAILED);
    } catch (error) {
      _cartPageNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  void _incrementCartProduct(int index) {
    _cartPageNotifiers.cartProducts[index].quantity++;
    _cartProductController.updateCartProduct(
        _cartPageNotifiers.cartProducts[index].id,
        _cartPageNotifiers.cartProducts[index]);
    _cartPageNotifiers.isLoading = true;
    _init();
  }

  void _decrementCartProduct(int index) {
    if (_cartPageNotifiers.cartProducts[index].quantity == 1) return;
    _cartPageNotifiers.cartProducts[index].quantity--;
    _cartProductController.updateCartProduct(
        _cartPageNotifiers.cartProducts[index].id,
        _cartPageNotifiers.cartProducts[index]);
    _cartPageNotifiers.isLoading = true;
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Selector<CartPageNotifiers, bool>(
      selector: (_, value) => value.isLoading,
      builder: (_, isLoading, __) => Container(
        child: isLoading
            ? Container(
                child: Center(
                  child: LoadingComponent(),
                ),
              )
            : _cartPageNotifiers.cartProducts.isEmpty
                ? Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.grey[700],
                            size: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cart is empty!!',
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
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemCount: _cartPageNotifiers.cartProducts.length,
                            itemBuilder: (_, index) => Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Text(_cartPageNotifiers
                                      .cartProducts[index].merchant.name),
                                ),
                                Card(
                                  elevation: 4,
                                  child: Container(
                                    child: ListTile(
                                      title: Row(
                                        children: <Widget>[
                                          _cartPageNotifiers.cartProducts[index]
                                                      .product.image ==
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
                                                    child: Image.network(
                                                      _cartPageNotifiers
                                                          .cartProducts[index]
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
                                                    _cartPageNotifiers
                                                        .cartProducts[index]
                                                        .product
                                                        .name,
                                                    style: TextStyle(
                                                      fontSize: 23,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$${_cartPageNotifiers.cartProducts[index].product.price}",
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
                                                        "${_cartPageNotifiers.cartProducts[index].product.category.name} "),
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
                                                            _decrementCartProduct(
                                                                index);
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
                                                        Text(
                                                            "${_cartPageNotifiers.cartProducts[index].quantity} "),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            _incrementCartProduct(
                                                                index);
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
                                                    _deleteCartProduct(index);
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
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
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
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(
                                Constants.SCREENS_BILL_SCREEN,
                                arguments: _cartPageNotifiers.cartProducts,
                              )
                                  .then((value) async {
                                _cartPageNotifiers.isLoading = true;
                                _init();
                              });
                            },
                            color: Colors.blue,
                            child: Text(
                              'Order Now',
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
