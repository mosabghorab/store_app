import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronaapp/src/utils/constants.dart';

// This class(Controller) for all questions operations  >>>
class QuestionController {
  static QuestionController _instance;
  CollectionReference _questionsReference;

  QuestionController._() {
    _questionsReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_QUESTIONS);
  }

  static QuestionController get instance {
    if (_instance != null) return _instance;
    return _instance = QuestionController._();
  }

  // ||... This method to get all questions ...||
  Stream<QuerySnapshot> getQuestions() {
    return _questionsReference.snapshots();
  }
}
