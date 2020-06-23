import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/models/local_models/category.dart';
import 'package:storeapp/src/utils/constants.dart';

class CategoryController {
  static CategoryController _instance;
  CollectionReference _categoriesReference;

  //||... private constructor ...||
  CategoryController._() {
    _categoriesReference = Firestore.instance
        .collection(Constants.FIREBASE_COLLECTIONS_CATEGORIES);
  }

  // ||.. singleton pattern ..||
  static CategoryController get instance {
    if (_instance != null) return _instance;
    return _instance = CategoryController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  //get all Categories.
  Stream<QuerySnapshot> getAllCategories() {
    return _categoriesReference.snapshots();
  }

  //get Category.
  Future<Category> getCategory(String id) async {
    DocumentSnapshot documentSnapshot =
        await _categoriesReference.document(id).get();
    return Category.fromJson(documentSnapshot.data)
      ..id = documentSnapshot.documentID;
  }
}
