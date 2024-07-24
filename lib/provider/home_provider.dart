import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _selectedSectionIndex = -1;
  String selectedSectionName = '';
  String firstName = '';
  bool _isLoading = false; // Add this field

  int get selectedSectionIndex => _selectedSectionIndex;
  bool get isLoading => _isLoading; // Add getter for loading state

  void showLoading() {
    _isLoading = true; // Set loading to true
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false; // Set loading to false
    notifyListeners();
  }

  void updateSelectedSection(int index, String name) {
    _selectedSectionIndex = index;
    selectedSectionName = name;
    showLoading(); // Show loading when updating section
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

  Future<void> fetchServices() async {
    // Simulate a delay for fetching services
    await Future.delayed(const Duration(seconds: 1));
    hideLoading(); // Hide loading when done
  }
}
