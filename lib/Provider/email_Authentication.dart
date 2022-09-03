import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dypimr_alumni/Provider/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/adsense/v2.dart';

import 'user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  FirebaseUser? _userFromFirebaseUser(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      if (!user.uid.isEmpty) {
        return user;
      } else {
        return Alert(message: 'Invalid Credentials');
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<dynamic> signUp(
      String email,
      String password,
      String name,
      String dob,
      String gender,
      String branch,
      String batch,
      String approvedProfileStatus,
      String userType) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(name, email, dob,
          gender, branch, batch, approvedProfileStatus, userType);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<dynamic> facultySignUp(String email, String password, String name,
      String dob, String gender, String branch, String userType) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateFacultyData(name, email, dob, gender, branch, userType);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> getUserName() async {
    var userid = _auth.currentUser!.uid;
    String? value;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(userid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      value = data?['name']; // <-- The value you want to retrieve.
      // Call setState if needed.
    }
    return value!;
  }
}
