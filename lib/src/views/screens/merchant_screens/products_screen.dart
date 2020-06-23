import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/product_controller.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/merchant_screens_notifiers/products_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<ProductsScreenNotifiers>(
        create: (_) => ProductsScreenNotifiers(),
        child: ProductsScreenBody(),
      ),
    );
  }
}

class ProductsScreenBody extends StatefulWidget {
  @override
  _ProductsScreenBodyState createState() => _ProductsScreenBodyState();
}

class _ProductsScreenBodyState extends State<ProductsScreenBody> {
  ProductsScreenNotifiers _productsScreenNotifiers;
  ProductController _productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController = ProductController.instance;
    _productsScreenNotifiers =
        Provider.of<ProductsScreenNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _productsScreenNotifiers.products =
        await _productController.getAllProducts();
    _productsScreenNotifiers.isLoading = false;
  }

  void _deleteProduct(index) async {
    Navigator.pop(context);
    _productsScreenNotifiers.isLoading = true;
    try {
      await _productController
          .deleteProduct(_productsScreenNotifiers.products[index].id);
      _productsScreenNotifiers.products =
          await _productController.getAllProducts();
      _productsScreenNotifiers.isLoading = false;
      Helpers.showMessage(
          'Product deleted successfully', MessageType.MESSAGE_SUCCESS);
    } catch (error) {
      _productsScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(Constants.SCREENS_CREATE_PRODUCT_SCREEN)
              .then((value) {
            _productsScreenNotifiers.isLoading = true;
            _init();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Selector<ProductsScreenNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => Container(
          padding: AppStyles.defaultPadding2,
          child: isLoading
              ? Container(
                  child: Center(
                    child: LoadingComponent(),
                  ),
                )
              : _productsScreenNotifiers.products.isEmpty
                  ? Container(
                      child: Center(
                        child: Text('No Products Found!'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _productsScreenNotifiers.products.length,
                      itemBuilder: (_, index) => Card(
                        elevation: 4,
                        child: Container(
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                _productsScreenNotifiers
                                            .products[index].image ==
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                            _productsScreenNotifiers
                                                .products[index].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_productsScreenNotifiers
                                        .products[index].name),
                                    Text(
                                        "${_productsScreenNotifiers.products[index].price} \$"),
                                    Text(
                                        "${_productsScreenNotifiers.products[index].category.name} "),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 40,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
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
                                                _deleteProduct(index);
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
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
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
