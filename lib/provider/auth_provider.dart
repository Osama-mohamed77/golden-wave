import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golden_wave/utils/my_user.dart';

class AuthProviderOS with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  bool get isSignIn => currentUser != null;

  bool isLoading = false;
  bool isUsernameTaken = false;
  bool isCheckingUsername = false;
  String errorMessage = '';

  Future<void> signIn(String email, String password) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await MyUser().getUserProfile();
      }
    } on FirebaseAuthException catch (e) {
      errorMessage =
          e.message ?? 'An unknown error occurred. Please try again later.';
      print(e.message);

      throw Exception(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String phoneNumber, String password,
      String fullName) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber
        },
      );
    } on FirebaseAuthException catch (e) {
      
        errorMessage = e.message ?? 'An error occurred. Please try again.';
      
      
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyAccount() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
