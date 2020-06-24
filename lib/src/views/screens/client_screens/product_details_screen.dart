import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storeapp/src/controllers/local_controllers/database_controllers/cart_product_controller.dart';
import 'package:storeapp/src/models/local_models/cart_products.dart';
import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/styles/app_styles.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  Product product;

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context).settings.arguments as Product;
    return ProductDetailsScreenBody(product);
  }
}

class ProductDetailsScreenBody extends StatefulWidget {
  final Product product;

  ProductDetailsScreenBody(this.product);

  @override
  _ProductDetailsScreenBodyState createState() =>
      _ProductDetailsScreenBodyState();
}

class _ProductDetailsScreenBodyState extends State<ProductDetailsScreenBody> {
  CartProductController _cartProductController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartProductController = CartProductController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        padding: AppStyles.defaultPadding4,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: widget.product.image == null
                    ? Container(
                        height: 50,
                        color: Colors.red,
                      )
                    : Image.memory(
                        base64Decode(widget.product.image),
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${widget.product.name}',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '\$${widget.product.price}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${widget.product.description}',
                  style: TextStyle(
                    fontSize: 12,
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
                  onPressed: () async {
                    await _cartProductController.createCartProduct(
                      CartProduct(
                        productId: widget.product.id,
                        merchantId: widget.product.merchantId,
                        quantity: 1,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  child: Text(
                    'Add To Cart',
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
