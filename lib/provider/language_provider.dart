import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String language = 'en'; // Default language
  bool isLoading = false;

  void setLanguageAr() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 2000)); // Simulate a delay
    language = 'ar';
    isLoading = false;
    notifyListeners();
  }

  void setLanguageEn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 2000)); // Simulate a delay
    language = 'en';
    isLoading = false;
    notifyListeners();
  }
}
