import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronaapp/src/models/firebase_models/message.dart';
import 'package:coronaapp/src/utils/app_shared.dart';
import 'package:coronaapp/src/utils/constants.dart';

// This class(Controller) for all messages operations  >>>
class MessageController {
  static MessageController _instance;
  CollectionReference _usersReference;

  MessageController._() {
    _usersReference =
        Firestore.instance.collection(Constants.FIREBASE_COLLECTIONS_USERS);
  }

  static MessageController get instance {
    if (_instance != null) return _instance;
    return _instance = MessageController._();
  }

  // ||... This method to add new message ...||
  Future<void> addMessage(Message message, String receiverId) async {
    await _usersReference
        .document(AppShared.currentUser.uid)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_CHATS)
        .document(receiverId)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_MESSAGES)
        .add(message.toJson());
    message.isSender = false;
    await _usersReference
        .document(receiverId)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_CHATS)
        .document(AppShared.currentUser.uid)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_MESSAGES)
        .add(message.toJson());
  }

  // ||... This method to get the messages between 2 users ...||
  Stream<QuerySnapshot> getMessages(String receiverId) {
    return _usersReference
        .document(AppShared.currentUser.uid)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_CHATS)
        .document(receiverId)
        .collection(Constants.FIREBASE_SUB_COLLECTIONS_MESSAGES)
        .orderBy(Constants.FIREBASE_MESSAGE_FIELD_DATE, descending: true)
        .snapshots();
  }
}
