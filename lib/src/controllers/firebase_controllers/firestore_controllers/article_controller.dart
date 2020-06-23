import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronaapp/src/utils/constants.dart';

// This class(Controller) for all articles operations  >>>
class ArticleController {
  static ArticleController _instance;
  CollectionReference _articlesReference;

  ArticleController._() {
    _articlesReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_ARTICLES);
  }

  static ArticleController get instance {
    if (_instance != null) return _instance;
    return _instance = ArticleController._();
  }

  // ||... This method to get all articles ...||
  Stream<QuerySnapshot> getArticles() {
    return _articlesReference.snapshots();
  }
}
