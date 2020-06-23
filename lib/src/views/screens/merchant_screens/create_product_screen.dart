import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/category_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/product_controller.dart';
import 'package:storeapp/src/controllers/firebase_controllers/storage_controller.dart';
import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/notifiers/screens_notifiers/merchant_screens_notifiers/create_product_screen_notifiers.dart';
import 'package:storeapp/src/styles/app_styles.dart';
import 'package:storeapp/src/utils/app_shared.dart';
import 'package:storeapp/src/utils/constants.dart';
import 'package:storeapp/src/utils/enums.dart';
import 'package:storeapp/src/utils/helpers.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/loading_component.dart';
import 'package:storeapp/src/views/dialogs/image_source_dialog.dart';

class CreateProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<CreateProductScreenNotifiers>(
        create: (_) => CreateProductScreenNotifiers(),
        child: CreateProductScreenBody(),
      ),
    );
  }
}

class CreateProductScreenBody extends StatefulWidget {
  @override
  _CreateProductScreenBodyState createState() =>
      _CreateProductScreenBodyState();
}

class _CreateProductScreenBodyState extends State<CreateProductScreenBody> {
  CreateProductScreenNotifiers _createProductScreenNotifiers;
  ProductController _productController;
  CategoryController _categoryController;
  StorageController _storageController;
  GlobalKey<FormState> _createProductFormState;
  GlobalKey<ScaffoldState> _scaffoldKey;

  String _productName;
  String _description;
  String _image;
  double _price;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createProductFormState = GlobalKey();
    _scaffoldKey = GlobalKey();
    _productController = ProductController.instance;
    _categoryController = CategoryController.instance;
    _storageController = StorageController.instance;
    _createProductScreenNotifiers =
        Provider.of<CreateProductScreenNotifiers>(context, listen: false);
    _init();
  }

  void _init() async {
    _createProductScreenNotifiers.categories =
        await _categoryController.getAllCategories();
    _createProductScreenNotifiers.isLoading = false;
  }

  void _createProduct() async {
    if (!_createProductFormState.currentState.validate()) return;
    _createProductFormState.currentState.save();
    _createProductScreenNotifiers.isLoading = true;
    try {
      if (_createProductScreenNotifiers.image != null)
        _image = await _storageController.uploadFile(
          '${Constants.FIREBASE_STORAGE_USERS_IMAGES_PATH}${_productName}_${DateTime.now().millisecondsSinceEpoch}',
          _createProductScreenNotifiers.image,
        );
      await _productController.createProduct(
        Product(
          name: _productName,
          categoryId: _createProductScreenNotifiers.categoryId,
          description: _description,
          merchantId: AppShared.currentUser.uid,
          image: _image,
          price: _price,
        ),
      );
      _createProductScreenNotifiers.isLoading = false;
      Helpers.showMessage(
          'Product created successfully', MessageType.MESSAGE_SUCCESS);
      Navigator.pop(context);
    } catch (error) {
      _createProductScreenNotifiers.isLoading = false;
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

  // ||.. get image from [ Gallery | Camera ] ..||
  void _getImage(ImageSource imageSource) async {
    Navigator.pop(context);
    if (imageSource == ImageSource.gallery)
      _createProductScreenNotifiers.image =
          await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      _createProductScreenNotifiers.image =
          await ImagePicker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Selector<CreateProductScreenNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? Container(
                child: Center(
                  child: LoadingComponent(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Form(
                          key: _createProductFormState,
                          child: Card(
                            elevation: 4,
                            child: Container(
                              padding: AppStyles.defaultPadding3,
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      _scaffoldKey.currentState.showBottomSheet(
                                        (_) => ImageSourceDialog(
                                          onCameraTap: () {
                                            _getImage(ImageSource.camera);
                                          },
                                          onGalleryTap: () {
                                            _getImage(ImageSource.gallery);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: Selector<
                                          CreateProductScreenNotifiers, File>(
                                        selector: (_, value) => value.image,
                                        builder: (_, image, __) => image == null
                                            ? Icon(
                                                Icons.image,
                                                size: 70,
                                                color: Colors.blue,
                                              )
                                            : Container(
                                                height: 200,
                                                width: double.infinity,
                                                child: Image.file(
                                                  image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Product Name',
                                      hintText: 'Enter product name',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "This field is required";
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _productName = value;
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Price',
                                      hintText: 'Enter product price',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "This field is required";
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _price = double.parse(value);
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return "This field is required";
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _description = value;
                                    },
                                  ),
                                  Selector<CreateProductScreenNotifiers,
                                      String>(
                                    selector: (_, value) => value.categoryId,
                                    builder: (_, categoryId, __) =>
                                        DropdownButtonFormField(
                                            value: categoryId,
                                            items: _createProductScreenNotifiers
                                                .categories
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e.name),
                                                      value: e.id,
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              _createProductScreenNotifiers
                                                  .categoryId = value;
                                            }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          onPressed: _createProduct,
                          color: Colors.blue,
                          child: Text(
                            'Create',
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
      ),
    );
  }
}
