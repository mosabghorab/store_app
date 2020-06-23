import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/constants.dart';

//||... This class(Controller) for all users operations  ...||
class UserController {
  static UserController _instance;
  CollectionReference _usersReference;

  UserController._() {
    _usersReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_USERS);
  }

  static UserController get instance {
    if (_instance != null) return _instance;
    return _instance = UserController._();
  }

  //||... This method to add new user ...||
  Future<void> addUser(User user) async {
    await _usersReference.document(user.uid).setData(user.toJson());
  }

//||... This method to delete user ...||
  Future<void> deleteUser(String uid) async {
    await _usersReference.document(uid).delete();
  }

//||... This method to update an existed user ...||
  Future<void> updateUser(String uid, User user) async {
    await _usersReference.document(uid).setData(user.toJson());
  }

//||... This method to get  a specific user ...||
  Future<User> getUser(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _usersReference.document(uid).get();
    return User.fromJson(documentSnapshot.data)
      ..uid = documentSnapshot.documentID;
  }

//||... This method to get all stored users ...||
//  Stream<QuerySnapshot> getAllUsers() {
//    return _usersReference
//        .orderBy(Constants.FIREBASE_USER_FIELD_NAME)
//        .snapshots();
//  }
}
