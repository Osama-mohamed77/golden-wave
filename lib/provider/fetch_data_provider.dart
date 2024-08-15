import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FetchDataProvider with ChangeNotifier {
  String fullName = '';
  String email = '';
  String phoneNumber = '';

  Future<void> fetchData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        fullName = documentSnapshot['fullName'];
        email = documentSnapshot['email'];
        phoneNumber = documentSnapshot['phoneNumber'];
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateFullname(String newFullName) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'fullName': newFullName});
      fullName = newFullName;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'phoneNumber': newPhoneNumber});
      phoneNumber = newPhoneNumber;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
