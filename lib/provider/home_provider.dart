import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeProvider with ChangeNotifier {
  int _selectedSectionIndex = 0;
  String selectedSectionName = '';

  String firstName = ''; // Use firstName instead of fullName

  int get selectedSectionIndex => _selectedSectionIndex;

  void showLoading() {
    Center(
        child: LoadingAnimationWidget.threeArchedCircle(
      color: Colors.black,
      size: 30,
    ));
    notifyListeners();
  }

  void updateSelectedSection(int index, String name) {
    _selectedSectionIndex = index;
    selectedSectionName = name;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        String fullName = documentSnapshot['fullName'] ?? '';
        firstName = fullName.split(' ').first; // Extract first name
      }
    } catch (e) {
      return;
    }
    notifyListeners();
  }
}
