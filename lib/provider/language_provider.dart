import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static const _languageKey = 'language_code';
  String _language = 'en'; // Default language
  bool _isLoading = false;
  

  String get language => _language;
  bool get isLoading => _isLoading;

  LanguageProvider() {
    _loadLanguage(); 
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language =
        prefs.getString(_languageKey) ?? 'en'; 
    notifyListeners();
  }

  Future<void> setLanguageAr() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 2000)); 
    _language = 'ar';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, _language);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setLanguageEn() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 2000)); 
    _language = 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, _language);
    _isLoading = false;
    notifyListeners();
  }
}
