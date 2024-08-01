import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _selectedSectionIndex = -1;
  String selectedSectionName = '';
  bool _isLoading = false;

  int get selectedSectionIndex => _selectedSectionIndex;
  bool get isLoading => _isLoading;

  void showLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void updateSelectedSection(int index, String name) {
    _selectedSectionIndex = index;
    selectedSectionName = name;
    showLoading();
    notifyListeners();
  }

  void resetSelection() {
    _selectedSectionIndex = -1;
    selectedSectionName = '';
    notifyListeners();
  }

  Future<void> fetchServices() async {
    // Simulate a delay for fetching services
    await Future.delayed(const Duration(seconds: 1));
    hideLoading();
  }
}
