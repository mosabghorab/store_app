import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// This class for controlling the auth operations >>>
class StorageController {
  static StorageController _instance;
  StorageReference _storageReference;

  FirebaseStorage _firebaseStorage;

  // Private constructor
  StorageController._() {
    _firebaseStorage = FirebaseStorage.instance;
    _storageReference = _firebaseStorage.ref();
  }

// Singleton pattern >>>
  static StorageController get instance {
    if (_instance != null) return _instance;
    return _instance = StorageController._();
  }

  //       ------------------ || .. usable  methods ..|| ----------------------

  // method for uploading an file >>>
  Future<String> uploadFile(String filePath, File file) async {
    StorageReference _reference = _storageReference.child(filePath);
    await _reference.putFile(file).onComplete;
    String _filePath = await _reference.getDownloadURL();
    return _filePath;
  }
}
