import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/src/models/local_models/user.dart';
import 'package:storeapp/src/utils/app_shared.dart';

import 'firestore_controllers/user_controller.dart';

// This class for controlling the auth operations >>>
class AuthController {
  FirebaseAuth _firebaseAuth;
  static AuthController _instance;
  static UserController _userController;

  // Private constructor
  AuthController._() {
    _firebaseAuth = FirebaseAuth.instance;
    _userController = UserController.instance;
  }

// Singleton pattern >>>
  static AuthController get instance {
    if (_instance != null) return _instance;
    return _instance = AuthController._();
  }

  //       ------------------ || .. usable  methods ..|| ----------------------

  // This will return the current user (may be null)  >>>
  Future<FirebaseUser> getCurrentUser() async {
    return _firebaseAuth.currentUser();
  }

// Create new user using email and password >>>
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
    String personalImage,
    int type,
  ) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser createdUser = authResult.user;
    User user;
    await _userController.addUser(
      user = User(
        email: email,
        password: password,
        uid: createdUser.uid,
        name: name,
        personalImage: personalImage,
        type: type,
      ),
    );
    AppShared.sharedPreferencesController.setRememberedUser(false);
    AppShared.currentUser = user;
  }

  // Sign in with email and password  >>
  Future<void> signInWithEmailAndPassword(
      String email, String password, bool isRememberMe) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser currentUser = authResult.user;
    AppShared.currentUser = await _userController.getUser(currentUser.uid);
    AppShared.sharedPreferencesController.setRememberedUser(isRememberMe);
  }

  // This will sign out the current user (make it null) >>>
  Future<void> signOut() async {
    _firebaseAuth.signOut();
    AppShared.sharedPreferencesController.setRememberedUser(false);
  }

// method for recover the user password  >>>
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
