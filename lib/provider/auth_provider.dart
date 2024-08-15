import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/utils/my_user.dart';
import 'package:iconsax/iconsax.dart';

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
      String fullName, context) async {
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
      if (e.code == 'email-already-in-use') {
        // Display your custom message for email already in use
        showMessage(
          context,
          title: S.of(context).exists,
          desText: S.of(context).existDes,
          icon: Iconsax.danger,
          iconColor: Colors.red,
          backgroundColor: MyColors.myYellow,
          textColor: Colors.black,
          titelColor: Colors.black,
          alignment: Alignment.bottomCenter,
        );
      } else {
        // Handle other FirebaseAuthException errors
        errorMessage = e.message ?? 'An error occurred. Please try again.';
      }
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
