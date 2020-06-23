import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/controllers/firebase_controllers/firestore_controllers/category_controller.dart';
import 'package:storeapp/src/models/local_models/product.dart';
import 'package:storeapp/src/utils/constants.dart';

class ProductController {
  static ProductController _instance;
  CategoryController _categoryController;
  CollectionReference _productsReference;

  //||... private constructor ...||
  ProductController._() {
    _categoryController = CategoryController.instance;
    _productsReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_PRODUCTS);
  }

  // ||.. singleton pattern ..||
  static ProductController get instance {
    if (_instance != null) return _instance;
    return _instance = ProductController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //create new Product.
  Future<void> createProduct(Product product) async {
    await _productsReference.document().setData(product.toJson());
  }

  //get all Products.
  Future<List<Product>> getAllProducts() async {
    QuerySnapshot querySnapshot = await _productsReference.getDocuments();
    List<Product> products = querySnapshot.documents
        .map<Product>((p) => Product.fromJson(p.data)..id = p.documentID);
    products.forEach((product) async {
      product.category =
          await _categoryController.getCategory(product.categoryId);
    });
    return products;
  }

  //get Products by category.
  Future<List<Product>> getAllProductsByCategory(String categoryId) async {
    QuerySnapshot querySnapshot = await _productsReference
        .where(Constants.FIREBASE_PRODUCTS_FIELD_CATEGORY_ID,
            isEqualTo: categoryId)
        .getDocuments();
    List<Product> products = querySnapshot.documents
        .map<Product>((p) => Product.fromJson(p.data)..id = p.documentID);
    products.forEach((product) async {
      product.category =
          await _categoryController.getCategory(product.categoryId);
    });
    return products;
  }

  // get product .
  Future<Product> getProduct(String id) async {
    DocumentSnapshot documentSnapshot =
        await _productsReference.document(id).get();
    Product product = Product.fromJson(documentSnapshot.data)
      ..id = documentSnapshot.documentID;
    product.category =
        await _categoryController.getCategory(product.categoryId);
    return product;
  }

  //delete Product.
  Future<void> deleteProduct(String id) async {
    await _productsReference.document(id).delete();
  }
}
